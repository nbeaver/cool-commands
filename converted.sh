#! /usr/bin/env bash

# List wireless access points
sudo iwlist scanning
# https://hewlettpackard.github.io/wireless-tools/Tools

# Find all files with 'cool' somewhere in the filename
find . -name  '*cool*'

# Find all files with 'cool'/'COOL'/'CoOl' somewhere in the filename (case insensitive).
find . -iname  '*cool*'

# Find all files ending in .html in current directory and subdirectories
find . -name '*.html'

# Find vim swap files (e.g. .swp, .swo, .example.txt.swp):
find . -type f -name '*.sw?'

# Find files with spaces in the filename.
find . -name '* *'

# Find all files with world-readable, writable, and executable permissions.
find . -perm -a+rwx

# Find directories that are world-writable.
find . -type d -perm -a+w

# Find directories that aren't permissions 0775 (drwxr-xr-x).
find . -type d \! -perm 0775

# Find files or directories that are not writable in the current directory.
find . \! -writable

# Find files or directories that are not writable in the current directory.
# Not compliant with POSIX-standard `find` command.
find . -not -writable

# Find files or directories that are not writable and make them writable again.
find . \! -writable -exec chmod --changes +w '{}' \+

# Find all files with world-readable (777) permissions, but skip symbolic links.
find . \! -type l -perm 777
find . '!' -type l -perm 777
find . -not -type l -perm 777

# Find directories and sort by permissions type.
find . -type d -printf '%m %p\n' | sort

# Show permissions of a directory.
ls -ld /var/log
# Example output:
# drwxr-xr-x 23 root root 4096 May 23 08:18 /var/log

# Show permissions of a directory.
stat /var/log
# Example output:
#   File: ‘/var/log’
#   Size: 4096      	Blocks: 8          IO Block: 4096   directory
# Device: 801h/2049d	Inode: 30416373    Links: 23
# Access: (0755/drwxr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
# Access: 2016-05-23 09:59:45.411033488 -0500
# Modify: 2016-05-23 08:18:12.333311420 -0500
# Change: 2016-05-23 08:18:12.333311420 -0500
#  Birth: -

# Show permisisons in octal.
stat -c '%a %n' -- *
stat --format='%a %n' -- *
# https://askubuntu.com/questions/152001/how-can-i-get-octal-file-permissions-from-command-line

# Show permissions in octal, but also include the human-readable permissions.
stat -c '%a %A %n' -- *
stat --format='%a %A %n' -- *
# https://askubuntu.com/questions/152001/how-can-i-get-octal-file-permissions-from-command-line

# Show human-readable and octal permissions of files recursively.
find . -type f -printf "%m %M %f\n"
# https://unix.stackexchange.com/questions/126040/convert-the-permissions-in-ls-l-output-to-octal

# Find all files over a certain size (500MB in this case.)
find . -size +500M
# https://superuser.com/questions/204564/how-can-i-find-files-that-are-bigger-smaller-than-x-bytes
# https://unix.stackexchange.com/questions/638335/find-command-size-behavior

# Find smallest text files.
find . -name '*.txt' -printf '%s %f\n' | sort -n | head
find . -name '*.txt' -printf '%s ' -print

# Find executables recursively.
find . -type f -executable -print

# Find non-executable files recursively.
find . -type f \! -executable -print

# Replace spaces with underscores for all filenames in current directory.
rename 'y/ /_/' -- *
# https://www.commandlinefu.com/commands/view/2518/replace-spaces-in-filenames-with-underscores

# Replace colons with dashes for filenames in current directory.
rename 's/:/-/g' -- *

# Replace colons with dashes recursively.
find . -name "*:*" -exec rename 's/:/-/g' {} \+

# Remove colons from filenames recursively.
find . -name '*:*' -exec rename -n 's/://g' '{}' \+

# Remove non-ASCII characters from filenames.
rename 's/[^\x00-\x7F]//g' -- *

# Replace non-ASCII characters in filenames with underscores ('_').
rename 's/[^\x00-\x7F]/_/g' -- *

# Rename all .jpeg files to .jpg.
rename 's/.jpeg/.jpg/' -- *.jpeg

# Quick file rename using bash brace expansion.
mv file.{txt,csv}

# Make a backup copy of a file with '.old' appended using bash brace expansion.
cp ~/.local/share/mime/mime.cache{,.old}
# http://www.shell-fu.org/lister.php?id=46

# Grepping the system dictionary for words starting with 's'
# and containing 'm' and 'b';
# this is how samba was named:
grep -E -i '^S.*M.*B' /usr/share/dict/words
# http://www.rxn.com/services/faq/smb/samba.history.txt
grep -i '^s.*m.*b' /usr/share/dict/words

# Three-letter words without vowels, e.g. 'brr', 'nth', Mrs'.
grep -E -i "^[^aeiouy']{3}$" /usr/share/dict/words

# All words without vowels.
grep -iv '[aeiouy]' /usr/share/dict/words

# Words that can be spelled with hexadecimal alone, like 0xDEADBEEF.
grep -E -i "^[a-fA-F]+$" /usr/share/dict/words
# https://en.wikipedia.org/wiki/Magic_number_%28programming%29#Magic_debug_values
# http://www.urbandictionary.com/define.php?term=0xDEADBEEF
# https://stackoverflow.com/questions/5907614/0xdeadbeef-vs-null

# Grep system dictionary for words that end in "gry"
grep -i '.*gry$' /usr/share/dict/words
# Example output:
# angry
# demagogry
# hungry

# Print how many cores the CPU has.
getconf _NPROCESSORS_ONLN
# Example output:
# 8
# https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line

# Print how many cores the CPU has.
nproc
# Example output:
# 8
# https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line

# Print maximum path length.
getconf PATH_MAX /
# Example output:
# 4096

# Print operating system type (OS identifier).
echo "$OSTYPE"
# Note: bash-only.
# Example output:
# linux-gnu
# darwin13

# Print operating system kernel name (OS identifier).
uname -s
# Example output:
# Darwin
# Linux

# Print operating system name (OS identifier).
uname -o
# GNU-only extension.
# Example output:
# GNU/Linux

# List all signals.
compgen -A signal

