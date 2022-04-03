''' Calls the read_image() function compiled in an so file then
    - Posts img as a JSON object to SERVER_ENDPOINT

Reference: https://medium.com/spikelab/calling-c-functions-from-python-104e609f2804
'''
from ctypes import c_int, cdll
import json
from json import JSONEncoder
import numpy as np
from numpy.ctypeslib import ndpointer
import requests

N = 224 * 224  # length of array returned by read_image()
JSON_FN = 'img.json'
POST_TO_SERVER = False
SAVE_JSON = True
SERVER_ENDPOINT = 'http://34.222.245.107:6000/api/image'

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

img = read_image()
print("first 20 values of img:")
print(img[:20])
print('')

if POST_TO_SERVER:
    print('Posting img')
    requests.post(SERVER_ENDPOINT, data=json.dumps(img, cls=NumpyArrayEncoder))

if SAVE_JSON:
    print('Saving json file')
    with open(JSON_FN, 'w') as outfile:
        json.dump(img, outfile, cls=NumpyArrayEncoder)

print('Exiting program')
