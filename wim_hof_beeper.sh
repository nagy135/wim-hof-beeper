#!/bin/bash

# create new sound of specified sine frequency
# ffmpeg -f lavfi -i "sine=frequency=1027:duration=1" c.mp3

RED=$'\e[1;31m'
END=$'\e[0m'

trap trap_handler SIGINT

usage(){
    echo "Usage: wim_hof_beeper OPTIONS"
    echo "Beeps to guide you through Wim Hof's breathing technique"
    echo ""
    echo "Options:"
    echo "  -l, --level                Specify level of difficulty (1-3)"
}


trap_handler(){
    echo '...EXITING'

    [ ! $HOLD_TIMESTAMP -eq 0 ] \
        && NOW=$(date +%s) \
        && echo 'STOPPED MID-HOLD!' \
        && echo 'hold length:' $((NOW-HOLD_TIMESTAMP)) 'seconds'

    exit
}

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
    [ ! -z $file ] \
        && ffplay -nodisp -autoexit $file  \
        || ffplay -f lavfi -i "sine=frequency=$frequency:duration=$duration" -nodisp -autoexit &> /dev/null
}

# ARG PARSING {{{

[ $# -lt 1 ] && usage && exit

LEVEL=1

case $1 in
    --help | -h)
        usage && exit
        ;;
    --level | -l)
        shift
        [ -z $1 ] \
            && echo "${RED}Specify level!${END}" \
            && usage \
            && exit 2
        LEVEL="$1"
        ;;
    *)
        echo "${RED}Unknown option!${END}"
        usage
        exit 1
        ;;
esac

# }}}

# SETTING VARIABLES BASED ON LEVEL {{{

CYCLES=30
HOLD_AFTER_INHALE=15

case $LEVEL in
    1)
        EPOCHS=3
        HOLD_AFTER_EXHALE_FIRST=90
        HOLD_AFTER_EXHALE=120
        ;;
    2)
        EPOCHS=4
        HOLD_AFTER_EXHALE_FIRST=120
        HOLD_AFTER_EXHALE=180
        ;;
    3)
        EPOCHS=4
        HOLD_AFTER_EXHALE_FIRST=120
        HOLD_AFTER_EXHALE=200
        ;;
    *)
        echo "${RED}Unknown level!${END}"
        usage
        exit 3
        ;;
esac

# }}}

HOLD_TIMESTAMP=0

echo "Startup sequence"
play h5 0.5
play a5 0.5
play g5 0.5

e=1
while [ $e -le $EPOCHS ]; do
    echo "Epoch: $e"
    e=$((e+1))

    # EPOCH START SEQUENCE
    play h5 0.5
    play a5 0.5
    play g5 0.5

    # INTENSE BREATHING CYCLES
    c=1
    while [ $c -le $CYCLES ]; do
        echo "inhale ($c)"
        play h

        echo "exhale ($c)"
        [ $c -eq $CYCLES ] \
            && play a3 2 \
            || ( [ $c -eq $((CYCLES-5)) ] && ( play e 0.5 ; play c 1 ) || play c 1.5 )

        c=$((c+1))
    done

    # LONG HOLD
    HOLD_TIMESTAMP=$(date +%s)
    if [ $e -eq $((EPOCHS+1)) ]; then
        play meditation_ending
    else
        echo "hold"

        [ $e -eq 1 ] && \
            sleep $HOLD_AFTER_EXHALE_FIRST || \
            sleep $HOLD_AFTER_EXHALE

        echo "inhale deeply"
        play g3 2
        sleep $HOLD_AFTER_INHALE
        play f 0.5
        play f 0.5
    fi
    HOLD_TIMESTAMP=0

done
