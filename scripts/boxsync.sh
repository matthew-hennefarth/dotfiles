#!/bin/sh

REMOTE=uchicago-box
LOCAL=$HOME/Documents/box

rclone bisync $REMOTE:/ $LOCAL/ --exclude-from ~/.config/rclone/exclude-file.txt --create-empty-src-dirs
