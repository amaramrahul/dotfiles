#!/bin/bash
set -eu

DEFAULT_TIMEOUT=4

while true; do
  while [ -f ~/.timeout ]; do
    timeout=$(cat ~/.timeout)
    if [ $(stat -c "%z" ~/.timeout | cut -d " " -f 1) != $(date +"%Y-%m-%d") -a $(date +"%H") -ge 12 ] && [ $timeout -eq 0 -o $timeout -ge 1440 ]; then
      if output=$(/usr/bin/osascript -e "tell application \"System Events\"" -e "activate" -e "display dialog \"Timeout set to $timeout minutes\" buttons {\"Continue\", \"Disable\"} with icon caution" -e "end tell" 2>/dev/null); then
        if echo $output | grep "Continue" >/dev/null; then
          touch ~/.timeout
        elif echo $output | grep "Disable" >/dev/null; then
          rm -f ~/.timeout
        fi
      fi
    fi
    if [ -f ~/.timeout ]; then
      sleep 60
    fi
    if [ -f ~/.timeout -a $timeout -eq $(cat ~/.timeout) ]; then
      if [ $timeout -gt 1 ]; then
        echo $((timeout-1)) > ~/.timeout
      elif [ $timeout -ne 0 ]; then
        rm -f ~/.timeout
      fi
    fi
  done
  idle_time=$(/usr/sbin/ioreg -c IOHIDSystem | /usr/bin/awk '/HIDIdleTime/ {print int($NF/1000000000); exit}')
  # See https://superuser.com/questions/497207/how-can-i-tell-if-the-lock-screen-is-active-from-the-command-line-on-os-x
  # Install Quartz using "pip install pyobjc-framework-Quartz"
  isSessionLocked=$(python -c 'import sys,Quartz; d=Quartz.CGSessionCopyCurrentDictionary(); print d' | grep "CGSSessionScreenIsLocked = 1" > /dev/null && echo true || echo false)
  if [ $idle_time -ge $((DEFAULT_TIMEOUT*60)) ] && ! $isSessionLocked; then
    lock_screen=false
    if test $(date +%H) -ge 22 || test $(date +%H) -le 06; then
      lock_screen=true
    elif output=$(/usr/bin/osascript -e "tell application \"System Events\"" -e "activate" -e "display dialog \"Locking screen in 60 seconds\" buttons {\"Cancel\", \"Disable for <= 3 hrs\", \"Disable for > 3 hrs\"} with icon caution giving up after 60" -e "end tell" 2>/dev/null); then
      # A better choice would have been to use choice dialog of apple script so that we can have many more choices for how long we want to disable this script. But the main problem with that was closing the window upon timeout. Timeout could be implemenented either via apple script or via shell timeout command but once the timeout happened, getting to close the open choices window become a challenge. Tried al most all the approaches suggested in: https://macscripter.net/viewtopic.php?id=33947. Finally, considering that this script is only a temporary hack due to inflexibility of being able to reduce the lock screen idle timeout to less than 15 minutes (because of company policy), I have decided to live with the slight inconvenience.
      if echo "$output" | grep "gave up:true" > /dev/null; then
        lock_screen=true
      elif echo "$output" | grep "<= 3 hrs" > /dev/null; then
        echo "180" > ~/.timeout
      elif echo "$output" | grep "> 3 hrs" > /dev/null; then
        echo "840" > ~/.timeout
      fi
    fi
    if $lock_screen; then
      pmset displaysleepnow
      sleep 5 # wait for screen to get locked
      # Use the below command if your system does not get locked upon display sleep
      #/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
    fi
  fi
  sleep 1
done
