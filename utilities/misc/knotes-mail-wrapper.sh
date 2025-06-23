#!/bin/bash

set -eu

# See /usr/share/doc/util-linux/examples/getopt-example.bash for getopt example
TEMP=$(getopt --name "$0" --options "s:,b:" --longoptions "subject:,body:" -- "$@")

# Bad arguments, something has gone wrong with the getopt command.
if [ $? -ne 0 ]; then
  echo "Termintaing ..." >&2
  exit 1
fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

# Now go through all the options
while true; do
  case "$1" in
    '-s'|'--subject')
      subject=$2
      shift 2;;

    '-b'|'--body')
      body=$2
      shift 2;;

    '--')
      shift
      break;;

    *)
      echo "Error parsing arguments" >&2
      exit 1;;
  esac
done

thunderbird_command=$(command -v icedove >/dev/null 2>&1 && echo icedove || echo thunderbird)
$thunderbird_command -compose "subject='$subject',body='$body'"

