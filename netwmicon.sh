#!/bin/sh

# Defining your own icon
# You can of course change the icon to any icon you want.
# Just grab some icon from your favorite icon-theme.
# The tricky part is that it needs to be encoded as
# 	"an array of 32bit packed CARDINAL ARGB with high byte being A, low byte being B" - Source.
# This can be done with the script netwmicon.sh.
# It takes as argument the icon-file and prints to stdout the encoded icon.
# Redirect it to icon.h to save it and reinstall st.
# You need to install both imagemagick and inkscape for the script to work.

echo 'unsigned long icon[] = {'
identify -format '%w, %h,\n' "$1" | sed 's/^/	/'
convert -background none "$1" RGBA: | hexdump -ve '"0x%08x, "' | fmt | sed 's/^/	/'
echo "};"
