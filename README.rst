Powerline fonts
===============

This repository contains pre-patched and adjusted fonts for usage with
the `Powerline <https://github.com/powerline/powerline>`_ statusline plugin.

Installation
------------

Run ``./install.sh`` to install all Powerline Fonts or see the documentation_ for details.

.. _documentation: https://powerline.readthedocs.org/en/latest/installation/linux.html#fonts-installation

Quick installation
------------------

If you are running a Debian or Ubuntu based Linux distribution, there should
be a package available to install the Powerline Fonts with the following command:
::
	sudo apt-get install fonts-powerline

On other environments, you can copy and paste these commands to your terminal. Comments are fine too.
::
    # clone
    git clone https://github.com/powerline/fonts.git --depth=1
    # install
    cd fonts
    ./install.sh
    # clean-up a bit
    cd ..
    rm -rf fonts

Uninstall
---------

Run ``./uninstall.sh`` to uninstall all Powerline Fonts. You can also copy
the quick installation commands changing only the line ``./install.sh`` to
``./uninstall.sh``.

In both cases, please make sure you are working with the exact same version
of Powerline fonts you had checked out while installing.

Font Families
-------------

======================================= ========================= ====================================
 Powerline Font Family                   Formerly Known As         License
======================================= ========================= ====================================
 3270                                    3270                      BSD/CCAS 3.0
 Anonymice Powerline                     Anonymous Pro             SIL Open Font License, Version 1.1
 Arimo Powerline                         Arimo                     Apache License, Version 2.0
 Cousine Powerline                       Cousine                   Apache License, Version 2.0
 D2Coding for Powerline                  D2Coding                  SIL Open Font License, Version 1.1
 DejaVu Sans Mono for Powerline          DejaVu Sans Mono          DejaVu Fonts License, Version 1.0
 Droid Sans Mono for Powerline           Droid Sans Mono           Apache License, Version 2.0
 Droid Sans Mono Dotted for Powerline    Droid Sans Mono Dotted    Apache License, Version 2.0
 Droid Sans Mono Slashed for Powerline   Droid Sans Mono Slashed   Apache License, Version 2.0
 Fura Mono Powerline                     Fira Mono                 SIL OPEN FONT LICENSE Version 1.1
 Go Mono for Powerline                   Go Mono                   Go's License
 Hack                                    Hack                      SIL OFL, v1.1 + Bitstream License
 Inconsolata for Powerline               Inconsolata               SIL Open Font License, Version 1.0
 Inconsolata-dz for Powerline            Inconsolata-dz            SIL Open Font License, Version 1.0
 Inconsolata-g for Powerline             Inconsolata-g             SIL Open Font License, Version 1.0
 Input Mono                              Input Mono                `Input’s license <http://input.fontbureau.com/license/>`_
 Liberation Mono Powerline               Liberation Mono           SIL Open Font License, Version 1.1
 ProFontWindows                          ProFont for Powerline     MIT License
 Meslo for Powerline                     Meslo                     Apache License, Version 2.0
 Source Code Pro for Powerline           Source Code Pro           SIL Open Font License, Version 1.1
 Meslo Dotted for Powerline              Meslo Dotted              Apache License, Version 2.0
 Meslo Slashed for Powerline             Meslo Dotted              Apache License, Version 2.0
 Monofur for Powerline                   Monofur                   Freeware
 Noto Mono for Powerline                 Noto Mono                 SIL Open Font License, Version 1.1
 Roboto Mono for Powerline               Roboto Mono               Apache License, Version 2.0
 Symbol Neu Powerline                    Symbol Neu                Apache License, Version 2.0
 Terminess Powerline                     Terminus                  SIL Open Font License, Version 1.1
 Tinos Powerline                         Tinos                     Apache License, Version 2.0
 Ubuntu Mono derivative Powerline        Ubuntu Mono               Ubuntu Font License, Version 1.0
 Space Mono for Powerline                Space Mono                SIL Open Font License, Version 1.1
======================================= ========================= ====================================

iTerm2 users need to set both the Regular font and the Non-ASCII Font in
"iTerm > Preferences > Profiles > Text" to use a patched font (per `this issue`__).

__ https://github.com/Lokaltog/powerline-fonts/issues/44

Fontconfig
----------

In some distributions, Terminess Powerline is ignored by default and must be 
explicitly allowed. A fontconfig file is provided which enables it. Copy `this
file <https://github.com/powerline/fonts/blob/master/fontconfig/50-enable-terminess-powerline.conf>`_
from the fontconfig directory to your home folder under ``~/.config/fontconfig/conf.d`` 
(create it if it doesn't exist) and re-run ``fc-cache -vf``.
