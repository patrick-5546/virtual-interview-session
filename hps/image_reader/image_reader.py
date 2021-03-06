''' Calls the read_image() function compiled in an so file then
    - Posts img as a JSON object to SERVER_ENDPOINT
Reference: https://medium.com/spikelab/calling-c-functions-from-python-104e609f2804
'''
from ctypes import c_int, cdll
import json
from json import JSONEncoder
import numpy as np
from numpy.ctypeslib import ndpointer
import time
import requests

N = 224 * 224  # length of array returned by read_image()
JSON_FN = 'img.json'
POST_TO_SERVER = False
SAVE_JSON = True
SERVER_ENDPOINT = 'http://34.222.245.107:6000/api/image'
IMG_WIDTH = 224
IMG_HEIGHT = 224
ENCODE_DCT = False
IMG_DIMENSIONS = (IMG_WIDTH, IMG_HEIGHT)
MCU_HEIGHT = 8
MCU_WIDTH = 8
MCU_SIZE = MCU_WIDTH * MCU_HEIGHT
MCU_DIMENSIONS = (MCU_WIDTH, MCU_HEIGHT)
MCU_X_COUNT = 28
MCU_Y_COUNT = 28
MCU_TOTAL = MCU_X_COUNT * MCU_Y_COUNT


class NumpyArrayEncoder(JSONEncoder):
    def default(self, obj):
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return JSONEncoder.default(self, obj)


# need to add directory that so file is in to environment, for example:
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/root/cpen391/module2/image_reader
lib = cdll.LoadLibrary("test.so")
read_image = lib.read_image
read_image.restype = ndpointer(dtype=c_int, shape=(N,))

while True:
    img = read_image()
    print("first 20 values of img:")
    print(img[:20])
    print('')

    # split into mcus
    dct_split_by_mcus = []
    for y in range(28):
        starty = 8*y
        for x in range(28):
            startx = 8*x
            dct_split_by_mcus.append(sum([list(img[224*starty+startx + 224*i:224*starty+startx + 224*i+8]) for i in range(8)], []))

    # ----- ENCODE FIRST MCU BEFORE SENDING TO SERVER -----
    if ENCODE_DCT:
        # reform MCU data into a list of 28^2 MCUs
        dct_mcus = []
        for mcu in dct_split_by_mcus[:1]:
            current_mcu = np.reshape(mcu, MCU_DIMENSIONS)
            dct_mcus.append(current_mcu)

        dct_mcus = np.array(dct_mcus)

        encoded_data = []
        for dct in dct_mcus:
            dct_without_trailing_zeros = np.trim_zeros(filt=dct.flatten(), trim='b')
            encoded_zeros = np.array(
                [-391, MCU_SIZE - len(dct_without_trailing_zeros), -391])
            encoded_dct = np.concatenate((dct_without_trailing_zeros, encoded_zeros))
            encoded_data.append(encoded_dct)

        encoded_data = np.array(encoded_data).flatten()

        # print('encoded data')
        # print(encoded_data)
        # print('')

        # reassembling
        data = np.concatenate([encoded_data, sum(dct_split_by_mcus[1:], [])])
    else:
        data = np.array(sum(dct_split_by_mcus, []))

    print("first 20 values of data:")
    print(data[:20])
    print('')

    if POST_TO_SERVER:
        print('Posting img')
        requests.post(SERVER_ENDPOINT, data={'img': json.dumps(data, cls=NumpyArrayEncoder)})

    if SAVE_JSON:
        print('Saving json file')
        with open(JSON_FN, 'w') as outfile:
            json.dump(data, outfile, cls=NumpyArrayEncoder)

    time.sleep(5)

print('Exiting program')
