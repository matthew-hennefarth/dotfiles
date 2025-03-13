#!/bin/sh

REMOTE=uchicago-box
LOCAL=$HOME/Documents/box

rclone bisync --resync-mode newer --recover --max-lock 2m --conflict-resolve newer --resilient $REMOTE:/ $LOCAL/ --exclude-from ~/.config/rclone/exclude-file.txt --create-empty-src-dirs
