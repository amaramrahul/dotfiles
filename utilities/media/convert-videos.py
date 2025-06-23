#!/usr/bin/python3

import os

for file in os.listdir("videos"):
  #os.system("ffmpeg -i videos/%s -target pal-vcd videos-vcd/%s" % (file, file[0:-4] + ".mpg") )
  os.system("ffmpeg -i videos/%s -vcodec h264 -coder 1 -flags +loop -cmp +chroma -partitions +parti4x4+partp8x8+partb8x8 -me hex -subq 5 -me_range 16 -g 250 -keyint_min 25 -sc_threshold 40 -i_qfactor 0.71 -b_strategy 1 -acodec aac videos-mp4/%s" % (file, file[0:-4] + ".mpg") )
