''' Records audio for 5 seconds then:
    - Plays it back if PLAY_BACK_AUDIO is True
'''

import sys
import audio
import struct

SAMPLING_RATE = audio.MIN_SAMPLING_RATE  # 8000 Hz
PLAY_BACK_AUDIO = True
AUDIO_TO_WAV_DIVIDER = 2**12 - 1

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

print('Exiting program')
