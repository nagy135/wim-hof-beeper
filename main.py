from pydub import AudioSegment
from pydub.playback import play

c = AudioSegment.from_mp3("sounds/c.mp3")
d = AudioSegment.from_mp3("sounds/d.mp3")
e = AudioSegment.from_mp3("sounds/e.mp3")
f = AudioSegment.from_mp3("sounds/f.mp3")
g = AudioSegment.from_mp3("sounds/g.mp3")
a = AudioSegment.from_mp3("sounds/a.mp3")
h = AudioSegment.from_mp3("sounds/h.mp3")

play(c)
play(e)
play(g)

# generate sound
# ffmpeg -f lavfi -i "sine=frequency=1027:duration=1" c.mp3 
