import torch
import torch.nn as nn
import math
import torch.nn.functional as F
from torchvision import transforms
from PIL import Image
import sys
from io import BytesIO
import numpy as np
import base64
import pathlib


def model_static(pretrained=False, **kwargs):
    """
    Sourced from: https://github.com/rehg-lab/eye-contact-cnn
    Original Paper: https://osf.io/5a6m7/
    """
    model = ResNet([3, 4, 6, 3], **kwargs)
    if pretrained:
        model_dict = model.state_dict()
        snapshot = torch.load(pretrained, map_location=torch.device("cpu"))
        snapshot = {k: v for k, v in snapshot.items() if k in model_dict}
        model_dict.update(snapshot)
        model.load_state_dict(model_dict)
    return model


class ResNet(nn.Module):
    """
    Sourced from: https://github.com/rehg-lab/eye-contact-cnn
    Original Paper: https://osf.io/5a6m7/
    """
    def __init__(self, layers):
        super(ResNet, self).__init__()
        self.inplanes = 64
        self.conv1 = nn.Conv2d(3, 64, kernel_size=7, stride=2, padding=3,
                               bias=False)
        self.bn1 = nn.BatchNorm2d(64)
        self.relu = nn.ReLU(inplace=True)
        self.maxpool = nn.MaxPool2d(kernel_size=3, stride=2, padding=1)
        self.layer1 = self._make_layer(64, layers[0])
        self.layer2 = self._make_layer(128, layers[1], stride=2)
        self.layer3 = self._make_layer(256, layers[2], stride=2)
        self.layer4 = self._make_layer(512, layers[3], stride=2)
        self.avgpool = nn.AvgPool2d(7, stride=1)
        self.fc_theta = nn.Linear(512 * Bottleneck.expansion, 34)
        self.fc_phi = nn.Linear(512 * Bottleneck.expansion, 34)
        self.fc_ec = nn.Linear(512 * Bottleneck.expansion, 1)
        self.init_param()

    def init_param(self):
        for m in self.modules():
            if isinstance(m, nn.Conv2d):
                n = m.kernel_size[0] * m.kernel_size[1] * m.out_channels
                m.weight.data.normal_(0, math.sqrt(2./n))
            elif isinstance(m, nn.BatchNorm2d):
                m.weight.data.fill_(1)
                m.bias.data.zero_()
            elif isinstance(m, nn.Linear):
                n = m.weight.shape[0] * m.weight.shape[1]
                m.weight.data.normal_(0, math.sqrt(2./n))
                m.bias.data.zero_()

    def _make_layer(self, planes, blocks, stride=1):
        downsample = None
        layers = []

        if stride != 1 or self.inplanes != planes * Bottleneck.expansion:
            downsample = nn.Sequential(
                nn.Conv2d(self.inplanes, planes * Bottleneck.expansion,
                          kernel_size=1, stride=stride, bias=False),
                nn.BatchNorm2d(planes * Bottleneck.expansion),
            )

        layers.append(Bottleneck(self.inplanes, planes, stride, downsample))
        self.inplanes = planes * Bottleneck.expansion
        for i in range(1, blocks):
            layers.append(Bottleneck(self.inplanes, planes))

        return nn.Sequential(*layers)

    def forward(self, x):
        x = self.conv1(x)
        x = self.bn1(x)
        x = self.relu(x)
        x = self.maxpool(x)

        x = self.layer1(x)
        x = self.layer2(x)
        x = self.layer3(x)
        x = self.layer4(x)

        x = self.avgpool(x)
        x = x.view(x.size(0), -1)
        x = self.fc_ec(x)

        return x


class Bottleneck(nn.Module):
    """
    Sourced from: https://github.com/rehg-lab/eye-contact-cnn
    Original Paper: https://osf.io/5a6m7/
    """
    expansion = 4

    def __init__(self, inplanes, planes, stride=1, downsample=None):
        super(Bottleneck, self).__init__()
        self.conv1 = nn.Conv2d(inplanes, planes, kernel_size=1, bias=False)
        self.bn1 = nn.BatchNorm2d(planes)
        self.conv2 = nn.Conv2d(planes, planes, kernel_size=3,
                               stride=stride, padding=1, bias=False)
        self.bn2 = nn.BatchNorm2d(planes)
        self.conv3 = nn.Conv2d(planes, planes * 4, kernel_size=1, bias=False)
        self.bn3 = nn.BatchNorm2d(planes * 4)
        self.relu = nn.ReLU(inplace=True)
        self.downsample = downsample
        self.stride = stride

    def forward(self, x):
        residual = x

        out = self.conv1(x)
        out = self.bn1(out)
        out = self.relu(out)

        out = self.conv2(out)
        out = self.bn2(out)
        out = self.relu(out)

        out = self.conv3(out)
        out = self.bn3(out)

        if self.downsample is not None:
            residual = self.downsample(x)

        out += residual
        out = self.relu(out)

        return out


def run(base64_encoded_jpeg, model, transform):
    """
        Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
        Original Paper: https://osf.io/5a6m7/

        run() runs the model and prints the score out to the console, but this will be adapted to send the data to an endpoint

        base64_encoded_jpeg: a path to a text file containing a base64 encoded jpeg image
        model: the eye contact model
        transform: the Tensor transformation to be applied on input images
    """

    with open(base64_encoded_jpeg, "r") as f:
        data = f.read()
    frame = Image.open(BytesIO(base64.b64decode(data)))
    img = transform(frame)
    img.unsqueeze_(0)
    output = model(img)
    score = torch.sigmoid(output).item()
    print(score)


def init_model():
    """
    init_model() initializes the mdoel, loads weights, and the data transformation to be applied to input images
    """

    cnn_directory = pathlib.Path(__file__).parent
    model_weight = f"{str(cnn_directory)}/data/model_weights.pkl"

    # load model weights
    model = model_static(model_weight)
    model_dict = model.state_dict()
    snapshot = torch.load(model_weight, map_location=torch.device("cpu"))
    model_dict.update(snapshot)
    model.load_state_dict(model_dict)
    model.train(False)

    # set up data transformation
    transform = transforms.Compose([transforms.Resize(224), transforms.CenterCrop(224), transforms.ToTensor(),
                                    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])])

    return model, transform


if __name__ == "__main__":
    model, transform = init_model()

    if len(sys.argv) != 2:
        raise SyntaxError(
            "Insufficient arguments. Supply a path to a text file containing a base-64 encoded JPEG.")
    else:
        run(base64_encoded_jpeg=sys.argv[1], model=model, transform=transform)
