#!/bin/bash

# openshot and kdenlive does not have split video without re-encoding (at least as of writing this script).
# avidemux supports splitting video without re-encoding but it is not part of the official debian repo.
# So, instead we use ffmpeg which has a copy mode that helps us to split video without re-encoding. See
# http://superuser.com/questions/377343/cut-part-from-video-file-from-start-position-to-end-position-with-ffmpeg

#ffmpeg -ss [start] -i in.mp4 -to [end] -c:v copy -c:a copy out.mp4
# -ss specifies the start time, e.g. 00:01:23.000 or 83 (in seconds)
# -to specifies the end time (same format).
# -c:v copy and -c:a copy copy the video and audio bitstreams without re-encoding them. This won't harm the quality and make the command run within seconds. You can replace the two options with -c copy if you want to copy one video, audio and subtitle stream to the output.

