import torch
import torch.nn as nn
import math
import dlib
import cv2
import torch.nn.functional as F
from torchvision import transforms
from PIL import Image
from tqdm import tqdm
import sys


def model_static(pretrained=False, **kwargs):
    model = ResNet([3, 4, 6, 3], **kwargs)
    if pretrained:
        model_dict = model.state_dict()
        snapshot = torch.load(pretrained, map_location=torch.device("cpu"))
        snapshot = {k: v for k, v in snapshot.items() if k in model_dict}
        model_dict.update(snapshot)
        model.load_state_dict(model_dict)
    return model


class ResNet(nn.Module):
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


def run(input_file, model, cnn_face_detector, transform):

    cap = cv2.VideoCapture(input_file)

    if (cap.isOpened() == False):
        print("Error opening video stream or file")
        exit()

    # frame reading + processing

    while(cap.isOpened()):
        ret, frame = cap.read()
        if ret == True:
            frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
            bbox = []

            dets = cnn_face_detector(frame, 1)
            for d in tqdm(dets):
                l = d.rect.left()
                r = d.rect.right()
                t = d.rect.top()
                b = d.rect.bottom()
                # expand a bit
                l -= (r-l)*0.2
                r += (r-l)*0.2
                t -= (b-t)*0.2
                b += (b-t)*0.2
                bbox.append([l, t, r, b])

            frame = Image.fromarray(frame)
            for b in bbox:
                face = frame.crop((b))
                img = transform(face)
                img.unsqueeze_(0)

                # forward pass
                output = model(img)
                score = torch.sigmoid(output).item()

                print(score)

        else:
            break
    cap.release()
    print("Done processing image.")


def init_model():

    # from http://dlib.net/files/mmod_human_face_detector.dat.bz2
    CNN_FACE_MODEL = 'data/mmod_human_face_detector.dat'
    model_weight = 'data/model_weights.pkl'

    # load model weights
    model = model_static(model_weight)
    model_dict = model.state_dict()
    snapshot = torch.load(model_weight, map_location=torch.device("cpu"))
    model_dict.update(snapshot)
    model.load_state_dict(model_dict)
    model.train(False)

    cnn_face_detector = dlib.cnn_face_detection_model_v1(CNN_FACE_MODEL)

    # set up data transformation
    transform = transforms.Compose([transforms.Resize(224), transforms.CenterCrop(224), transforms.ToTensor(),
                                    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])])

    return model, cnn_face_detector, transform


def run_single_images(model, cnn_face_detector, transform):

    run(input_file=f'/data/test_imgs/1_resized.jpg',
        model=model,
        cnn_face_detector=cnn_face_detector,
        transform=transform)


if __name__ == "__main__":
    model, cnn_face_detector, transform = init_model()
    if len(sys.argv) == 1:
        raise SyntaxError("Insufficient arguments. Must supply a path")
    if len(sys.argv) == 2:
        # If there are keyword arguments
        run(input_file=sys.argv[1], model=model,
            cnn_face_detector=cnn_face_detector, transform=transform)
    else:
        # If there are no keyword arguments
        run_single_images(
            model=model, cnn_face_detector=cnn_face_detector, transform=transform)
