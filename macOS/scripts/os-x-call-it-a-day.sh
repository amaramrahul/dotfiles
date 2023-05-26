#!/bin/bash

function lock {
  pmset displaysleepnow
  sleep 5 # wait for screen to get locked
  # Use the below command if your system does not get locked upon display sleep
  #/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
}

while true; do
  if test $(date +%H) -eq 21 && test $(date +%M) -eq 45; then
    #osascript -e "display notification \"Lockdown in 15 minutes\" with title \"***** LOCKDOWN REMINDER *****\""
    sleep 900
    lock
  elif (test $(date +%H) -ge 22 && test $(date +%M) -ge 00) || test $(date +%H) -lt 5; then
    isSessionLocked=$(python -c 'import sys,Quartz; d=Quartz.CGSessionCopyCurrentDictionary(); print d' | grep "CGSSessionScreenIsLocked = 1" > /dev/null && echo true || echo false)
    if ! $isSessionLocked; then
      if reason=$(osascript -e "tell application \"System Events\"" -e "activate" -e "choose from list {\"Outage\", \"Hard deadline\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\"} with prompt \"Why have you unlocked?\"" -e "end tell"); then
        if ! echo $reason | grep "false" >/dev/null; then
          if confirm=$(osascript -e "tell application \"System Events\"" -e "activate" -e "display dialog \"Confirm reason\" default answer \"\" buttons {\"Cancel\", \"Confirm\"} default button \"Confirm\" giving up after 60" -e "end tell" 2>/dev/null); then
            echo $confirm
            if echo "$confirm" | grep -Ei "confirm.*unlocked.*$reason" >/dev/null; then
              if output=$(osascript -e "tell application \"System Events\"" -e "activate" -e "display dialog \"How long to finish the job?\" buttons {\"15 mins\", \"30 mins\", \"1 hr\"} giving up after 10" -e "end tell" 2>/dev/null); then
                echo $output
                if echo $output | grep "15 mins" >/dev/null; then
                  sleep 900
                elif echo $output | grep "30 mins" >/dev/null; then
                  sleep 1800
                elif echo $output | grep "1 hr" >/dev/null; then
                  sleep 3600
                fi
              fi
            fi
          fi
        fi
      fi
      lock
    else
      sleep 1
    fi
  else
    sleep 60
  fi
done
