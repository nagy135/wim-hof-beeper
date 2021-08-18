from pydub import AudioSegment
from pydub.playback import play
from time import sleep

# SETTINGS

# generate sound
# ffmpeg -f lavfi -i "sine=frequency=1027:duration=1" c.mp3 
c = AudioSegment.from_mp3("sounds/c.mp3")
d = AudioSegment.from_mp3("sounds/d.mp3")
e = AudioSegment.from_mp3("sounds/e.mp3")
f = AudioSegment.from_mp3("sounds/f.mp3")
g = AudioSegment.from_mp3("sounds/g.mp3")
a = AudioSegment.from_mp3("sounds/a.mp3")
h = AudioSegment.from_mp3("sounds/h.mp3")

BEEP_LENGTH=1

EPOCHS=3
CYCLES=3

HOLD_AFTER_EXHALE=10
HOLD_AFTER_INHALE=5


# START

for i in range(EPOCHS):
    print(f'epoch: {i}')

    # intense inhale/exhale
    for n in range(CYCLES):
        print('inhale')
        play(h)
        print('exhale')
        play(c)

    # exhale and hold breath for 1.5 minute
    print('after last exale, hold for 1.5 minute (meditate)')
    sleep(HOLD_AFTER_EXHALE-BEEP_LENGTH)

    # inhale and hold for 15 seconds (pump to head)
    print('inhale and hold')
    play(a)
    sleep(HOLD_AFTER_INHALE-BEEP_LENGTH) # 15-1

