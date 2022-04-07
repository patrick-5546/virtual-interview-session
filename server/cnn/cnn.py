import torch
import torch.nn as nn
import math
from torchvision import transforms
import sys
import numpy as np
import pathlib
import numpy as np
import scipy.fft as fft
from PIL import Image as im
import ast


def model_static(pretrained=False, **kwargs):
    """
    Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
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
    Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
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
        """
        Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
        Original Paper: https://osf.io/5a6m7/
        """
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
        """
        Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
        Original Paper: https://osf.io/5a6m7/
        """
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
        """
        Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
        Original Paper: https://osf.io/5a6m7/
        """
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
    Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
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
        """
        Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
        Original Paper: https://osf.io/5a6m7/
        """
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


def decode_data(encoded_data, debug=False):
    """
    Decode_data takes in a list of numbers produced by the DE1-SoC, which contains a single MCU encoded using DCT, combined with raw image data. 
    This encoding describes a 224 pixel x 224 pixel single-channel (grayscale) image.
    The result will be a full conversion into a three-channel RGB image in decode_data().

    The singular MCU encoded by the DE1 will be encoded using the following format: [mcu data before trailing zeroes, -391, number of trailing zeroes in mcu, -391]

    Returns a PIL RGB Image. 

    Note: debug flag controls whether image is shown. 
    """
    encoded_data = np.array(ast.literal_eval(encoded_data))
    MCU_DIMENSIONS = (8, 8)
    MCU_X_COUNT = 28
    MCU_Y_COUNT = 28
    MCU_TOTAL = MCU_X_COUNT * MCU_Y_COUNT

    Y_QUANT_TABLE = np.array(
        [[16, 11, 10, 16, 24, 40, 51, 61], [12, 12, 14, 19, 26, 58, 60, 55], [14, 13, 16, 24, 40, 57, 69, 56],
         [14, 17, 22, 29, 51,
         87, 80, 62], [18, 22, 37, 56, 68, 109, 103, 77], [24, 35, 55, 64, 81, 104, 113, 92],
         [49, 64, 78, 87, 103, 121, 120, 101],
         [72, 92, 95, 98, 112, 100, 103, 99]], dtype=np.int32)

    marker_index = np.where(encoded_data == -391)

    # print(marker_index)

    # where the first -391 marker is
    if len(marker_index[0]) != 0:
        encoded_zero_start_marker = marker_index[0][0]
        # where the second -391 marker is
        encoded_zero_end_marker = marker_index[0][1]
        top_left_mcu_flat = np.concatenate((encoded_data[0:encoded_zero_start_marker], np.zeros(
            encoded_data[encoded_zero_start_marker + 1])))

        # Apart from the top left MCU, split rest of encoded data into "MCU" shaped blocks. These don't need decoding.
        raw_data_without_top_left_mcu = np.split(
            encoded_data[encoded_zero_end_marker + 1:], MCU_TOTAL - 1)
    else:
        top_left_mcu_flat = np.array(encoded_data[0:64])
        raw_data_without_top_left_mcu = np.split(
            encoded_data[64:], MCU_TOTAL - 1)
    # ------ DECODING -----
    img_mcus = []

    if len(marker_index[0]) != 0:
        # apply IDCT on the top left MCU only
        idct_input = np.reshape(
            top_left_mcu_flat, MCU_DIMENSIONS) * Y_QUANT_TABLE / 8
        inverse_dct_output = fft.idctn(idct_input, type=2, norm='ortho')
        img_mcus.append(inverse_dct_output)
    else:
        img_mcus.append(np.reshape(top_left_mcu_flat, MCU_DIMENSIONS))

    for raw_data in raw_data_without_top_left_mcu:
        img_mcus.append(np.reshape(raw_data, MCU_DIMENSIONS))

    # ----- Form Final Image ---
    img = []
    for mcu_y in range(0, MCU_Y_COUNT):
        img_row = []
        for mcu_x in range(0, MCU_X_COUNT):
            img_row.append(img_mcus[28*mcu_y + mcu_x])
        img.append(img_row)

    final_img = im.fromarray(np.asarray(np.bmat(img))).convert("RGB")
    if debug:
        final_img.show()

    return final_img


def run(encoded_dct_output, model, transform):
    """
        Sourced and adapted from: https://github.com/rehg-lab/eye-contact-cnn
        Original Paper: https://osf.io/5a6m7/

        run() takes in and decodes a DCT output from the DE1-SoC, runs the eye contact ML model and logs the score to console 

        encoded_dct_output: a path to a text file containing an encoded DCT output
        model: the eye contact model
        transform: the Tensor transformation to be applied on input images
    """

    with open(encoded_dct_output, "r") as f:
        encoded_data = f.read()

    frame = decode_data(encoded_data)
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
            "Insufficient arguments. Supply a path to a text file containing a base-64 encoded JPEG")
    else:
        # If there are keyword arguments
        run(encoded_dct_output=sys.argv[1], model=model, transform=transform)
