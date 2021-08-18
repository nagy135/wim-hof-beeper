# Wim Hof beeper
Simple python script that beeps according to Wim Hof's breathing method.
You should absolutely read the code, it has very little lines and you need to read it to understand.

Beeps might be annoying, but with `ffmpeg` you can generate your own ones.
Script contains commented-out oneliner to do so.

## Dependencies
* pydub

## Breathing pattern
3 epochs of:
* 30 cycles of fast inhale/exhales
* 90 sec hold after last exhale (without inhaling!)
* inhale into 15 sec hold (pushing air in the head)

Each epoch starts with 3 fast beeps
