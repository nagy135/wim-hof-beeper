from pydub import AudioSegment
from pydub.playback import play
from time import sleep

# SETTINGS

# generate sound
# ffmpeg -f lavfi -i "sine=frequency=1027:duration=1" c.mp3 
c = AudioSegment.from_mp3("sounds/c6_1s.mp3")
d = AudioSegment.from_mp3("sounds/d6_1s.mp3")
e = AudioSegment.from_mp3("sounds/e6_1s.mp3")
f = AudioSegment.from_mp3("sounds/f6_1s.mp3")
g = AudioSegment.from_mp3("sounds/g6_1s.mp3")
a = AudioSegment.from_mp3("sounds/a6_1s.mp3")
h = AudioSegment.from_mp3("sounds/h6_1s.mp3")

fast_c = AudioSegment.from_mp3("sounds/c6_05s.mp3")
long_low_c = AudioSegment.from_mp3("sounds/c5_2s.mp3")

BEEP_LENGTH=1
LONG_BEEP_LENGTH=2

EPOCHS=4
CYCLES=30

HOLD_AFTER_EXHALE=120
HOLD_AFTER_INHALE=15

# START

for i in range(EPOCHS):
    print(f'epoch: {i}')
    
    play(fast_c)
    play(fast_c)
    play(fast_c)

    # intense inhale/exhale
    for n in range(CYCLES):
        print('inhale')
        play(h)
        print('exhale')
        if n+1 == CYCLES:
            play(e)
        else:
            play(c)

    # exhale and hold breath for 1.5 minute
    print('after last exale, hold for 1.5 minute (meditate)')
    sleep(HOLD_AFTER_EXHALE-BEEP_LENGTH)

    # inhale and hold for 15 seconds (pump to head)
    print('inhale and hold')
    play(long_low_c)
    sleep(HOLD_AFTER_INHALE-LONG_BEEP_LENGTH)
    play(f)
print('THE END')
