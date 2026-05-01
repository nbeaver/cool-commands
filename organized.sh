#! /usr/bin/env bash

# List wireless access points
sudo iwlist scanning
# https://hewlettpackard.github.io/wireless-tools/Tools
# DONE

# Find all files with 'cool' somewhere in the filename
find . -name  '*cool*'
# DONE

# Find all files with 'cool'/'COOL'/'CoOl' somewhere in the filename (case insensitive).
find . -iname  '*cool*'
# DONE

# Find all files ending in .html in current directory and subdirectories
find . -name '*.html'
# DONE

# Find vim swap files (e.g. .swp, .swo, .example.txt.swp):
find . -type f -name '*.sw?'
# DONE

# Find files with spaces in the filename.
find . -name '* *'
# DONE

# Find all files with world-readable, writable, and executable permissions.
find . -perm -a+rwx
# DONE

# Find directories that are world-writable.
find . -type d -perm -a+w
# DONE

# Find directories that aren't permissions 0775 (drwxr-xr-x).
find . -type d \! -perm 0775
# DONE

# Find files or directories that are not writable in the current directory.
find . \! -writable
# DONE

# Find files or directories that are not writable in the current directory.
# Not compliant with POSIX-standard `find` command.
find . -not -writable
# DONE

# Find files or directories that are not writable and make them writable again.
find . \! -writable -exec chmod --changes +w '{}' \+
# DONE

# Find all files with world-readable (777) permissions, but skip symbolic links.
find . \! -type l -perm 777
find . '!' -type l -perm 777
find . -not -type l -perm 777
# DONE

# Find directories and sort by permissions type.
find . -type d -printf '%m %p\n' | sort
# DONE

# Show permissions of a directory.
ls -ld /var/log
# Example output:
# drwxr-xr-x 23 root root 4096 May 23 08:18 /var/log
# DONE

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
# DONE

# Show permisisons in octal.
stat -c '%a %n' -- *
stat --format='%a %n' -- *
# https://askubuntu.com/questions/152001/how-can-i-get-octal-file-permissions-from-command-line
# DONE

# Show permissions in octal, but also include the human-readable permissions.
stat -c '%a %A %n' -- *
stat --format='%a %A %n' -- *
# https://askubuntu.com/questions/152001/how-can-i-get-octal-file-permissions-from-command-line
# DONE

# Show human-readable and octal permissions of files recursively.
find . -type f -printf "%m %M %f\n"
# https://unix.stackexchange.com/questions/126040/convert-the-permissions-in-ls-l-output-to-octal
# DONE

# Find all files over a certain size (500MB in this case.)
find . -size +500M
# https://superuser.com/questions/204564/how-can-i-find-files-that-are-bigger-smaller-than-x-bytes
# https://unix.stackexchange.com/questions/638335/find-command-size-behavior
# DONE

# Find smallest text files.
find . -name '*.txt' -printf '%s %f\n' | sort -n | head
find . -name '*.txt' -printf '%s ' -print
# DONE

# Find executables recursively.
find . -type f -executable -print
# DONE

# Find non-executable files recursively.
find . -type f \! -executable -print
# DONE

# Replace spaces with underscores for all filenames in current directory.
rename 'y/ /_/' -- *
# https://www.commandlinefu.com/commands/view/2518/replace-spaces-in-filenames-with-underscores
# DONE

# Replace colons with dashes for filenames in current directory.
rename 's/:/-/g' -- *
# DONE

# Replace colons with dashes recursively.
find . -name "*:*" -exec rename 's/:/-/g' {} \+
# DONE

# Remove colons from filenames recursively.
find . -name '*:*' -exec rename -n 's/://g' '{}' \+
# DONE

# Remove non-ASCII characters from filenames.
rename 's/[^\x00-\x7F]//g' -- *
# DONE

# Replace non-ASCII characters in filenames with underscores ('_').
rename 's/[^\x00-\x7F]/_/g' -- *
# DONE

# Rename all .jpeg files to .jpg.
rename 's/.jpeg/.jpg/' -- *.jpeg
# DONE

# Quick file rename using bash brace expansion.
mv file.{txt,csv}
# DONE

