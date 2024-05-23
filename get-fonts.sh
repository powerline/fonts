#!/usr/bin/env bash

# This script is meant for quick & easy install via:

{ # this ensures the entire script is downloaded #

cd /tmp && git clone https://github.com/powerline/fonts.git --depth=1 && /tmp/fonts/install.sh && rm -rf /tmp/fonts

} # this ensures the entire script is downloaded #
