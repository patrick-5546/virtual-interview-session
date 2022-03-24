''' Records audio for 5 seconds then:
    - Plays it back if PLAY_BACK_AUDIO is True
    - Posts wave_data as a JSON object to SERVER_ENDPOINT
'''

import audio
import json
import requests
import sys

AUDIO_TO_WAV_DIVIDER = 2**12 - 1
PLAY_BACK_AUDIO = True
SAMPLING_RATE = audio.MIN_SAMPLING_RATE  # 8000 Hz
SERVER_ENDPOINT = 'http://34.222.245.107:4000/api/audio'

if not audio.open_dev():
    sys.exit()

print('Audio will be recorded at ' + str(SAMPLING_RATE) + ' Hz')
print('Recording audio')
wave_data = []
audio.init()
audio.sampling_rate(SAMPLING_RATE)
for _ in range(SAMPLING_RATE * 5):
    audio.wait_read()
    left, _ = audio.read()
    wave_data.append(left / AUDIO_TO_WAV_DIVIDER)

if PLAY_BACK_AUDIO:
    print('Playing back audio')
    volume_multiplier = 42
    for data in wave_data:
        audio.wait_write()
        left = data * AUDIO_TO_WAV_DIVIDER * volume_multiplier
        if left > audio.MAX_VOLUME:
            print('WARN: Max volume exceeded, writing audio.MAX_VOLUME')
            left = audio.MAX_VOLUME
        audio.write_left(left)
        audio.write_right(left)

audio.close()

print('Posting wave_data')
requests.post(SERVER_ENDPOINT, data=json.dumps(wave_data))

print('Exiting program')
