#!/bin/bash

# Set source and target directories
powerline_fonts_dir=$( cd "$( dirname "$0" )" && pwd )

# if an argument is given it is used to select wich fonts to install
prefix="$1"

find_command="find \"$powerline_fonts_dir\" \( -name '$prefix*.[o,t]tf' -or -name '$prefix*.pcf.gz' \) -type f -print0"

if [[ `uname` == 'Darwin' ]]; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.fonts"
  mkdir -p $font_dir
fi

# Copy all fonts to user fonts directory
eval $find_command | xargs -0 -I % cp "%" "$font_dir/"

# Reset font cache on Linux
if [[ -n `which fc-cache` ]]; then
  fc-cache -f $font_dir
fi

echo "Powerline fonts installed to $font_dir"
