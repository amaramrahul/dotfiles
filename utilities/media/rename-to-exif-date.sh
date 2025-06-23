#!/bin/bash

/usr/bin/exiftool '-FileName<${Exif:CreateDate}_${model;}.%le' -d '%Y%m%d_%H%M%S' "$@"
