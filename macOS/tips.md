Apps
----

* [MacVim](https://github.com/macvim-dev/macvim): Vim editor. Another popular one is VimR.
* [Karabiner](https://pqrs.org/osx/karabiner/): A powerful and stable keyboard customizer for OS X
* [New File Menu Free](https://apps.apple.com/us/app/new-file-menu-free/id1066302071): New File Menu allows you to create new files quickly via the Finder context menu
* [Flux](https://justgetflux.com/news/pages/macquickstart/): Ajudst monitor colors depending on time of day
* [Network Utility](https://support.apple.com/en-in/HT202790): In-build application for some useful network functions (mainly use for ping)
* [edit-anywhere](https://github.com/tjluoma/edit-anywhere): anywhere you could edit text, it would send that text to your favorite text editor and then when you closed that file, it would send the text back to the original application.
* [GitUp](https://github.com/git-up/GitUp): Frontend to git
* [Battery Monitor](https://apps.apple.com/us/app/battery-monitor-health-info/id836505650): Low battery alert
* [Notefile](http://junecloud.com/software/dashboard/notefile.html): Dashboard widget for resizable sticky note
* [Apptivate](http://www.apptivateapp.com/): for assigning global shortcuts to apps (this can be probably be done using karabiner or automator as described in https://apple.stackexchange.com/questions/20010/can-i-create-a-shortcut-to-open-a-specific-application-on-os-x but apptivate feels a whole lot more convenient)
* [XQUartz](https://www.xquartz.org/): X server. Also, the proper path to xauth has to be set for this to work (https://discussions.apple.com/thread/8621501)
* [Amphetmaine](https://apps.apple.com/us/app/amphetamine/id937984704): Powerful keep-awake utility. Useful because you might not be able to prevent your Mac for going to sleep due to global policies.
* [Wifi Explorer Lite](https://www.adriangranados.com/): Useful for knowing wifi signal strength of multiple points with the same SSID
* [HandBrake](https://handbrake.fr/): HandBrake is a tool for converting video from nearly any format to a selection of modern, widely supported codecs
* [Barrier](https://github.com/debauchee/barrier): Share one mouse and keyboard between multiple computers
* [Nekoze](https://questbe.at/nekoze/): Improve Your Posture
* [scrcpy](https://github.com/Genymobile/scrcpy): Display and control your Android device
* [Evoluent](https://evoluent.com/support/download/): Evoluent vertical mouse manager
* [Browser Fairy 2](https://apps.apple.com/us/app/browser-fairy/id1499080593): Decide which browser to open links in based on rules.
* [QR Jounral](https://apps.apple.com/us/app/qr-journal/id483820530)
* [Moom](https://manytricks.com): Window Snapping + Preserve Window layout (software providing similar features: Rectangle, BetterSnapTool, Stay, Display Maid)
* [trash](https://github.com/morgant/tools-osx): See https://apple.stackexchange.com/questions/50844/how-to-move-files-to-trash-from-command-line. Only trash command in tools-osx can be installed (see README.md)
* [autossh](https://www.harding.motd.ca/autossh/): autossh is a program to start a copy of ssh and monitor it, restarting it as necessary should it die or stop passing traffic. Compiling source and installing works.
* [htop](https://htop.dev/): a cross-platform interactive process viewer. Compiling source and installing works.

Tips
* Any web app can be run as desktop app using Google Chrome through More tools -> Create Shortcut... -> Open in new window. For PWA apps (such as https://notepad.js.org/, https://music.youtube.com/), the preferred way is to install it using the "Install <App>..." option. Other software which provide similar options are flotato (buggy), webcatalog (free version limited to 2 apps), unite (yet to try), fluid, nativefier.
* Barrier (the mouse and keyboard sharing software) is a fork of Synergy (which is now paid). If you want share monitor of another MAC, look at Air Display, Luna Display (https://lunadisplay.com/pages/meet-mac-to-mac-mode) or Duet Display (https://www.duetdisplay.com/help-center/desktop-to-desktop-support)
* For locking screen at specific time, see https://apple.stackexchange.com/questions/49226/scheduled-account-lock-mac-os-x. Kindly note that none of the crontab tips worked.
* For using GNU command line tools in OS X, see https://www.topbug.net/blog/2013/04/14/install-and-use-gnu-command-line-tools-in-mac-os-x/
* Difference between the following:
    - osascript -e "display dialog \"hello\"" - Doesn't work from cron
    - osascript -e "tell application (path to frontmost application) to display dialog \"hello\"" - Focus returns to the foremost application when cancelled but when other apps are opened dialog goes in background
    - osascript -e "tell application \"System Events\" to display dialog \"hello\"" - Dialog always in foreground but when cancelled focus doesn't return to the foremost application
* To get the list of allowed  system / kernel extensions, run the command: sudo sqlite3 /var/db/SystemPolicyConfiguration/KextPolicy "select * from kext_policy" (ref: https://grahamgilbert.com/blog/2017/09/11/enabling-kernel-extensions-in-high-sierra/)
* Reduce pdf size: https://apple.stackexchange.com/questions/297417/how-to-decrease-pdf-size-without-losing-quality


System Preferences Optimizations
--------------------------------

Desktop & Dock
  Close windows when quitting an app: Checked

Keyboard
  Keyboard Shortcuts
    Function Keys
      Use F1, F2, etc. keys as standard function keys: Checked

Trackpad
  Scroll & Zoom
    Natural Scrolling: Unchecked


Karabiner Configuration
-----------------------

Copy dotfiles/macos/backup/karabiner.json to ~/.config/karabiner/karabiner.json

Addtional settings in iTerm with above configuration
* Update Mappings (set in Settings... -> Keys -> Key Bindings):
    * Ctrl+Shift+C -> Copy
    * Ctrl+Shift+V -> Paste
    * Ctrl+Shift+T -> New tab
    * Ctrl+Page_down -> Next Tab
    * Ctrl+Page_up -> Previous Tab
    * Fn+left_arrow (this will get interpreted as Command+left_arrow) -> Send Hex Code "0x01"
    * Fn+right_arrow (this will get interpreted as Command+right_arrow) -> Send Hex Code "0x05"
    * Ctrl+left_arrow (this will get interpreted as Alt+left_arrow) -> Send Escape Sequence "b"
    * Ctrl+right_arrow (this will get interpreted as Alt+right_arrow) -> Send Escape Sequence "f"
* You will also have to delete the shortcuts for Option+left_arrow and Option+right_arrow in Preferences -> Profiles -> Keys to avoid conflicts.
* As an additional tip, go to Settings... -> Keys -> Navigation Shortcuts and set Shortcut to select a tab to "Option + Number" (with this you can use Alt+1,Alt+2,etc. to jump to tabs)

Notes:
1. If upgrading MacOS, ensure that karabiner is supported in the latest version.
2. key_code in karabiner.json should be a specific key (for ex. left_control, right_command). However, modifiers can be generic (for ex: control, command)


Shortcuts
---------

Hide Window		: Ctrl + H
Hide other windows	: Ctrl + Alt + H
Screenshot		: Ctrl + Shift + 4
Lock Screen		: Ctrl + Command + Q
F11			: Show Desktop
Alt + Space (modified)	: Show Spotlight

Go to System Preferences -> Keyboard -> Keyboard Shortcuts...
1. Disable all conflicting shortcuts (these are mostly those where command and ctrl are used)
2. Custom App Shortcuts can be set for menu actions (for ex. you can set MacVim and Terminal copy, paste overrides)


VSCode
-------

Use the https://marketplace.visualstudio.com/items?itemName=zpeterg.intellij-idea-keybindings-mac-to-pc extension to serve two purposes:
1. Use IntelliJ shortcuts
2. Switch Cmd with Ctrl so that the IntelliJ shortcuts are those of Windows/Linux

Next, restore keybindings.json from backup.

You could also install  https://marketplace.visualstudio.com/items?itemName=k--kato.intellij-idea-keybindings extension and select Default -> Mac-to-Linux keymap. This will generate config that needs to be copied to keybindings.json. The downside of this is that if you make any additional changes in keybindings.json, it would be harder to track them.

Some other useful extensions:
* Vim
* Bookmarks

Restore setings.json from backup once the extensions are installed.


Secure Shell
------------

In case you want to run commands that you do not want to be logged, you can just spawn a new shell as:
```
/usr/bin/env HISTFILE= /bin/bash
```

Additionally, if you are using iTerm2 as the default terminal application, then you can configure the in-built MacOS Terminal Application to always run this command when launched. This way you can be sure that any command that you run in Terminal application will not get stored in bash history.


Need for version-based backup
-----------------------------

Think of a use-case where you take notes of a half-an-hour meeting and then come out and accidentally delete it. If you only have hourly or daily backups, then there is good chance that this information is lost for good. We can reduce the frequency of our backups to 5 mins but then the number of backups created would be huge, irrespective of whether change is there or not. Hence it is suggested to have version-based backups, which backups only if there is change.

Here is the suggested way of organizing data:

Projects in git repos
Personal files in Cloud with version history (synced to local system)
Hourly Borg based backup of home directory to /backup/ or another cloud service


iTerm
------

iTerm supports automatic profile switching which is useful to differentiate connection to production systems. See https://iterm2.com/documentation-automatic-profile-switching.html

If preferred, you can make iTerm2 the default terminal via iTerm2 Menu -> Make iTerm2 Default Term


VMWare Configuration
---------------------

Configuration:

Key Mappings
	Cmd: Ctrl
	Cmd+Alt+Delete: Ctrl+Alt+Delete

Issues:

If usb 3.0 is not working (device getting identified as uas), add the below config in .vmx file:
usb.generic.keepStreamsEnabled = "FALSE"

This idea has been taking from http://pubs.vmware.com/Release_Notes/en/fusion/8/fusion-80-release-notes.html#knownissues


Barrier Configuration
---------------------
For meta, send Ctrl


Thunderbird
-----------

Extensions
* ExchangeCalendar: https://github.com/ExchangeCalendar/exchangecalendar/
* Check and Send
* Compact Header
* Emoji
*ImportExport Tools
* Mail Redirect
* Nostalgy
* Send Later
* Custom button
* Menu Wizard
* ThunderLink
* WebApp Tabs
* Copy Message ID
* Manually sort folders
* Lightning
* Google Calendar Provider
* GContactsSync

Tips
* https://superuser.com/questions/285736/quick-way-to-find-a-specific-email-in-thunderbird-inbox

