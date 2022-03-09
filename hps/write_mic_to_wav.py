''' Records audio for 5 seconds and plays it back '''
import sys
import audio

if not audio.open_dev():
    sys.exit()
audio.init()
sampling_rate = audio.MIN_SAMPLING_RATE
print(sampling_rate)
audio.sampling_rate(sampling_rate)

print('Recording audio')
channels = []
for _ in range(sampling_rate * 5):
    audio.wait_read()
    channels.append(audio.read())

print('Playing back audio')
volume_multiplier = 32
max_volume = -1
for left, right in channels:
    audio.wait_write()
    if left > max_volume:
        max_volume = left
    if right > max_volume:
        max_volume = right
    if left > audio.MAX_VOLUME / volume_multiplier or right > audio.MAX_VOLUME / volume_multiplier:
        print('Max volume exceeded')
        continue
    audio.write_left(volume_multiplier * left)
    audio.write_right(volume_multiplier * right)

audio.close()
print("Exiting program, max volume={}\n".format(max_volume))
