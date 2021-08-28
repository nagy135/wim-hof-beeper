#!/bin/bash

# SETTINGS
EPOCHS=2
CYCLES=3

HOLD_AFTER_EXHALE=12
HOLD_AFTER_INHALE=5

trap 'echo ...EXITING ; exit' SIGINT

play(){
    frequency=261
    duration=1
    file=
    case $1 in
        c)
            frequency=261
            duration=1
            ;;
        d)
            frequency=293
            duration=1
            ;;
        e)
            frequency=329
            duration=1
            ;;
        f)
            frequency=349
            duration=1
            ;;
        g)
            frequency=391
            duration=1
            ;;
        a)
            frequency=440
            duration=1
            ;;
        h)
            frequency=493
            duration=1
            ;;
        fast_c)
            frequency=261
            duration=0.5
            ;;
        long_low_c)
            frequency=130
            duration=2
            ;;
        meditation_ending)
            file=sounds/meditation_ending.mp3
            ;;
    esac
    [ ! -z $file ] \
        && ffplay -nodisp -autoexit $file &> /dev/null \
        || ffplay -f lavfi -i "sine=frequency=$frequency:duration=$duration" -nodisp -autoexit &> /dev/null
}

e=1
while [ $e -le $EPOCHS ]; do
    echo "Epoch: $e"
    e=$((e+1))

    # START SEQUENCE
    play fast_c
    play fast_c
    play fast_c

    # INTENSE BREATHING CYCLES
    c=1
    while [ $c -le $CYCLES ]; do
        echo "inhale ($c)"
        play h
        echo "exhale ($c)"
        [ $c -eq $CYCLES ] \
            && play e \
            || play c
        c=$((c+1))
    done

    # LONG HOLD
    if [ $e -eq $EPOCHS ]; then
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
