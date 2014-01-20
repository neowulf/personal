#!/bin/sh

# http://hints.macworld.com/article.php?story=20040514133013713

# A simple bash script that uses Applescript to
# open multiple files in Preview. For example:
# "preview hello.png world.gif *.jpg"

if [ -z "$*" ]; then
  echo "Usage: $0 [FILE(S)]"
  exit
fi

PWD=${PWD//\//:}
for file in $*;
do
  if [ -n "$FILES" ]
  then
    FILES="$FILES, \"$PWD:$file\""
  else
    FILES="\"$PWD:$file\""
  fi
done;
osascript<<EOF
tell application "Preview"
  activate
  open {$FILES}
end tell
EOF
