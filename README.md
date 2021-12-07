# Wim Hof beeper

Simple script beeping according to Wim Hof's breathing technique.
Supports multiple levels of difficulty and ends with meditation song that tests your final durability.

Contains also python version but shell one is highly preferred.

Beeps might be annoying, but with `ffmpeg` you can generate your own ones.
Script contains commented-out oneliner to do so.

## Installation
```
git clone https://github.com/nagy135/wim-hof-beeper
cd wim-hof-beeper
chmod +x wim_hof_beeper
./wim_hof_beeper.sh -l 1

```

## Usage

Simply run the script specifying level of difficulty.
CLI will guide you to right values.

```
./wim_hof_beeper.sh -l 1
```

## Dependencies
* ffmpeg

### For python version also
* pydub

## Breathing pattern
Multiple levels of difficulty increase epochs and breath hold span but first level looks like this:

3 epochs of:
* 30 cycles of fast inhale/exhales
* 90 sec hold after last exhale (without inhaling!)
* inhale into 15 sec hold (pushing air in the head)

Each epoch starts with 3 fast beeps
