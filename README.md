# basic-dotfile-config
My personal configuration for neovim, zsh etc


## Remember

1. Names/commands
  - Compositor: picom
    - default config :   /etc/xdg/picom.conf
    - user config    :   .config/picom


## Universal scripts && commands

This is the place for some useful commands/mini scripts that work quite universally, so e. g. on all linux distros, all x11/wayland systems or just arch based-systems.

- Set keyboard layout
```sh
# X11
setxkbmap "us(colemak),ch" -option "grp:shifts_toggle"
setxkbmap "us(colemak),us,ch" -option "grp:shifts_toggle,caps:backspace"

# To get more options
grep -E "caps:" /usr/share/X11/xkb/rules/base.lst

# Worst case || Wayland || just to dive deeper: /usr/share/X11/xkb/
# There are great arch wiki articles for that
```
