#!/bin/bash
set -eu

backup_dir=$(dirname "$0")/backup

if [ -f ~/.bashrc ]; then
  cp -a ~/.bashrc "$backup_dir"
fi

if [ -f ~/.config/karabiner/karabiner.json ]; then
  cp -a ~/.config/karabiner/karabiner.json "$backup_dir"
fi

if [ -f ~/Library/LaunchAgents/callItADay.plist ]; then
  cp -a ~/Library/LaunchAgents/callItADay.plist "$backup_dir"
fi

if [ -f ~/Library/LaunchAgents/lockOnInactivity.plist ]; then
  cp -a ~/Library/LaunchAgents/lockOnInactivity.plist "$backup_dir"
fi

crontab -l > "$backup_dir"/crontab

# vscode
if [ -f ~/Library/Application\ Support/VS\ Code\ @\ FB/User/settings.json ]; then
  cp -a ~/Library/Application\ Support/VS\ Code\ @\ FB/User/settings.json "$backup_dir/vscode"
fi
if [ -f ~/Library/Application\ Support/VS\ Code\ @\ FB/User/keybindings.json ]; then
  cp -a ~/Library/Application\ Support/VS\ Code\ @\ FB/User/keybindings.json "$backup_dir/vscode"
fi
