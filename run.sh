#!/bin/bash

# SETTINGS
EPOCHS=2
CYCLES=3

HOLD_AFTER_EXHALE=12
HOLD_AFTER_INHALE=5

trap 'echo ...EXITING ; exit' SIGINT

play(){
    file=
    duration=${2:-1}
    case $1 in
        # 3 {{{
        c3)
            frequency=130
            ;;
        d3)
            frequency=146
            ;;
        e3)
            frequency=164
            ;;
        f3)
            frequency=174
            ;;
        g3)
            frequency=195
            ;;
        a3)
            frequency=220
            ;;
        h3 | b3)
            frequency=246
            ;;
        # }}}
        # 4 {{{
        c | c4)
            frequency=261
            ;;
        d | d4)
            frequency=293
            ;;
        e | e4)
            frequency=329
            ;;
        f | f4)
            frequency=349
            ;;
        g | g4)
            frequency=391
            ;;
        a | a4)
            frequency=440
            ;;
        h | b | h4 | b4)
            frequency=493
            ;;
        # }}}
        # 5 {{{
        c5)
            frequency=523
            ;;
        d5)
            frequency=587
            ;;
        e5)
            frequency=659
            ;;
        f5)
            frequency=698
            ;;
        g5)
            frequency=783
            ;;
        a5)
            frequency=880
            ;;
        h5 | b5)
            frequency=987
            ;;
        # }}}
        # 5 {{{
        c6)
            frequency=1046
            ;;
        d6)
            frequency=1174
            ;;
        e6)
            frequency=1318
            ;;
        f6)
            frequency=1396
            ;;
        g6)
            frequency=1567
            ;;
        a6)
            frequency=1760
            ;;
        h6 | b6)
            frequency=1975
            ;;
        # }}}
        # sounds {{{
        meditation_ending)
            file=sounds/meditation_ending.mp3
            ;;
        # }}}
    esac
    echo "doing" $frequency $duration
    [ ! -z $file ] \
        && ffplay -nodisp -autoexit $file &> /dev/null \
        || ffplay -f lavfi -i "sine=frequency=$frequency:duration=$duration" -nodisp -autoexit &> /dev/null
}

e=1
while [ $e -le $EPOCHS ]; do
    echo "Epoch: $e"
    e=$((e+1))

    # START SEQUENCE
    play h5 0.5
    play a5 0.5
    play g5 0.5

    # INTENSE BREATHING CYCLES
    c=1
    while [ $c -le $CYCLES ]; do
        echo "inhale ($c)"
        play h3
        echo "exhale ($c)"
        [ $c -eq $CYCLES ] \
            && play a3 \
            || play c3
        c=$((c+1))
    done

    # LONG HOLD
    if [ $e -eq $((EPOCHS+1)) ]; then
        play meditation_ending
    else
        echo "hold"
        sleep $HOLD_AFTER_EXHALE

        echo "inhale deeply"
        play g3 2
        sleep $HOLD_AFTER_INHALE
        play f 0.5
        play f 0.5
    fi

done