# Make a backup copy of a file with '.old' appended using bash brace expansion.
cp ~/.local/share/mime/mime.cache{,.old}
# http://www.shell-fu.org/lister.php?id=46
# DONE

# Match words that contain 'ae'.
grep 'ae' /usr/share/dict/words
# DONE

# Case-insensitive match for 'error' in system log file.
grep -i 'error' /var/log/syslog
# DONE

# Grep literal, raw strings without having to escape everything.
grep --fixed-strings '[1]' /var/log/syslog
# DONE

# Grep literal, raw strings without having to escape everything (short flags).
grep -F '[1]' /var/log/syslog
# DONE

# Grep the files under the /etc/ directory for the current machine's hostname.
grep "$HOSTNAME" /etc/*
# DONE

# Grep the files under the /etc/ directory for the current machine's hostname, showing only filename.
grep --files-with-matches "$HOSTNAME" /etc/*
# DONE

# Grep the files under the /etc/ directory for the current machine's hostname, showing only filename (short flags version).
grep -l "$HOSTNAME" /etc/*
# DONE

# Grep the /etc/ directory recursively for the current machine's hostname.
grep --recursive "$HOSTNAME" /etc/
# DONE

# Grep the /etc/ directory recursively for the current machine's hostname (short flags version).
grep -r "$HOSTNAME" /etc/
# DONE

# Grep the /etc/ directory recursively for words matching current machine's hostname.
grep --recursive --word-regexp "$HOSTNAME" /etc/
# DONE

# Grep the /etc/ directory recursively for words matching current machine's hostname (short flags version).
grep -rw "$HOSTNAME" /etc/
# DONE

# Grepping the system dictionary for words starting with 's'
# and containing 'm' and 'b';
# this is how samba was named.
grep -E -i '^S.*M.*B' /usr/share/dict/words
# http://www.rxn.com/services/faq/smb/samba.history.txt
# DONE

# Grepping the system dictionary for words starting with 's'
# and containing 'm' and 'b';
# this is how samba was named. (Short flags version.)
grep -i '^s.*m.*b' /usr/share/dict/words
# DONE

# Three-letter words without vowels, e.g. 'brr', 'nth', Mrs'.
grep -E -i "^[^aeiouy']{3}$" /usr/share/dict/words
# DONE

# All words without vowels.
grep -iv '[aeiouy]' /usr/share/dict/words
# DONE

# Words that can be spelled with hexadecimal alone, like 0xDEADBEEF.
grep -E -i "^[a-fA-F]+$" /usr/share/dict/words
# https://en.wikipedia.org/wiki/Magic_number_%28programming%29#Magic_debug_values
# http://www.urbandictionary.com/define.php?term=0xDEADBEEF
# https://stackoverflow.com/questions/5907614/0xdeadbeef-vs-null
# DONE

# Grep system dictionary for words that end in "gry"
grep -i '.*gry$' /usr/share/dict/words
# Example output:
# angry
# demagogry
# hungry
# DONE

# Generate a list of unique Icon fields in desktop files, not showing filenames.
grep --no-filename --recursive 'Icon=' --include='*.desktop' /usr/share/applications/ ~/.local/share/applications | sort --unique
# DONE

# Generate a list of unique Icon fields in desktop files, not showing filenames (short flags).
grep -hr 'Icon=' --include='*.desktop' /usr/share/applications/ ~/.local/share/applications | sort -u
# DONE

# Print how many cores the CPU has.
getconf _NPROCESSORS_ONLN
# Example output:
# 8
# https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line
# DONE

# Print how many cores the CPU has.
nproc
# Example output:
# 8
# https://stackoverflow.com/questions/6481005/how-to-obtain-the-number-of-cpus-cores-in-linux-from-the-command-line
# DONE

# Print maximum path length.
getconf PATH_MAX /
# Example output:
# 4096
# DONE

# Print operating system type (OS identifier).
echo "$OSTYPE"
# Note: bash-only.
# Example output:
# linux-gnu
# darwin13
# DONE

# Print operating system kernel name (OS identifier).
uname -s
# Example output:
# Darwin
# Linux
# DONE

# Print operating system name (OS identifier).
uname -o
# GNU-only extension.
# Example output:
# GNU/Linux
# DONE

# List all signals.
compgen -A signal
# DONE

# See a list of all functions.
compgen -A function
# DONE

# List of all shell functions, aliases, and variables.
declare
# DONE

# Identify what kind of command 'ls' is
type ls
# Example output:
# ls is aliased to `ls --color=auto'
# DONE

# Print all the definitions of 'ls', including executables in $PATH, aliases, functions, and builtins.
type -a ls
# Example output:
# ls is aliased to `ls --color=auto'
# ls is /bin/ls
# DONE

# Run the "real" `ls', for when it is aliased.
command ls
# DONE

# A method to run the un-aliased version of `ls'.
\ls
# DONE

# Print all the definitions of 'echo'
type -a echo
# Example output:
# echo is a shell builtin
# echo is /usr/bin/echo
# echo is /bin/echo
# DONE

# Print all the definitions of 'time'
type -a time
# Example output:
# time is a shell keyword
# time is /usr/bin/time
# time is /bin/time
# DONE

# Identify the kind of command 'ipython' is.
type -a ipython
# Example output:
# ipython is /home/username/.local/bin/ipython
# ipython is /usr/bin/ipython
# DONE

# See where the function `quote` was defined.
shopt -s extdebug; declare -F quote; shopt -u extdebug
# DONE

# make bash re-read modified .bashrc file
source .bashrc
# DONE

# search apt packages for 'my-package', case insensitive
apt-cache search my-package
# DONE

# For when you only want to see 'gnash', not 'blah-gnash' or 'gnash-blah'
apt-cache search --names-only '^gnash$'
# DONE

# For when you only want to see 'mc', not '*mc*'
apt-cache search --names-only '^mc$'
# DONE

# Find package descriptions that are longer than 4000 characters.
apt-cache search '.{4000,}'
# DONE

# Find out what kind of files are in the current directory and its subdirectories.
find . -type f -exec file '{}' \; | less
# Reference: man find or
# https://stackoverflow.com/questions/21155287/shell-notation-find-type-f-exec-file
# https://stackoverflow.com/questions/20913198/why-are-the-backslash-and-semicolon-required-with-the-find-commands-exec-optio
# DONE

# Execute /usr/bin/file on every file and directory below current directory
find . -exec file '{}' + | less
# DONE

# Show filesystem information for root directory.
findmnt /
# Example output:
# TARGET
#   SOURCE         FSTYPE OPTIONS
# / /dev/nvme0n1p2 ext4   rw,relatime,stripe=64
# DONE

# List all filesystems.
findmnt --all
# DONE

# Inspect text files for encoding information including line breaks, byte order
# mark (BOM), and text/binary.
dos2unix --info -- *
# Example output:
#     6       0       0  no_bom    text    dos.txt
#     0       6       0  no_bom    text    unix.txt
#     0       0       6  no_bom    text    mac.txt
#     6       6       6  no_bom    text    mixed.txt
#    50       0       0  UTF-16LE  text    utf16le.txt
#     0      50       0  no_bom    text    utf8unix.txt
#    50       0       0  UTF-8     text    utf8dos.txt
#     2     418     219  no_bom    binary  dos2unix.exe
# DONE

# List all encodings iconv can handle.
iconv --list
# DONE

# Convert from little-endian UTF-16 to UTF-8.
iconv --from-code UTF-16LE --to-code UTF-8 utf16.txt > utf8.txt
# DONE

# Get CPU architecture by parsing JSON output of lscpu.
lscpu --json | jq -r '.lscpu[] | select(.field=="Architecture:").data'
# Example output:
# x86_64
# DONE

# Get CPU model by parsing JSON output of lscpu.
lscpu --json | jq -r '.lscpu[] | select(.field=="Model name:").data'
# Example output:
# 11th Gen Intel(R) Core(TM) i7-1185G7 @ 3.00GHz
# DONE

# Windows command to just show files without extra information.
dir /b
# /b  Displays a bare list of directories and files, with no additional information. The /b parameter overrides /w.
# https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/dir
# DONE

# Save Windows version information to a text file.
systeminfo > systeminfo.txt
# DONE

# Interactively adjust volume and other sound settings.
alsamixer
# DONE

# Mute master sound
amixer set Master mute
# DONE

# Unmute master sound
amixer set Master unmute
# DONE

# Set master to 50%.
amixer set Master 50
# http://www.tldp.org/HOWTO/Alsa-sound-6.html
# http://www.linuxjournal.com/content/change-volume-bash-script
# DONE

# See master settings.
amixer get Master
# Example output:
# Simple mixer control 'Master',0
#   Capabilities: pvolume pswitch pswitch-joined
#   Playback channels: Front Left - Front Right
#   Limits: Playback 0 - 65536
#   Mono:
#   Front Left: Playback 19066 [29%] [on]
#   Front Right: Playback 18600 [28%] [on]
# DONE

# Show sound cards and headsets.
cat /proc/asound/cards
# Example output:
#  0 [PCH            ]: HDA-Intel - HDA Intel PCH
#                       HDA Intel PCH at 0xf2420000 irq 33
# DONE

# Get default sink for PulseAudio.
pactl get-default-sink
# Example output:
# alsa_output.pci-0000_00_1f.3.analog-stereo
# DONE

# Find non-executables in /bin/ and /usr/bin/
find /bin/ /usr/bin/ -type f -not -executable -print
# DONE

# Get batch output for process ID 10104 using top.
top --batch --iterations=1 --threads-show --pid=10104 > top.txt
# https://unix.stackexchange.com/questions/138484/what-does-batch-mode-mean-for-the-top-command
# https://superuser.com/questions/1610061/why-are-results-from-top-in-batch-mode-different-than-from-interactive-top
# https://unix.stackexchange.com/questions/147471/is-there-a-way-to-get-top-to-run-exactly-once-and-exit
# DONE

# Get batch output for process ID 10104 using top (short flags).
top -b -n 1 -H -p 10104 > top.txt
# https://unix.stackexchange.com/questions/138484/what-does-batch-mode-mean-for-the-top-command
# https://superuser.com/questions/1610061/why-are-results-from-top-in-batch-mode-different-than-from-interactive-top
# https://unix.stackexchange.com/questions/147471/is-there-a-way-to-get-top-to-run-exactly-once-and-exit
# DONE

# Figure out which speaker or earphone is left and right. Note that you have to pause other sound playback for this to work or you will get a "Device or resource busy" error.
speaker-test --device plug:front --channels 2 --test sine --frequency 100 # long version
# DONE

# Figure out which speaker or earphone is left and right (short flags). Note that you have to pause other sound playback for this to work or you will get a "Device or resource busy" error.
speaker-test -Dplug:front -c2 -t sine -f100
# DONE

# Save a transcript of terminal session to the file `typescript' in current directory.
script
# http://linuxers.org/article/script-command-line-tool-recordsave-your-terminal-activity
# DONE

# Save a transcript of terminal session, immediately flushing output to `typescript' file in current directory.
script --flush
# DONE

# Save a transcript of terminal session to `typescript.out', saving timing information to `typescript.tm'.
script --timing=typescript.tm --flush typescript.out
# DONE

# Save a transcript of terminal session to `typescript.out', saving timing information to `typescript.tm' (new output format).
script --log-timing=typescript.tm --flush --log-out typescript.out
# DONE

# Save a transcript of terminal session to `typescript.out', saving timing information to `typescript.tm'.
script -T typescript.tm -f -O typescript.out
# DONE

# View the typescript generated by script(1).
less -r typescript
# DONE

# Replay the typescript generated by script(1).
scriptreplay --log-timing typescript.tm --log-out typescript.out
# DONE

# Replay the typescript generated by script(1), short flags.
scriptreplay -T typescript.tm -O typescript.out
# DONE

# Take a screenshot on the GNOME desktop with a 1-second delay and a timestamped filename.
gnome-screenshot --delay=1 --file="$(date +'%Y-%m-%d_%H_%M_%S').png"
# https://stackoverflow.com/questions/8228047/adding-timestamp-to-a-filename-with-mv-in-bash
# https://askubuntu.com/questions/202391/bash-script-to-take-screenshot-and-save-the-image-ubuntu
# DONE

# Use history expansion to append the last interactive command to a file called 'my-commands.sh'.
echo !! >> my-commands.sh
# https://unix.stackexchange.com/questions/38072/how-can-i-save-the-last-command-to-a-file
# https://unix.stackexchange.com/questions/3747/understanding-the-exclamation-mark-in-bash
# https://www.gnu.org/software/bash/manual/html_node/History-Interaction.html
# DONE

# Append a file onto another file (a non-useless use of cat).
cat my-commands.sh >> big-command-list.sh
# https://www.cyberciti.biz/faq/unix-linux-cat-append-text-to-a-file/
# https://stackoverflow.com/questions/4969641/how-to-append-one-file-to-another-in-linux-from-the-shell
# https://unix.stackexchange.com/questions/355342/appending-one-file-to-another
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# DONE

# See what piped output looks like for commands like ls(1) that detect output with isatty (a non-useless use of cat).
ls | cat
# https://unix.stackexchange.com/questions/22162/ls-command-operating-differently-depending-on-recipient
# https://stackoverflow.com/questions/8584356/why-does-ls-give-different-output-when-piped
# DONE

# View both stdout and stderr using input/output redirection.
{ echo "stdout"; echo "stderr" >&2; } 2>&1 | less
# https://stackoverflow.com/questions/16497317/piping-both-stdout-and-stderr-in-bash
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# DONE

# Pipe stdout and stderr together to another command (bash only).
{ echo "stdout"; echo "stderr" >&2; } |& less
# https://stackoverflow.com/questions/16497317/piping-both-stdout-and-stderr-in-bash
# componentCommands: echo, less
# DONE

# Redirect stdout to file
{ echo "stdout"; echo "stderr" >&2; } > stdout_log.txt
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file
# componentCommands: echo
# DONE

# Redirect stderr to file
{ echo "stdout"; echo "stderr" >&2; } 2> stderr_log.txt
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# componentCommands: echo
# DONE

# Redirect both stdout and stderr to text file (bash only).
{ echo "stdout"; echo "stderr" >&2; } &> full_log.txt
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# componentCommands: echo
# DONE

# Redirect both stdout and stderr to text file (note that `2>&1' must come after `>').
{ echo "stdout"; echo "stderr" >&2; } > stdout_stderr_log.txt 2>&1
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# componentCommands: echo
# DONE

# Redirect both stdout and stderr to text file and view in pager.
{ echo "stdout"; echo "stderr" >&2; } 2>&1 | tee stdout_stderr_log.txt | less
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# componentCommands: echo, less
# DONE

# Append both stdout and stderr to text file (note that `2>&1' must come after `>').
{ echo "stdout"; echo "stderr" >&2; } >> append_stdout_stderr_log.txt 2>&1
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# https://stackoverflow.com/questions/876239/how-to-redirect-and-append-both-standard-output-and-standard-error-to-a-file-wit
# componentCommands: echo
# DONE

# Append both stdout and stderr to text file (bash only).
{ echo "stdout"; echo "stderr" >&2; } &>> append_stdout_stderr_log.txt
# https://stackoverflow.com/questions/876239/how-to-redirect-and-append-both-standard-output-and-standard-error-to-a-file-wit
# https://askubuntu.com/questions/420981/how-do-i-save-terminal-output-to-a-file
# componentCommands: echo
# DONE

# Suppress stdout and view only stderr in pager
{ echo "stdout"; echo "stderr" >&2; } >/dev/null 2>&1 | less
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# https://stackoverflow.com/questions/2342826/how-can-i-pipe-stderr-and-not-stdout/
# componentCommands: echo, less
# DONE

# View both stdout and stderr from ffmpeg filters in pager using input/output redirection.
ffmpeg -filters 2>&1 | less
# https://stackoverflow.com/questions/16497317/piping-both-stdout-and-stderr-in-bash
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# DONE

# View only stderr in pager using input/output redirection.
ffmpeg -filters 2>&1 >/dev/null | less
# https://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout
# https://www.gnu.org/software/bash/manual/html_node/Redirections.html
# DONE

# View compose-key combinations for current language.
less /usr/share/X11/locale/$LANG/Compose
# https://aty.sdsu.edu/bibliog/latex/debian/compose.html
# https://superuser.com/questions/74763/how-to-type-unicode-characters-in-kde
# https://userbase.kde.org/Tutorials/ComposeKey
# https://wiki.debian.org/XCompose
# DONE

# Make Dropbox ignore file 'C:\Users\yourname\Dropbox (Personal)\YourFileName.pdf'.
Set-Content -Path 'C:\Users\yourname\Dropbox (Personal)\YourFileName.pdf' -Stream com.dropbox.ignored -Value 1
# https://help.dropbox.com/sync/ignored-files
# shell: PowerShell
# componentCommands: Set-Content
# DONE

# Grep HTTP requests from wget.
wget --timeout=3 --tries=1 --spider --no-check-certificate 'http://google.com' |& grep 'HTTP request\|Location:'
# componentCommands: wget, grep
# DONE

# List all extended attributes of files / folders in current directory.
getfattr -dm- -- *
# componentCommands: getfattr
# https://superuser.com/questions/858210/how-can-you-show-list-all-extended-attributes-in-linux
# https://unix.stackexchange.com/questions/180019/why-doesnt-getfattr-d-show-anything
# DONE

# Ignore a file in Dropbox folder so it isn't synced. This sets the extended attribute 'com.dropbox.ignored' to 1.
attr -s com.dropbox.ignored -V 1 ~/'Dropbox/file-to-ignore.pdf'
# https://help.dropbox.com/sync/ignored-files
# componentCommands: attr
# DONE

# Ignore a file in Dropbox folder so it isn't synced. This sets the extended attribute 'com.dropbox.ignored' to 1.
setfattr -n com.dropbox.ignored -v 1 ~/'Dropbox/file-to-ignore.pdf'
# https://help.dropbox.com/sync/ignored-files
# componentCommands: setfattr
# DONE

# Remove 'com.dropbox.ignored' attribute for a file in Dropbox folder so it syncs again.
attr -r com.dropbox.ignored ~/'Dropbox/file-to-ignore.pdf'
# https://help.dropbox.com/sync/ignored-files
# componentCommands: attr
# DONE

# Remove 'com.dropbox.ignored' attribute for a file in Dropbox folder so it syncs again.
setfattr -x com.dropbox.ignored ~/'Dropbox/file-to-ignore.pdf'
# https://help.dropbox.com/sync/ignored-files
# componentCommands: setfattr
# DONE

# Ignore a Git repo folder in Dropbox folder so it isn't synced.
attr -s com.dropbox.ignored -V 1 ~/'Dropbox/example-repo/.git'
# https://help.dropbox.com/sync/ignored-files
# componentCommands: attr
# DONE

# Split out a single page of a PDF (page 17 in this case).
pdftk example.pdf cat 17 output page-17.pdf
# componentCommands: pdftk
# DONE

# Get a range of pages from a PDF (10 through 12 and 17 to the end in this case).
pdftk myoldfile.pdf cat 10-12 17-end output mynewfile.pdf
# componentCommands: pdftk
# https://askubuntu.com/questions/221962/how-can-i-extract-a-page-range-a-part-of-a-pdf
# https://stackoverflow.com/questions/17776582/split-a-pdf-in-two
# https://superuser.com/questions/1882737/remove-the-first-three-pages-of-a-pdf-file-using-pdftk
# https://unix.stackexchange.com/questions/796293/how-do-i-extract-some-pages-of-a-pdf-into-another-pdf-file
# http://linuxcommando.blogspot.com/2013/02/splitting-up-is-easy-for-pdf-file.html
# DONE

# Remove last page of a PDF.
pdftk example.pdf cat '1-r2' output last-page-removed.pdf
# componentCommands: pdftk
# https://stackoverflow.com/questions/17705974/remove-the-last-page-of-a-pdf-file-using-pdftk
# https://www.pdflabs.com/docs/pdftk-cli-examples/
# DONE

# Get all but a single page (number 17 in this case).
pdftk myoldfile.pdf cat '~17' output mynewfile.pdf
# componentCommands: pdftk
# DONE

# Extract pages 1-4 of a PDF using GhostScript.
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=1 -dLastPage=4 -sOutputFile=example-pages1-4.pdf example.pdf
# http://linuxcommando.blogspot.com/2014/01/how-to-split-up-pdf-files-part-2.html
# componentCommands: gs
# DONE

# Use snap to run an application directly.
snap run slack

# Enable debug mode for slack snap package.
snap set slack debugmode=true
# https://forum.snapcraft.io/t/slack-snap-stopped-working-after-ubuntu-updates/51066/4
# componentCommands: snap
