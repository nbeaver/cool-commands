#! /usr/bin/env bash

# Connecting to s-video out, changing display resolution, connecting to projector or external display
xrandr

# Reset screen resolution if another program goofs it up
xrandr -s 1600x900
xrandr --size 1600x900

# Automatically turn on a second screen connected with VGA
xrandr --output VGA --auto

# Clone screens
xrandr --output VGA --same-as LVDS

# Extend screens
xrandr --output VGA --left-of LVDS
# http://forums.debian.net/viewtopic.php?f=10&t=40955

# Find all files containing text 'NBMAX' and ending in .F90
find . -name '*.F90' | xargs grep 'NBMAX'

# Visit vim swap files.
find . -name '*.sw?' | visit_paths.py

# Create permissions report.
find . -printf '%m\n' | sort | uniq -c | tee permissions-report.txt | less

# Find all files with world-readable (777) permissions.
find . -perm 777
find . -perm -g+s
find . -perm -o+r
# https://askubuntu.com/questions/151615/how-do-i-list-the-public-files-in-my-home-directory-mode-777
# https://superuser.com/questions/396513/how-to-filter-files-with-specific-permissions-or-attributes-while-running-ls
# TODO: what is the right way to do this?

# Fix permissions recursively by changing 777 (world readable) to 755.
find . -perm 777 -exec chmod 755 '{}' \;
find . -perm 777 -exec chmod 775 '{}' \;
# TODO: what is the right way to do this?

# Find a writable file owned by root.
find / -xdev -user root -perm -u+w -name hello 2>/dev/null
# https://unix.stackexchange.com/questions/17556/how-to-find-a-writable-file-owned-by-root

# View only files not ending in '.txt'
ls --ignore=*.txt

# Viewing active processes
top

# Sorting by memory
top -o %MEM
# Interactively
# f # field management
# (navigate to %MEM)
# s # sort
# q # go back to output

