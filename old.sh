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

# Extract pages 1-4 of a PDF using ImageMagick. Note that this only preserves images, not text or layout.
convert file1.pdf[0-3] output.pdf
# componentCommands: convert
# http://linuxcommando.blogspot.com/2015/03/how-to-merge-or-split-pdf-files-using.html

# Merge page 1 of file1.pdf with pages 1, 2, and 4 of file2.pdf to output.pdf using ImageMagick.  Note that this only preserves images, not text or layout.
convert file1.pdf[0] file2.pdf[0-1,3] output.pdf
# componentCommands: convert
# http://linuxcommando.blogspot.com/2015/03/how-to-merge-or-split-pdf-files-using.html

# Rename all .png files by prepending 'digital_media_archive_assistant_' to the filename:
rename --no-act 's/^/digital_media_archive_assistant_/' *.png
# This would work also:
for i in *.png; do mv $i digital_media_archive_assistant_$i; done

# Rename all files starting with Ch so that they now end with .doc.
# Dry run with --no-act --verbose to check for correctness.
rename -nv 's/$/.doc/' Ch*
rename --no-act --verbose 's/$/.doc/' Ch*

# Rename all files starting with Ch so that they now end with .doc.
rename 's/$/.doc/' Ch*

# Rename all files ending with .csv so that they end with .dat instead.
# Also handles names with spaces and weird names like my.csv.file.csv properly.
rename -nv 's/\.csv$/\.dat/' *.csv

# Rename files so that Cu becomes C
rename -nv 's/Cu/C/' Te_Na2Cu2Te.*
rename 's/Cu/C/' Te_Na2Cu2Te.*
# Te_Na2Cu2Te.001 renamed as Te_Na2C2Te.001

# Rename folders starting with 2014 so that they start with 2015 instead.
rename  's/2014/2015/' 2014*

# Search for a package in all debian releases by querying http://qa.debian.org/cgi-bin/dcontrol
dcontrol warsow | less

# Show the release for the package.
dcontrol --show-suite warsow | less

