#!/bin/sh

# See http://www.faqs.org/faqs/unix-faq/faq/part2/section-12.html
for arg; do second_last_arg=$last_arg; last_arg=$arg; done

# Below method also works for most of the shells and avoids looping through the arguments
# However, usage of eval for indirect reference generally seems to be discouraged
# See http://stackoverflow.com/questions/1853946/getting-the-last-argument-passed-to-a-shell-script/1854031#comment8318885_1853991
#eval last_arg=\${$#}
#eval second_last_arg=\${$(($#-1))}

# An elegent way of getting the arguments in bash
#last_arg=${BASH_ARGV[0]}
#second_last_arg=${BASH_ARGV[1]}

# Few other links for getting second last and last arguments. However, these solutions may not work across different shells
# http://stackoverflow.com/questions/11054939/how-to-get-the-second-last-argument-from-shell-script
# http://stackoverflow.com/questions/1853946/getting-the-last-argument-passed-to-a-shell-script
# http://www.cyberciti.biz/faq/linux-unix-bsd-apple-osx-bash-get-last-argument/

# svn diff passes the existing files' paths for diff on working copy whereas
# it creates temporory files (whose paths it passes as arguments) for diff
# between repo paths. However, the temporary files are deleted as soon as
# the external script that svn diff calls (i.e this script) returns. This
# might be a problem if we send the diff program that we are using to 
# background (as is the case with the way we are calling meld below).
# So, we check and if svn diff has passed us a file that is located in /tmp/,
# then we make a copy of that file so that it continues to be available to
# the diff program (meld) that we are calling below.

# Get left argument for diff program
delete_left=false
if echo "$second_last_arg" | grep "^/tmp/" > /dev/null; then
  left=$(mktemp --tmpdir "$(basename "$second_last_arg").XXXXXXXXXX")
  cp -f "$second_last_arg" "$left"
  delete_left=true
else
  left=$second_last_arg
fi

# Get right argument for diff program
delete_right=false
if echo "$last_arg" | grep "^/tmp/" > /dev/null; then
  right=$(mktemp --tmpdir "$(basename "$last_arg").XXXXXXXXXX")
  cp -f "$last_arg" "$right"
  delete_right=true
else
  right=$last_arg
fi

# Call diff program
(meld --newtab "$left" "$right"; $delete_left && rm -f "$left"; $delete_right && rm -f "$right") &
