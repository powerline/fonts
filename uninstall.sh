#!/bin/bash

# Set source and target directories
powerline_fonts_dir="$( cd "$( dirname "$0" )" && pwd )"

# if an argument is given it is used to select which fonts to uninstall
prefix="$1"

if test "$(uname)" = "Darwin" ; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.local/share/fonts"
  if test ! -d "$font_dir" ; then
    echo "It seems there are no powerline fonts installed on your system. Uninstall not needed."
    exit 0
  fi
fi

# Remove all fonts from user fonts directory
echo "Removing fonts..."
find "$powerline_fonts_dir" \( -name "$prefix*.[ot]tf" -or -name "$prefix*.pcf.gz" \) -type f -print0 | xargs -n1 -0 -I % sh -c "rm -f \"\$0/\${1##*/}\"" "$font_dir" %

# Reset font cache on Linux
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi

echo "Powerline fonts uninstalled from $font_dir"
