#!/bin/bash

if [ -z "$1" ]; then
  echo "$0 <pdf-file-to-decrypt>"
  exit 1
fi

tmpfile=$(mktemp)
trap "rm -f $tmpfile" EXIT

if pdftk "$1" input_pw PROMPT output $tmpfile; then
  if pdfsig $tmpfile | grep "Digital Signature" >/dev/null; then
    echo "File is digitally signed. Removing password would invalidate signature."
    exit 2
  fi
  mv -f $tmpfile "$1"
fi
