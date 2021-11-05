#!/bin/bash

function lock {
  pmset displaysleepnow
  sleep 5 # wait for screen to get locked
  # Use the below command if your system does not get locked upon display sleep
  #/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend
}

while true; do
  if test $(date +%H) -eq 22 && test $(date +%M) -eq 55; then
    osascript -e "display notification \"Lockdown in 5 minutes\" with title \"***** LOCKDOWN REMINDER *****\""
    sleep 300
    lock
  elif (test $(date +%H) -ge 22 && test $(date +%M) -ge 30) || test $(date +%H) -lt 5; then
    isSessionLocked=$(python -c 'import sys,Quartz; d=Quartz.CGSessionCopyCurrentDictionary(); print d' | grep "CGSSessionScreenIsLocked = 1" > /dev/null && echo true || echo false)
    if ! $isSessionLocked; then
      if reason=$(osascript -e "tell application \"System Events\"" -e "activate" -e "choose from list {\"Deep Work (hard-stop at midnight)\", \"Working on an outage\", \"Need to give updates which others are waiting for today\", \"Collaboration with US teams, which if not done, would block progress of critical deliverables\", \"Need to start a background job which would take more than 1 hour\", \"Got a hard-deadline today or tomorrow\", \"Add new exception\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\"} with prompt \"Why have you unlocked?\"" -e "end tell"); then
        if echo $reason | grep "false" >/dev/null; then
          lock
        elif output=$(osascript -e "tell application \"System Events\"" -e "activate" -e "display dialog \"How long to finish the job?\" buttons {\"15 mins\", \"30 mins\", \"1 hr\"} giving up after 10" -e "end tell" 2>/dev/null); then
          if echo $output | grep "15 mins" >/dev/null; then
            sleep 900
          elif echo $output | grep "30 mins" >/dev/null; then
            sleep 1800
          elif echo $output | grep "1 hr" >/dev/null; then
            sleep 3600
          fi
          lock
        else
          lock
        fi
      else
        lock
      fi
    else
      sleep 1
    fi
  else
    sleep 60
  fi
done
