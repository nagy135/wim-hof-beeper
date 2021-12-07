import asyncio
from pydub import AudioSegment
from pydub.playback import play
from time import sleep

# SETTINGS
BEEP_LENGTH=1
LONG_BEEP_LENGTH=2

EPOCHS=4
CYCLES=30

HOLD_AFTER_EXHALE=120
HOLD_AFTER_INHALE=15

# generate sound
# ffmpeg -f lavfi -i "sine=frequency=1027:duration=1" c.mp3 
sounds = {
    'c' : AudioSegment.from_mp3("sounds/c6_1s.mp3"),
    'd' : AudioSegment.from_mp3("sounds/d6_1s.mp3"),
    'e' : AudioSegment.from_mp3("sounds/e6_1s.mp3"),
    'f' : AudioSegment.from_mp3("sounds/f6_1s.mp3"),
    'g' : AudioSegment.from_mp3("sounds/g6_1s.mp3"),
    'a' : AudioSegment.from_mp3("sounds/a6_1s.mp3"),
    'h' : AudioSegment.from_mp3("sounds/h6_1s.mp3"),

    'fast_c' : AudioSegment.from_mp3("sounds/c6_05s.mp3"),
    'long_low_c' : AudioSegment.from_mp3("sounds/c5_2s.mp3"),
    'meditation_ending' : AudioSegment.from_mp3("sounds/meditation_ending.mp3"),
}

def main():

    # START
    for i in range(EPOCHS):
        print(f'epoch: {i}')
        
        play_sound('fast_c')
        play_sound('fast_c')
        play_sound('fast_c')

        # intense inhale/exhale
        for n in range(CYCLES):
            print('inhale')
            play_sound('h')
            print('exhale')
            if n+1 == CYCLES:
                play_sound('e')
            else:
                play_sound('c')

        print('after last exale, hold (meditate)')
        if i == EPOCHS - 1:
            while True:
                play_sound('meditation_ending')
        else:
            sleep(HOLD_AFTER_EXHALE-BEEP_LENGTH)

            # inhale and hold for 15 seconds (pump to head)
            print('inhale and hold')
            play_sound('long_low_c')
            sleep(HOLD_AFTER_INHALE-LONG_BEEP_LENGTH)
            play_sound('f')
    print('THE END')

def play_sound(tone):
    play(sounds[tone])

main()
