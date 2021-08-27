#!/bin/bash

# SETTINGS
BEEP_LENGTH=1
LONG_BEEP_LENGTH=2

EPOCHS=4
CYCLES=30

HOLD_AFTER_EXHALE=120
HOLD_AFTER_INHALE=15


play(){
    case $1 in
        a)
            file=sounds/a6_1s.mp3
            ;;
        c)
            file=sounds/c6_1s.mp3
            ;;
    esac
    ffplay -nodisp -autoexit $file &> /dev/null
}

for (( i=1; i<=$EPOCHS; i++ ))
do
    echo "Epoch: $i"
    play c

done
