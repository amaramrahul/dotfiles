#!/bin/bash
set -eu

# This scripts tries to guess and set the appropriate current directory
# so that ctrl-p can search easily

current_directory=$(pwd)
if echo -n "$@" | grep -E '[[:space:]](-t|-q|-)([[:space:]]|$)'; then
  exec vim "$@"
else
  if [[ $# -ge 1 ]]; then
    arg="${@: -1}"
    if ! [[ "$arg" =~ "^-" ]]; then
      if [[ -d "$arg" ]]; then
        current_directory=$arg
      else
        current_directory=$(dirname "$arg")
      fi
    fi
  fi
  exec vim -c ":cd $current_directory" "$@"
fi

