#!/bin/bash

# This script can be started in KDE by adding in System Settings -> Startup and Shutdown -> Autostart -> Login Scripts (AFAIK, you do not need to send the program to background, for ex. by using nohup command)

function lock {
  qdbus org.freedesktop.ScreenSaver /ScreenSaver Lock
}

while true; do
  if test $(date +%H) -eq 21 && test $(date +%M) -eq 55; then
    #notify-send "***** LOCKDOWN REMINDER *****" "Lockdown in 5 minutes"
    sleep 300
    lock
  elif (test $(date +%H) -ge 22 && test $(date +%M) -ge 00) || test $(date +%H) -lt 5; then
    isSessionLocked=$(qdbus org.freedesktop.ScreenSaver /ScreenSaver GetActive)
    if ! $isSessionLocked; then
      if reason=$(timeout 60 kdialog --title "Unlock reason" --radiolist "Why did you unlock?" "Hard deadline" "Hard deadline" off "Finishing in-progress transaction" "Finishing in-progress transaction" off "Emergency" "Emergency" on); then
        if confirm=$(timeout 20 kdialog --title "Confirm reason" --inputbox "Confirm reason for unlocking"); then
          if echo "$confirm" | grep -Ei "confirm.*unlocked.*$reason" >/dev/null; then
            if output=$(timeout 10 kdialog --radiolist "How long to finish the job?" 15 "15 mins" on 30 "30 mins" off 60 "1 hr" off); then
              sleep $((output*60))
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
