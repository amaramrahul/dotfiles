#!/bin/bash

/usr/local/bin/wkhtmltopdf-i386 --margin-top 15 --margin-bottom 15 --header-font-size 9 --header-spacing 5 --header-left "[doctitle]" --header-right "[webpage]" --footer-spacing 5 --footer-font-size 9 --footer-left "Page [page] of [topage]" --footer-right "[date] [time]" --outline-depth 0 "$@"
