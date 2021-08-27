#!/bin/bash

# SETTINGS
EPOCHS=4
CYCLES=30

HOLD_AFTER_EXHALE=120
HOLD_AFTER_INHALE=15


play(){
    # ffmpeg -f lavfi -i "sine=frequency=1027:duration=1" c.mp3
    case $1 in
        c)
            file=sounds/c6_1s.mp3
            ;;
        d)
            file=sounds/d6_1s.mp3
            ;;
        e)
            file=sounds/e6_1s.mp3
            ;;
        f)
            file=sounds/f6_1s.mp3
            ;;
        g)
            file=sounds/g6_1s.mp3
            ;;
        a)
            file=sounds/a6_1s.mp3
            ;;
        h)
            file=sounds/h6_1s.mp3
            ;;
        fast_c)
            file=sounds/c6_05s.mp3
            ;;
        long_low_c)
            file=sounds/c5_2s.mp3
            ;;
        meditation_ending)
            file=sounds/meditation_ending.mp3
            ;;
    esac
    ffplay -nodisp -autoexit $file &> /dev/null
}

for (( e=1; e<=$EPOCHS; e++ ))
do
    echo "Epoch: $e"

    # START SEQUENCE
    play fast_c
    play fast_c
    play fast_c

    # INTENSE BREATHING CYCLES
    for (( c=1; c<=$CYCLES; c++ ))
    do
        echo "inhale"
        play h
        echo "exhale"
        [ $c -eq $CYCLES ] \
            && play e \
            || play c
    done

    # LONG HOLD
    if [[ $e -eq $EPOCHS ]]; then
        play meditation_ending
    else
        echo "hold"
        sleep $HOLD_AFTER_EXHALE

        echo "inhale deeply"
        play long_low_c
        sleep $HOLD_AFTER_INHALE
        play f
    fi

done
