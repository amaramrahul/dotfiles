#!/bin/bash
set -eu

# Default variables
output_dir=/tmp/reduced-size-pdfs
resolution=300

# See /usr/share/doc/util-linux/examples/getopt-parse.bash for getopt example
TEMP=$(getopt -o 'r:' -- "$@")

if [ $? -ne 0 ]; then
  echo 'Terminating...' >&2
  exit 1
fi

# Note the quotes around "$TEMP": they are essential!
eval set -- "$TEMP"
unset TEMP

while true; do
  case "$1" in
    '-r')
      resolution=$2
      shift 2
      continue
    ;;
    '--')
      shift
      break
    ;;
    *)
      echo 'Internal error!' >&2
      exit 1
    ;;
  esac
done


echo "Creating reduced size PDFs in $output_dir with resolution $resolution ..."
mkdir -p $output_dir
for file; do
  echo "Reducing size of $file"
  outfile="$output_dir"/"`basename "$file"`"
  #Ref: http://www.ubuntugeek.com/ubuntu-tiphowto-reduce-adobe-acrobat-file-size-from-command-line.html
  #gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dNOPAUSE -dBATCH -sOutputFile=$outfile $file
  #gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dBATCH -sOutputFile=$outfile $file
  #Ref: http://www.alfredklomp.com/programming/shrinkpdf/
  gs -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/screen -dEmbedAllFonts=true -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=$resolution -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=$resolution -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=$resolution -sOutputFile="$outfile" "$file"
  #Ref: https://stackoverflow.com/questions/71352295/imagemagick-reduce-size-of-pdf (for compressing pdfs with images)
  #convert -density $resolution [-quality 50] -compress jpeg $file $outfile
done
echo "Checkout the script for more examples of how you can reduce pdfs (for ex if they have images)"
