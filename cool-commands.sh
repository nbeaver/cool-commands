#! /usr/bin/env bash
# Put this at the top
# to Prevent this file from being run as a shell script.
printf "ERROR: do not run this as a shell script.\n" >&2
exit 1

# Wireless access points
sudo iwlist scanning | less

# Connecting to s-video out, changing display resolution, connecting to projector or external display
xrandr
# Reset screen resolution if another program goofs it up
xrandr -s 1600x900
xrandr --size 1600x900

# Automatically turn on a second screen
xrandr --output VGA --auto
# Clone screens
xrandr --output VGA --same-as LVDS
# Extend screens
xrandr --output VGA --left-of LVDS
# http://forums.debian.net/viewtopic.php?f=10&t=40955

# Finding in directories beneath
# Find all files containing text 'NBMAX' and ending in .F90
find . -name '*.F90' | xargs grep 'NBMAX'
# Find all files with 'cool' somewhere in the name
find . -name  '*cool*'
# Find all files ending in .html in current directory and subdirectories
find . -name '*.html'

# Find vim swap files (e.g. .swp, .swo, .example.txt.swp):
find . -type f -name '*.sw?'
# Visit those swap files.
find . -name '*.sw?' | visit_paths.py

# Find files with spaces in the filename.
find . -name '* *'

# Find all files with certain permissions.
# World-readable (777)
find . -perm 777

find . -perm -g+s
# World readable, writable, and executable.
find . -perm -a+rwx
# Find directories that are world-writable.
find . -type d -perm -a+w

# Find directories that aren't permissions 0775 (drwxr-xr-x).
find . -type d \! -perm 0775

# Find files or directories that are not writable in the current directory.
find . \! -writable
# Equivalent, but not compliant with POSIX-standard `find` command.
find . -not -writable

# Make them writable again.
find . \! -writable -exec chmod --changes +w '{}' \+ | less

# https://askubuntu.com/questions/151615/how-do-i-list-the-public-files-in-my-home-directory-mode-777
# https://superuser.com/questions/396513/how-to-filter-files-with-specific-permissions-or-attributes-while-running-ls
# https://askubuntu.com/questions/151615/how-do-i-list-the-public-files-in-my-home-directory-mode-777
# Skip symbolic links.
find . \! -type l -perm 777
find . '!' -type l -perm 777
find . -not -type l -perm 777

# Find directories and sort by permissions type.
find . -type d -printf '%m %p\n' | sort | less

# Create permissions report.
find . -printf '%m\n' | sort | uniq -c | tee permissions-report.txt | less

# Fix permissions recursively.
find . -perm 777 -exec chmod 755 '{}' \;
find . -perm 777 -exec chmod 775 '{}' \;

# Find a writable file owned by root.
find / -xdev -user root -perm -u+w -name hello 2>/dev/null
# https://unix.stackexchange.com/questions/17556/how-to-find-a-writable-file-owned-by-root


# Show permissions of a directory.
ls -ld /var/log
# drwxr-xr-x 23 root root 4096 May 23 08:18 /var/log
stat /var/log
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
# Include the human-readable permissions.
stat -c '%a %A %n' -- *
# https://askubuntu.com/questions/152001/how-can-i-get-octal-file-permissions-from-command-line

# Show human-readable and octal permissions of files recursively.
find . -type f -printf "%m %M %f\n" | less
# https://unix.stackexchange.com/questions/126040/convert-the-permissions-in-ls-l-output-to-octal

# Find all files over a certain size (500MB in this case.)
find . -size +500M

# Find smallest text files.
find . -name '*.txt' -printf '%s %f\n' | sort -n | head
find . -name '*.txt' -printf '%s ' -print | less

# Find executables.
find . -type f -executable -print
# Find non-executables.
find . -type f \! -executable -print
find . -type f -not -executable -print
find /usr/bin/ -type f -not -executable -print
find /bin/ -type f -not -executable -print

# View only files not ending in '.txt'
ls --ignore=*.txt

# Viewing active processes
top
# Sorting by memory
top -o %MEM
# Interactively
f
# (navigate to %MEM)
s
q

# Get batch output from top.
top -b -n 1 -H -p 10104 > top.txt

# Changing sound settings
alsamixer

# Show sound cards and headsets.
cat /proc/asound/cards

# Figure out which speaker is left and right
speaker-test -Dplug:front -c2 -t sine -f100
speaker-test --device plug:front --channels 2 --test sine --frequency 100 # long version
# You have to pause other sound playback for this to work.

# Append last command to this text file
echo !! >> ~/Dropbox/how-to/cool-commands.txt
# This is useful if you want to run it as a shell script. You can also just save it to a shell script like this:
echo !! > my-script.sh

# Append a file onto another file.
# (A non-useless use of cat).
cat commands.sh >> ~/.bash_history

# See what piped output looks like
# (another non-useless use of cat).
ls * | cat

# Append a line to a non-empty file.
sed -i '$ a\this is a line of text' myfile.txt

# Grepping
grep PHY unofficial-transcript-11-24-11.txt
grep ALLOCATE COORD *.F90
grep -Fxv -f DERIVT.F90 MODULE.F90 # subtract first file from second file
grep -Fx -f DERIVT.F90 MODULE.F90 # intersection of first file and second file
grep --fixed-strings --line-regexp --invert-match --file=DERIVT.F90 MODULE.F90 # long version
grep --recursive dveff *.f90
grep '=>' *.f90
grep --recursive *.mp3 .
grep Offenbach .
ls --recursive | grep kim *.f90
grep --ignore-case --recursive "kim_api" . --include=*.f90
grep --recursive "kim-str" .

time grep "hi"

ls /usr/bin | grep "csound"

nano | ls | grep "ann"

# Grepping literal, raw strings without having to escape everything.
grep -F
grep --fixed-strings

grep -rF '[*'
# instead of
grep -r '\[\*'

find | grep NBMAX *.F90

# View error messages in less by redirecting stderr to stdout
bash compile.sh 2>&1 | less
bash compile.sh 2>&1 >/dev/null | less
# https://stackoverflow.com/questions/2342826/how-to-pipe-stderr-and-not-stdout
# Send stderr to text file
bash env.sh 2> err_log.txt
# Send stdout and stderr to text file
bash env.sh &> full_log.txt
bash env.sh > full_log.txt 2>&1
# This won't work.
bash env.sh 2>&1 > full_log.txt

# If you want to pipe stdout and stderr together:
command > /dev/null |& grep "something"
# e.g.
make > /dev/null |& grep "something"
# another example:
wget --timeout=3 --tries=1 --spider --no-check-certificate http://google.com |& grep 'HTTP request'
# Shorter version:
wget --spider http://google.com |& grep 'HTTP request\|Location:'

# Return all lines containing "kim_api" (case insensitive) and ending with .f90
grep -ir "kim_api" . --include=*.f90
grep -ir 'discrepancy' /var/log/messages | less

# Rename all .png files by prepending 'digital_media_archive_assistant_' to the filename:
rename --no-act 's/^/digital_media_archive_assistant_/' *.png
# This would work also:
for i in *.png; do mv $i digital_media_archive_assistant_$i; done

# Rename all files starting with Ch so that they now end with .doc.
rename -nv 's/$/.doc/' Ch*
rename --no-act --verbose 's/$/.doc/' Ch*
rename -v 's/$/.doc/' Ch*

# Rename all files ending with .csv so that they end with .dat instead.
# Also handles names with spaces and weird names like my.csv.file.csv properly.
rename -nv 's/\.csv$/\.dat/' *.csv

# Rename files so that Cu becomes C
rename -nv 's/Cu/C/' Te_Na2Cu2Te.*
rename 's/Cu/C/' Te_Na2Cu2Te.*
# Te_Na2Cu2Te.001 renamed as Te_Na2C2Te.001

# From commandlinefu.com
rename 'y/ /_/' * # replace spaces with underscores
# https://www.commandlinefu.com/commands/view/2518/replace-spaces-in-filenames-with-underscores

# Replace colons with dashes.
rename 's/:/-/g' *
# Do it hierarchically.
find . -name "*:*" -exec rename 's/:/-/g' {} \+

# Remove the colons entirely.
find . -name '*:*' -exec rename -n 's/://g' '{}' \+

# Do the same with pipe characters.
find . -name '*|*' -exec rename -n 's/\|//g' '{}' \+

# Rename folders starting with 2014 so that they start with 2015 instead.
rename  's/2014/2015/' 2014*

# Rename all .jpeg files to .jpg.
rename 's/.jpeg/.jpg/' *.jpeg

# Remove non-ASCII characters from filenames.
rename 's/[^\x00-\x7F]//g' *
# Replace non-ASCII characters in filenames with underscores ('_').
rename 's/[^\x00-\x7F]/_/g' *

mv file.{txt,csv} # Quick file rename using brace expansion.

# Similarly, can make a copy of a copy to work on the live.
cp ~/.local/share/mime/mime.cache{,.old}
# http://www.shell-fu.org/lister.php?id=46

# Using the system dictionary;
# this is how samba was named:
egrep -i '^S.*M.*B' /usr/share/dict/words
# http://www.rxn.com/services/faq/smb/samba.history.txt
grep -i '^s.*m.*b' /usr/share/dict/words

# Three-letter words without vowels, e.g. 'brr', 'nth', Mrs'.
egrep -i "^[^aeiouy']{3}$" /usr/share/dict/words
# All words without vowels.
grep -iv '[aeiouy]' /usr/share/dict/words

# Words that can be spelled with hexadecimal alone, like 0xDEADBEEF.
egrep -i "^[a-fA-F]+$" /usr/share/dict/words
# https://en.wikipedia.org/wiki/Magic_number_%28programming%29#Magic_debug_values
# http://www.urbandictionary.com/define.php?term=0xDEADBEEF
# https://stackoverflow.com/questions/5907614/0xdeadbeef-vs-null

# words that end in "gry"
grep -i '.*gry$' /usr/share/dict/words
# For the record, here's what I got:
# angry
# demagogry
# hungry

# Filter out the words with uppercase / capital letters.
grep -v '[A-Z]' /usr/share/dict/words | less

# Debugging segfaults in C:
printf("Line %d reached.\n",__LINE__); /* debug */
# Debugging segfaults in Fortran:
print*,__FILE__,__LINE__

# Disk usage:
du | sort --numeric-sort --reverse
du | sort -nr # quick version
du -k --max-depth=1 /home | sort -nr

# Extract audio tracks from an mkv file.
mkvextract tracks movie5.mkv 2:audio_track.ac3

# Show list of all files except . and .. in a single column.
ls --almost-all --format=single-column

sudo chmod -R +rwx .mozilla
!! # repeat previous command

chmod u+rw,g+r,o+r myfile.txt

chmod a-w,u+w,g+w mydir/

# Change to only user can access.
chmod 0700 mydir/
chmod u+rwx,g-rwx,o-rwx mydir/

type ls # identify the kind of command ls is
type -a ls # print all the places that contain an executable named 'ls', including aliases, functions, and builtins.
# For example, `type -a ls` shows:
# ls is aliased to `ls --color=auto'
# ls is /bin/ls
type -a ipython
# ipython is /home/nathaniel/.local/bin/ipython
# ipython is /usr/bin/ipython

# Run the "real" ls, in case it is aliased.
command ls
\ls

# See a list of all functions.
compgen -A function
# List of all functions, aliases, and variables.
declare

# See where the function `quote` was defined.
shopt -s extdebug; declare -F quote; shopt -u extdebug

source .bashrc # make bash re-read modified .bashrc file
. .bashrc      # make bash re-read modified .bashrc file (portable)

apt-cache search my-package # search apt packages for 'my-package', case insensitive

# For when you only want to see 'gnash', not 'blah-gnash' or 'gnash-blah'
apt-cache search --names-only '^gnash$'

# For when you only want to see 'mc', not '*mc*'
apt-cache search --names-only '^mc$'

# Find package descriptions that are longer than 4000 characters.
apt-cache search '.{4000,}'

# Search for a package in all debian releases by querying http://qa.debian.org/cgi-bin/dcontrol
dcontrol warsow | less

# Show the release for the package.
dcontrol --show-suite warsow | less

# find all files ending in .wma and copy them to ~/wma-dump, not overwriting repeated files
find ~ -type f -name "*.wma" -exec cp -n '{}' /home/nathaniel/wma-dump/ ';'
# find all git repositories and run `git fsck` on them, saving the output to a log file.
find "$HOME" -name '.git' -print -execdir git fsck \; &> log.txt
# Don't do it like this:
find "$HOME" -name '.git' -print -execdir "git fsck" \; &> log.txt
# or you will get error messages like these:
# find: `/usr/bin/git fsck ./': No such file or directory

# Quick and dirty way to find large git repositories.
find . -type d -name '*.git' -execdir du -0sb \; -printf ' %p\n' | sort -n
# Measure the size of the .git folder itself, not the parent folder.
find . -type d -name '*.git' -exec du -sb '{}' \+ | sort -rn
find . -type d -name '*.git' -exec du -sh '{}' \+

# Example of fsck on a borked drive.
fsck -y /dev/sda

# On a USB flash drive.
sudo fsck /dev/sdb
# https://superuser.com/questions/418053/i-tell-fsck-to-fix-usb-stick-it-says-leaving-file-system-unchanged
# https://serverfault.com/questions/571458/unable-to-resolve-data-corruption-warning-with-fsck

# When running in the (initramfs) prompt using the ash shell:
fsck -y /dev/sda1 && exit

# Find all files not in a git repository and print the name.
find . -name '.git' -prune -o -type f -print | less -c
# https://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh
# https://unix.stackexchange.com/questions/109900/find-prune-does-not-ignore-specified-path
# Find all files not in a git repository and run `wc -l` on them.
find . -name '*.git' -prune -o -type f -exec 'wc' '-l' '{}' \+
# -o means 'or', so either prune '*.git' or if they are files (not directories) run wc -l filename on them.
# Same, but skip mercurial repositories (*.hg) as well.
find . -name '*.git' -prune -o -name '*.hg' -prune -o -type f -exec 'wc' '-l' '{}' \+

# Also prune the empty files.
find . -name '*.git' -prune -o -name '*.hg' -prune -o -empty -prune -o -type f -exec wc '-l' '-c' '{}' \+ | grep ' 0 ' | less
# Use pipe instead of exec.
find . -name '*.git' -prune -o -name '*.hg' -prune -o -empty -prune -o -type f -print0 | wc -l --files0-from=- | grep '^0 \|^1 ' | less

# Find all files that the current user has write-access to; a kind of crude security audit.
find / -path '/home' -prune -o -path '/tmp' -prune -o -path '/proc' -prune -o -writable -print | less
find / -path '/home' -prune -o -path '/tmp' -prune -o -path '/proc' -prune -o -writable -print 2> /dev/null | less
# We can use brace expansion for the pruned paths instead of writing them all out by hand.
# TODO: why doesn't this work?
find / ' -path '{'/home','/tmp','/proc'}' -prune -o' -writable -print | less
# http://www.liamdelahunty.com/tips/linux_find_exclude_multiple_directories.php
# https://askubuntu.com/questions/206277/find-files-in-linux-and-exclude-specific-directories
# http://www.cyberciti.biz/faq/linux-unix-osx-bsd-find-command-exclude-directories/
# https://stackoverflow.com/questions/1489277/how-to-use-prune-option-of-find-in-sh

find . -name '*.git' -prune -o -type f -print0 | wc -l --files0-from=-
# https://stackoverflow.com/questions/13727917/use-wc-on-all-subdirectories-to-count-the-sum-of-lines

# Find filenames ending with .cc, .cpp, or .cxx.
find . \( -name '.cc' -o -name '*.cpp' -o -name '*.cxx' \)
# https://stackoverflow.com/questions/1133698/find-name-pattern-that-matches-multiple-patterns

# List of unique file extensions.
find . -type f -name '*.*' | sed 's/.*\.//' | sort -u
# https://stackoverflow.com/questions/4998290/how-to-find-all-file-extensions-recursively-from-a-directory

# List filenames without extensions.
find . -type f -not -name '*.*' | less

# Find duplicate files efficiently.
find . -type f \( -name '*.pdf' -o -name '*.djvu' -o -name '*.epub' -o -name '*.mobi' \) -print0 | duff -0 | xargs -0 -n1 echo

cp -a ./.[a-zA-Z0-9]* ~/dotfiles_from_lucid_install_full/

# transfer ownership to nathaniel instead of root
sudo chown nathaniel: .xdvirc
# The trailing colon makes it owned by the default group.

# Had to do this when copying over files from old install.
cat precise.txt | grep root > to-chown.txt
# Unnecessary use of cat.
grep root precise.txt > to-chown.txt
cat fix_dotfile_permissions/to-chown-file-names.txt | xargs sudo chown nathaniel:
# All together:
grep root precise.txt | xargs sudo chown nathaniel:

# Using curl to download from the command line
curl --remote-name 'url' # Basically a wget replacement.
curl --output file.zip 'url' # Choose output filename.
curl --continue-at - --remote-name 'url_for_file' # Download file, automatically with same name and ability to resume download
curl --output /dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip # test download speed

# Using wget to download from the command line
wget http://cdimage.debian.org/cdimage/release/current-live/i386/usb-hdd/debian-live-6.0.4-i386-lxde-desktop.img # simpler
wget --continue 'http://cdimage.debian.org/cdimage/release/current-live/i386/usb-hdd/debian-live-6.0.4-i386-lxde-desktop.img' # resume a partial download

# How to download a file without nesting it in a bunch of directories
wget --no-host-directories ~/Dropbox/UbuntuBackup/ 'http://www.google.com/calendar/ical/nbeaver%40hawk.iit.edu/private-487dd85b5f1553be9c2e1b4a1e29ae7f/basic.ics'

# Using wget to get a recursive (default to 5 links deep) local copy of a page.
wget --no-host-directories --recursive --convert-links --page-requisites 'http://www.cs.cmu.edu/afs/cs.cmu.edu/user/sleator/www/oddballs/oddballs-web/'
wget -nHrkp 'http://www.cs.cmu.edu/afs/cs.cmu.edu/user/sleator/www/oddballs/oddballs-web/'

wget --recursive --no-clobber --page-requisites --html-extension --convert-links restrict-file-names=windows --domains website.org --no-parent www.example.com/foo/bar/
# https://askubuntu.com/questions/425275/download-entire-web-archive-using-terminal
wget -E -H -k -K -p url
wget --adjust-extension --span-hosts --convert-links --backup-converted --page-requisites url
wget --recursive --no-clobber --page-requisites --html-extension --convert-links --restrict-file-names=windows url
wget -E -H -k -K -p url -e robots=off
# https://superuser.com/questions/55040/save-a-single-web-page-with-background-images-with-wget

# Use wget, but reject some URLs/files from download.
wget --recursive "http://groovebackup.com/?lang=en" --reject index.html?lang=de,index.html?lang=dk,index.html?lang=en,logout
# https://stackoverflow.com/questions/10712344/mirror-http-website-excluding-certain-files
# https://stackoverflow.com/questions/12704197/wget-reject-still-downloads-file

# Use wget to check for broken links in a local HTML file.
cat file.html | wget --no-check-certificate --spider -nv -F -i -
# or this:
wget --no-check-certificate --spider -nv -F -i - < file.html

linkchecker --verbose file.html --check-extern --timeout=5 --user-agent=Mozilla/4.0 --file-output=csv/utf_8/linkchecker-results.csv

# Use wget to check for broken links in a remote webpage.
wget --spider  -o wget.log  -e robots=off --wait 1 -r -p http://www.example.com
# http://www.commandlinefu.com/commands/view/8234/check-broken-links-using-wget-as-a-spider
wget --spider --execute robots=off --wait 1 --no-verbose --page-requisites https://en.wikipedia.org/wiki/Command-line_interface |& less
# Note: this will take a while.
# Note: this will only find broken internal links; it will not spider outward to check the external ones.

# Download a local copy of the weather into a specified directory
wget -p --convert-links -P ~/not_backed_up/weather-reports/chicago-weather/ 'http://forecast.weather.gov/MapClick.php?lat=41.8403395&lon=-87.61370110000001&site=all&smap=1&searchresult=Chicago%2C%20IL%2060616%2C%20USA'
wget --page-requisites --convert-links --directory-prefix '~/not_backed_up/weather-reports/chicago-weather/' 'http://forecast.weather.gov/MapClick.php?lat=41.8403395&lon=-87.61370110000001&site=all&smap=1&searchresult=Chicago%2C%20IL%2060616%2C%20USA'

# Choose output for wget
wget --no-host-directories 'http://www.google.com/calendar/ical/nbeaver%40hawk.iit.edu/private-487dd85b5f1553be9c2e1b4a1e29ae7f/basic.ics' --output-document ~/Dropbox/UbuntuBackup/basic.ics

# Get local copy of website
wget -E -H -k -K -p -e robots=off 'https://www.iit.edu/'
wget --adjust-extension --span-hosts --convert-links --backup-converted --page-requisites --execute robots=off 'https://www.iit.edu/'

# Check to see if the website is up beyond using something like ping.
wget --timeout=3 --tries=1 --spider --no-check-certificate http://marctenbosch.com/miegakure/
wget --timeout=3 --tries=1 --spider --no-check-certificate ftp://ftp.gnu.org/
curl --head --silent --location "http://www.reddit.com/r/obscurantism"
000

fping < list-of-urls.txt
# https://superuser.com/questions/1456225/debug-http-status-code-of-a-big-urls-list

# Just the HTTP status code and URL.
curl --head --silent --write-out "%{http_code} %{url_effective}\\n" --location 'http://w3.org/404' --output /dev/null
curl --head --silent --write-out "%{http_code} %{url_effective}\\n" --location 'http://w3.org/404' --output /dev/null
curl --head --silent --write-out '%{http_code} %{url_effective}\n' --location 'https://w3.org/404' --output /dev/null
# http://beerpla.net/2010/06/10/how-to-display-just-the-http-response-code-in-cli-curl/
# https://stackoverflow.com/questions/12747929/linux-script-with-curl-to-check-webservice-is-up
# https://unix.stackexchange.com/questions/26426/how-do-i-get-only-the-http-status-of-a-site-in-a-shell-script
# https://unix.stackexchange.com/questions/105134/type-url-and-show-http-status
#

# Just the HTTP status code.
curl --head --silent --write-out "%{http_code}\\n" --location 'http://www.reddit.com/r/obscurantism' -o /dev/null

# No redirects
curl --head --silent "http://www.reddit.com/r/obscurantism"
curl --head --silent "http://info.cern.ch/"
wget --timeout=3 --tries=1 --spider --no-check-certificate  --max-redirect=0 http://marctenbosch.com/miegakure/

# Full debugging.
curl --verbose --location 'https://w3.org/404' --output /dev/null 2>&1 | less
curl --verbose --location 'https://w3.org/404' 2>&1 | less

# Download just the first level of linked files, and don't re-download them if they haven't been updated
wget --no-parent --no-host-directories --recursive --level=1 --convert-links --relative --timestamping http://bernhard-adams.com/IIT-phy412/

# Download from obnoxious user-agent filtering sites
# http://sparc86.wordpress.com/2009/04/08/wget-shows-http-error-403-forbidden/
wget -U firefox http://www.wideislandview.com/2009/07/recipe-no-fuss-rice-cooker-banana-bread/

# Get some lecture notes
/usr/bin/wget --no-verbose --no-parent --no-host-directories --recursive --level=1 --convert-links --relative --directory-prefix=/home/nathaniel/Dropbox/14_Spring_2014/optics-PHYS-412/lectures/mirror http://bernhard-adams.com/IIT-phy412/

echo blacklist mei > /etc/modprobe.d/mei.conf # avoid this error http://bbs.archlinux.org/viewtopic.php?id=133083-
# Also here: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/984088

# Regenerate the kernel image
# after e.g. changing configuration files in /etc/modprobe.d/
sudo update-initramfs -u

# See the hexdump of a file.
hexdump myfile.gsp | less

# See the hexdump of a file side-by-side with ASCII.
hexdump -C myfile.gsp | less
# Example with runtime file used by `who'.
hexdump -C /var/run/utmp | less


for f in *.gsp # for every file ending in .gsp
do
    echo $f # display the filename
    hexdump -C $f > "${f%.gsp}.txt" # make a text hexdump
done

for f in *.exe; do hexdump -C "$f" > "$f.hexdump.txt"; done

# Process control
ps aux | grep athena
# or
ps -C athena
pstree
vmstat

pstree -H $(pgrep athena | head -n1) | less

pstree 10326 | less
# bash-+-bash---time---fdupes
#      |-2*[bash---time---find]
#      |-bash-+-time---find
#      |      `-time---sort
#      |-bash---time---find---bash---bash-+-cut
#      |                                  |-pdffonts
#      |                                  |-sort
#      |                                  |-tail
#      |                                  `-uniq
#      `-bash-+-sort
#             `-time---du
pstree $(pgrep bash | head -n 1) | less
pstree $(pgrep xterm | head -n 1) | less

ps aux --sort=-%cpu # list processes using most CPU
ps aux --sort=-%mem # list processes using most memory
ps aux --sort=start_time # list processes from oldest to youngest

# See start time of a particular process.
ls -ld /proc/24088
stat /proc/24088

# Get RAM usage.
pmap 3241 | tail -n 1
# Get detailed RAM usage, including RSS.
pmap -x 3241 | tail
top -p 3241

# What do the statuses in ps mean, e.g. Rl Sl S+ Sl+ in the STAT (status) field?
# PROCESS STATE CODES
#        Here are the different values that the s, stat and state output specifiers (header "STAT" or "S") will display to describe the state of a process:
#        D    uninterruptible sleep (usually IO)
#        R    running or runnable (on run queue)
#        S    interruptible sleep (waiting for an event to complete)
#        T    stopped, either by a job control signal or because it is being traced.
#        W    paging (not valid since the 2.6.xx kernel)
#        X    dead (should never be seen)
#        Z    defunct ("zombie") process, terminated but not reaped by its parent.
#
#        For BSD formats and when the stat keyword is used, additional characters may be displayed:
#        <    high-priority (not nice to other users)
#        N    low-priority (nice to other users)
#        L    has pages locked into memory (for real-time and custom IO)
#        s    is a session leader
#        l    is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
#        +    is in the foreground process group.

# Run a command at lowest possible priority so that it doesn't use up so many resources.
nice -n 19 recollindex

# Adjust priority of existing processes.
renice -n 19 -p 28590 28593
# 28590 (process ID) old priority 0, new priority 19
# 28593 (process ID) old priority 0, new priority 19

# Adjust disk I/O of a process so it only runs when the disk is idle.
ionice -c 3 -p 15569

startx -- :1 # start x session

ls -lSrh # list biggest files
ls -l -S --reverse --human-readable # -l = long listing and -S = sort
ls -v1 # Show files one on each line and in numeric order instead of alphanumeric

lsof # display open files
lsof -p 1234 # Show open files from process id 1234.

sudo lsof -i :22
# COMMAND PID USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
# sshd    650 root    3u  IPv4 59613617      0t0  TCP *:ssh (LISTEN)
# sshd    650 root    4u  IPv6 59613619      0t0  TCP *:ssh (LISTEN)

# Sure ways to restart a wireless network
ping -c 4 google.com # ping 4 times
lspci | grep -i network
# 03:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8188CE 802.11b/g/n WiFi Adapter (rev 01)
# or
# 03:00.0 Network controller: Intel Corporation Centrino Wireless-N 1000 [Condor Peak]
lsmod | grep rtl
# or iwlwifi
kmod list | grep rtl
sudo modprobe --remove rtl8192ce
sudo modprobe rtl8192ce
ping -c 4 google.com

# Get list of interfaces.
ls /sys/class/net/

# Get list of driver paths for netork interfaces.
readlink /sys/class/net/*/device/driver

# Get name of wifi driver for wlan0 interface.
basename "$(readlink /sys/class/net/wlan0/device/driver)"

# Get driver names for all network interfaces.
readlink /sys/class/net/*/device/driver | xargs -L 1 basename

# Another method
sudo /etc/init.d/networking restart
sudo /etc/init.d/network-manager restart
sudo /etc/init.d/vsftpd restart

# Restart interface, wlan0 in this case.
sudo ifdown wlan0 && sudo ifup wlan0

# First, try Alt-F2 and xkill or Alt-F2 and gnome-terminal
# Restart X server
invoke-rc.d lightdm restart
/etc/init.d/lightdm restart
sudo pkill x

# For SystemV init system.
sudo service lightdm restart

# Ctrl-Alt-Backspace
# Alt-PrtSc-k
# http://www.sudo-juice.com/restart-x-shortcut-for-ubuntu/
# https://unix.stackexchange.com/questions/87192/restarting-gnome-3-in-debian-wheezy

# Magic SysRq key: rebooting when all else fails
# hold down Alt-SysRq, then type  r e i s u b, then enter and ctrl-alt-del


date --date='2 hours 22 minutes' +%r # The time 2 hours and 22 minutes from now, formatted with AM/PM
date --date='45 days after 9/11/2012' +%r
date -d 'April 19, 2014 + 12 weeks'
# https://www.gnu.org/software/coreutils/manual/html_node/Examples-of-date.html

# Time in the past.
date --date='5 hours ago 15 minutes ago 2 seconds ago'
date --date='-5 hours -15 minutes -2 seconds'
# https://www.gnu.org/software/coreutils/manual/html_node/Relative-items-in-date-strings.html
# info:/coreutils/Relative items in date strings

# find number of days' difference between two dates
echo $(( ( $(date -d "09/07/2012" +%s) - $(date -d "07/05/2012" +%s) ) /(24 * 60 * 60 ) ))

# Standard American date format (mm/dd/yyyy).
date +%m/%d/%Y
# Standard American date one week from now
date --date='next week' +%m/%d/%Y
date --date='7 days' +%m/%d/%Y
# Unambiguous time ahead of behind UTC.
date -R

grep -r "string" ./ # recursively search all files for "string"

# search man pages
man --global-apropos "David MacKenzie" | grep "David MacKenzie" | wc -l
man --global-apropos "David MacKenzie" | grep --count "David MacKenzie"
str='David MacKenzie'; man --global-apropos "$str" | grep --count "$str"
# returns 55, last I checked. Number of manpages with lines mentioning David MacKenzie.

man -K 'maintained as a Texinfo manual' | grep 'maintained as a Texinfo manual' | wc -l
str='maintained as a Texinfo manual'; man -K "$str" --sections=1 | grep --count "$str"
# returns 271, last I checked.

# List man pages that have 'XDG_CACHE_HOME'.
man -wK 'XDG_CACHE_HOME'
# List man pages that have the flag '--directory='.
man -wK -- '--directory='

# search for commands and aliases named 'my-command'.
compgen -ac | grep my-command
# Note: -a is for aliases, -c is for commands
# Example: all executables ending in `.py` in $PATH:
compgen -c | grep '\.py$'
# See shortest and longest commands.
compgen -c | awk '{print length, $0;}' | sort -n | less
# http://www.commandlinefu.com/commands/view/3724/sort-lines-by-length
# https://stackoverflow.com/questions/5917576/sort-a-text-file-by-line-length-including-spaces
# http://www.linuxscrew.com/2009/04/14/sort-cli-output-by-line-length/
# http://www.unixcl.com/2009/08/sort-strings-by-length-using-awk-and.html

# A lot of commands end with top, e.g. atop, htop, iftop, iotop, sntop, etc.
compgen -c | grep 'top$' | less

# Get wireshark working for non-root user
sudo apt-get install wireshark
sudo dpkg-reconfigure wireshark-common
sudo usermod --append --groups wireshark $USER
# Now log out and log back in again.
gnome-session-quit --logout --no-prompt

# '/media/sf_shared': Permission denied.
# Access shared folder.
sudo usermod -aG vboxsf $USER

# Access USB devices through VirtualBox.
sudo usermod -aG vboxusers $USER
sudo usermod --append --groups vboxusers $USER

# See what groups you are in, in a line-by-line fashion.
id | tr ',' '\n'

# Check if current user is in a group like dialout or lpadmin.
id | grep dialout
id | grep lpadmin
groups $USER | grep dialout
groups $USER | grep dialout
id -Gn | grep -o '\bdialout\b'
id -Gn | grep -wo 'dialout'
grep dialout /etc/group | grep $USER
grep lpadmin /etc/group | grep $USER
# https://stackoverflow.com/questions/18431285/bash-check-if-a-user-is-in-a-group

# dialout is necessary for running e.g. Cura for 3d printing,
# lpadmin is necessary for adding new printers,
# and wireshark is necessary for non-root users to run wireshark.

# Add yourself to the `dialout' group.
sudo gpasswd --add $USER dialout
# Add yourself to the groups `lpadmin' and `wireshark'.
sudo usermod --append --groups dialout,wireshark $USER
# Note that if you are the user doing this,
# it won't take effect until you logout and log back in again.
# https://unix.stackexchange.com/questions/96343/how-to-take-effect-usermod-command-without-logout-and-login
# https://superuser.com/questions/272061/reload-a-linux-users-group-assignments-without-logging-out
# http://blog.edwards-research.com/2010/10/linux-refresh-group-membership-without-logging-out/
exec su -l $USER
newgrp dialout

# Add current user to those permitted to print.
sudo usermod -a -G lpadmin $USER

# Add a user to the list of sudoers (as root).
usermod -a -G sudo nathaniel
# Error message: "$USER" is not in the sudoers file. This incident will be reported.

# Change the root password.
sudo passwd root
# https://unix.stackexchange.com/questions/35929/how-can-we-change-root-password#35938

# Locate all files with a path or name containing 'file'
locate --ignore-case file
# Locate all files ending with '.cif'
locate '*.cif'
# Slower way to do the same thing.
locate -r '\.cif$'
# Locate all base filenames starting with phys
locate -b 'phys*'
# Locate using the ? for one or zero unknown letter, * for many unknown letters
locate '*.htm?'
# Restrict locate to a single path
locate --count /home/nathaniel/*/Makefile
locate --count /home/nathaniel/*/Makefile
# Use regular expressions, e.g. match end of line to get all .bib files.
locate -b -r '\.bib$' | less
# Another regex example.
locate -r share/applications$

# https://askubuntu.com/questions/33280/use-locate-under-some-specific-directory

# Update the locate database
sudo updatedb
# Find out when the last time the database was (successfully) updated by checking the database file modification date.
stat -c %y /var/lib/mlocate/mlocate.db
# Find out when the last time the database was queried.
stat -c %x /var/lib/mlocate/mlocate.db
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/308423e6-95a4-4001-9e76-501ad79b2e93.json
# TODO: write a command that shows how long its been (in days) since the database was updated.


# Make a tree using the Contex Free grammar image generator
/usr/bin/cfdg -s 500 /usr/share/doc/contextfree/examples/mtree.cfdg mtree.png

echo -n '12764787846358441471' | wc --chars # this is a 20-digit prime
time factor 12764787846358441471 # factoring this will take on the order of a few seconds
12764787846358441471: 12764787846358441471
# This is what I get on my laptop
# real    0m14.582s
# user    0m14.533s
# sys 0m0.004s

/usr/bin/time --verbose factor 12764787846358441471

/usr/bin/time --output=time.log --verbose factor 12764787846358441471

# This is what I see on my laptop now.
#   $ time factor 12764787846358441471
#   12764787846358441471: 12764787846358441471
#
#   real	0m0.003s
#   user	0m0.000s
#   sys	0m0.000s

{ time factor 12764787846358441471 ; } 2> time.txt
{ time factor 12764787846358441471 ; } > all.txt 2>&1
# Not that 2>&1 must come after, not before.
# https://stackoverflow.com/questions/13176611/bash-script-write-executing-time-in-a-file
# https://stackoverflow.com/questions/13356628/is-there-a-way-to-redirect-time-output-to-file-in-linux

# Check if `factor` was built with GMP for bignum support:
ldd "$(which factor)"
#	linux-vdso.so.1 (0x00007ffcc1d63000)
#	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fd60e2b4000)
#	/lib64/ld-linux-x86-64.so.2 (0x00007fd60e65d000)
# Or just do this.
factor 340282366920938463463374607431768211456
# factor: ‘340282366920938463463374607431768211456’ is too large
# or this:
echo '2^127' | bc | factor
# factor: ‘170141183460469231731687303715884105728’ is too large
# Most Debian versions are not built with bignum support.

objdump -p /usr/bin/factor | grep NEEDED
#   NEEDED               libc.so.6
objdump -p /usr/bin/factor | grep 'file format'
# /usr/bin/factor:     file format elf64-x86-64

# Inspect a core dump.
objdump ./core | less
# https://unix.stackexchange.com/questions/89933/how-to-view-core-files-for-debugging-purposes-in-linux


# Make a file executable (defaults to current user)
chmod +x zab.py
# Make a file writeable (defaults to current user)
chmod +w myfile.txt
chmod u+w myfile.txt
# Make file read-only.
chmod -w myfile.txt

# Run python, ending with an interactive shell to fiddle with
python -i myscript.py

# Profile a python script
python -m cProfile myscript.py > profile.log

# Trace function calls.
python3 -m trace --listfuncs -- /path/to/myscript.py

# sage command
plot_vector_field((y, -x), (x,-3,3), (y,-3,3))
VectorPlot[{y, -x}, {x, -3, 3}, {y, -3, 3}]

# Create PNG images from LaTeX DVI document
dvipng -D 400 poisson-sep-pages.dvi -T tight -bg transparent

sudo pm-suspend # manually sleep
# Might need to install it first:
# sudo apt install pm-utils

pmi suspend
# sudo apt install powermanagement-interface
# https://askubuntu.com/questions/1792/how-can-i-suspend-hibernate-from-command-line

# Use systemd
systemctl suspend
# https://askubuntu.com/questions/1792/how-can-i-suspend-hibernate-from-command-line

systemctl list-unit-files
# https://askubuntu.com/questions/795226/how-to-list-all-enabled-services-from-systemctl

systemctl list-units
# https://askubuntu.com/questions/795226/how-to-list-all-enabled-services-from-systemctl

# Restart display managers such as lightdm, gdm3, sddm, etc.
sudo systemctl restart display-manager.service

apt-cache showpkg xserver-xorg-input-synaptics
# Use synaptic to downgrade and lock
sudo vim /etc/apt/apt.conf.d/99unattended-upgrades
# Add this to prevent upgrades to package
// List of packages to not update
Unattended-Upgrade::Package-Blacklist {
      "xserver-xorg-input-synaptics";
};

# Get rid of network popups
killall nm-applet ; nm-applet &

# Brace expansion for sequeces/series/ranges of integers/numbers counting up
echo {1..9}
# With leading zeroes
echo {01..16}
# Fun with brace expansion
for i in {16..25}; do j=$((4*($i-16))); echo $i'_'$(($j+61))-$(($j+64)); done
# 16_61-64
# 17_65-68
# 18_69-72
# 19_73-76
# 20_77-80
# 21_81-84
# 22_85-88
# 23_89-92
# 24_93-96
# 25_97-100

# Find non-ascii characters in filenames.
LC_COLLATE=C find . -name '*[! -~]*'
# https://unix.stackexchange.com/questions/109747/identify-files-with-non-ascii-or-non-printable-characters-in-file-name
# https://askubuntu.com/questions/113188/character-encoding-problem-with-filenames-find-broken-filenames
# How the regex works: space is first printing character (U+0020, decimal 32) and last is tilde ~ (U+007E, decimal 126).

# Do the same thing but replace non-printing characters with question marks.
LC_ALL=C find . -name '*[! -~]*'

# find Unicode/non-ascii characters in text file by numbered line
LC_COLLATE=C grep -n '[^ -~]' --color=always utf8.txt | less -r
# show only the matching characteres
LC_COLLATE=C grep -o '[^ -~]' --color=always utf8.txt | less -r
# send to text file instead of less
LC_COLLATE=C grep -o '[^ -~]' utf8.txt > non-ascii.txt
# show only non-ascii characters
perl -pe 's/[[:ascii:]]//g' utf8.txt
tr -cd '\200-\377' < utf8.txt
# highlight characters that are non-ascii (have unicode or other encodings) and give line number
grep -nP '[^[:ascii:]]' --color=always myfile.txt | less -R
# long flag version:
grep --line-number --perl-regexp '[^[:ascii:]]' --color=always myfile.txt | less --RAW-CONTROL-CHARS
# https://stackoverflow.com/questions/3001177/how-do-i-grep-for-all-non-ascii-characters-in-unix
# https://superuser.com/questions/417305/how-can-i-identify-non-ascii-characters-from-the-shell
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/7b93628a-938d-4227-a88c-9d697f55fac4.json

# Find python files with Unicode.
grep -rlnP '[^[:ascii:]]' --include='*.py'

# Grep for matching lines, but show only matching filenames.
grep -rl "blah" # list files with lines that match "blah"
grep --recursive --files-with-matches "blah" # list files with lines that match "blah"
# Can be useful if you want to, say, edit all these files with a text editor.
vim "$(grep -rl "blah")"

grep -rl "blah|\blag" # list files with lines that match "blah" or "blag"

# Grep for matching lines, but show only matching filenames.
grep -rL "blah" # list files that have no lines matching "blah"
grep --recursive --files-without-matches "blah"

# Making fun of IIT's marketing strategy.
grep 'it.*it' /usr/share/dict/words | sed 's/it/IIT/g' | less

zip -r myfolder.zip myfolder/ # recursively zip a directory, putting the zip file into the current directory
unzip -l myfile.zip # list contents of zip file
unzip '*.zip' # unzip all files ending in .zip
unzip myfile.zip -d /path/to/desired/directory

# Zip two folders but ignore the git repositories.
zip -r myfile.zip folder1/ folder2/ --exclude '*.git*'

# Zip file gone wrong:
file imap.zip
# imap.zip: Zip archive data, at least v3.0 to extract
unzip imap.zip
# Archive:  imap.zip
# warning [imap.zip]:  10050086 extra bytes at beginning or within zipfile
#   (attempting to process anyway)
# error [imap.zip]:  start of central directory not found;
#   zipfile corrupt.
#   (please check that you have transferred or created the zipfile in the
#   appropriate BINARY mode and that you have compiled UnZip properly)

# Latex for adding tengwar stuff (unfinished)
updmap --enable Map=tengwarscript.map

# ip address for IIT physics office printer 216.47.138.174
# How to add a new network printer:
system-config-printer
# Use IPP (Internet Printing Protocol) if possible.
# LPD, SMB, AppSocket/JetDirect also ok, but have reduced functionality.
# https://askubuntu.com/questions/401119/should-i-set-up-my-cups-printing-to-use-ipp-lpd-or-url

# Untar pretty much anything.
tar xf example.tar
tar xf example.tar.gz
tar xf example.tar.xz
# https://old.reddit.com/r/commandline/comments/12eqqa/dtrx_do_the_right_extract_a_frontend_for_many/c6ujuxc/

# decompress and unarchive a bzipped file
tar -jxvf firefox-18.0a1.en-US.linux-i686.tar.bz2

# decompress and unarchive a gzipped file
tar -zxvf XeroxLinuxi686xpxx_4.30.28.tgz

# decompress and unarchive a tarred, gzipped file
tar -zxf keepassx-0.4.3.tar.gz
tar zxf keepassx-0.4.3.tar.gz # The - in front of the flags is not actually necessary.
# Unfortunately, no easy way to make a parent directory.
# https://unix.stackexchange.com/questions/198151/tar-extract-into-directory-with-same-base-name
# ~/writings/looseleaf/posts/8d4ee537-033e-4936-9bd8-f2dc7b033170.rst

# list contents of a tarred file, i.e. tar archive
tar -tf myfile.tar
tar --list --file myfile.tar

# untar a tarred file into the working directory
tar -xvf myfile.tar
tar --extract --verbose --file myfile.tar
# Or just this:
dtrx myfile.tar

# untar a tarred file to a specified directory
tar -xvf myfile.tar -C /path/to/my/directory
tar --extract --verbose --file myfile.tar --directory /path/to/my/directory

# Gzip a single file
gzip myfile.txt # produces myfile.txt.gz and removes myfile.txt
# Un-gzip a single file.
gunzip myfile.txt.gz # produces myfile.txt and removes myfile.txt.gz

# Gzip a file without removing the original.
gzip < file > file.gz
# https://unix.stackexchange.com/questions/46786/how-to-tell-gzip-to-keep-original-file/58814#58814
gzip -k -- file
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/b70da7de-745f-4774-93eb-6eb034ccbd57.json

# Tar a directory (create an archive that is not compressed).
tar -C /path/to/parent/ -cf /other/parent/myfile.tar my-directory/
tar --directory=/path/to/parent/ --create --file=/other/parent/myfile.tar my-directory/

# Tar and compress a directory with gzip (create a compressed archive).
tar -C /path/to/parent/ -czf /other/parent/myfile.tar.gz my-directory/
tar --directory=/path/to/parent/ --create --gzip --file=/other/parent/myfile.tar.gz my-directory/

# Tar and compress a directory with xz (create a compressed archive).
tar -C /path/to/parent/ -cJf /other/parent/myfile.tar.xz my-directory/
tar --directory=/path/to/parent/ --create --xz --file=/other/parent/myfile.tar.xz my-directory/

# Tar and compress a directory with zstd (create a compressed archive).
tar -C /path/to/parent/ --use-compress-program zstd -cf /other/parent/myfile.tar.zst my-directory/ # older tar that doesn't have --zstd
tar -C /path/to/parent/ --zstd -cf /other/parent/myfile.tar.zst my-directory/
tar --directory=/path/to/parent/ --create --zstd --file=/other/parent/myfile.tar.zst my-directory/

cat /bin/cat # mojibake-fy the screen
reset # fix it

Ctrl-Z # get out of pretty much any terminal program and back to the shell
fg # move the job back to the foreground
kill %3 # kill job by jobspec a.k.a job identifier (3, in this case)

# Patching
diff -u old_file new_file > patch.txt # Generates a patch file that can generate new_file from old_file
# To check the patch:
patch -b old_file # Patches old_file and creates a file called old_file.orig that is unpatched
vimdiff old_file old_file.orig # compare the patched file to the original file
# Warning: gvimdiff is much easier on the eyes; terminals and vim's diffing highlighting tends to clash.
# To use the patch
patch < patch.txt
# To revert the patch
patch -R < patch.txt

# Find out what kind of files are in the current directory and its subdirectories.
find . -type f -exec file '{}' \; | less
# Reference: man find or
# https://stackoverflow.com/questions/21155287/shell-notation-find-type-f-exec-file
# https://stackoverflow.com/questions/20913198/why-are-the-backslash-and-semicolon-required-with-the-find-commands-exec-optio

# Execute /usr/bin/file on every file and directory below current directory
find . -exec file '{}' + | less

# Find all symlinks in directories below.
find . -type l

# Find broken symlinks in directories below
find . -xtype l
find /usr/ -xtype l
# https://unix.stackexchange.com/questions/34248/how-can-i-find-broken-symlinks
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/d1963f6a-dd27-48f5-8663-8ebe6ff5dae8.json

# Does the same thing, but much more slowly (test -r returns 1 if the file is not readable).
find ./ -type l ! -exec test -r {} \; -print

# Run `pathchk` to check for unportable filenames.
find . -exec pathchk -P '{}' \;

# Index all files in a directory with recoll
find ./ -print -exec recollindex -i '{}' \;
# Index all files by sending to stdin (more efficient).
find . -type f -print | recollindex -i
# Also erase current file data.
# -e will erase data for individual files from the database.
find . -type f -print | recollindex -e

# Do this without using too many resources.
find . -type f -name '*.tex' -print | nice -n 19 ionice -c 3 recollindex -e

# Much like any other find exec command, but more efficient
# because it uses the fact that rm can take multiple arguments to runs rm fewer times.
find ./ -type f -name "*.deadtime" -exec rm '{}' +
# Or for recent versions, use -delete flag.
find ./ -type f -name "*.deadtime" -delete

# Number starting with 0.
find . -type f -exec nl -v 0 '{}' \; | less


# Delete all files and directories, including hidden files.
find . -delete

# Print all empty directories under current directory.
find ./ -type d -empty
# Recursively remove all empty directories under current directory.
find ./ -depth -type d -empty -delete
# http://robotbutler.org/article/31
# http://www.thegeekstuff.com/2010/03/find-empty-directories-and-files/
# http://itsmetommy.com/2013/07/11/useful-linux-find-commands/
# https://stackoverflow.com/questions/2810838/finding-empty-directories

# Limit it to the current directory only.
find . -maxdepth 1 -type d -empty

# https://stackoverflow.com/questions/6085156/using-vs-with-exec-in-find
find ./ -exec ls '{}' \;
# ls file1
# ls file2
# ls file3
find ./ -exec ls '{}' \+
# ls file1 file2 file3

find * -name Makefile -exec grep -r 'mx_config' '{}' \+

ssh -D 9999 iit@id1.mr.aps.anl.gov # secure shell into the APS sector 10 insertion device beamline account for IIT
ssh -D 9999 iit@bm1.mr.aps.anl.gov # secure shell into the APS sector 10 bending magnet beamline account for IIT
ssh -D 9999 nbeaver@216.47.138.69  # secure shell into desktop at physics office

# Run browser through SOCKS proxy.
chromium --proxy-server="socks5://localhost:9999" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"

# in python, save interactive history in current directory:
import readline
readline.write_history_file("my_history.txt")

# instant memory leak!
echo $(yes hurpaflerp)
echo $(yes)

# Check ip address to see if it responds, then load the video
ping -q -c 1 upload.wikimedia.org && vlc https://upload.wikimedia.org/wikipedia/commons/d/dd/Annie_Oakley_shooting_glass_balls%2C_1894.ogg
# Even better, spider the actual file before streaming it.
wget --spider https://upload.wikimedia.org/wikipedia/commons/d/dd/Annie_Oakley_shooting_glass_balls%2C_1894.ogg && vlc https://upload.wikimedia.org/wikipedia/commons/d/dd/Annie_Oakley_shooting_glass_balls%2C_1894.ogg

# Rsyncing remote directory contents into current local directory
rsync -rave ssh nbeaver@216.47.138.69:~/* ./
rsync --recursive --archive --verbose --rsh=ssh nbeaver@216.47.138.69:~/* ./
# Use --archive to keep timestamps the same and --partial to keep partially transferred files and --compress to use less bandwidth.
# Also use ssh for secure transfer.
rsync --archive --recursive --verbose --partial --compress --progress --rsh=ssh iit@id1.mr.aps.anl.gov:/home/iit/2014-07-18/ /home/nathaniel/Dropbox/15_Summer_2014/XAFS/2014-07-18/
# If you're not sure what you're doing is the right thing, use --dry-run.
rsync --archive --recursive --verbose --partial --compress --progress --dry-run --rsh=ssh iit@id1.mr.aps.anl.gov:/home/iit/2014-07-18/ /home/nathaniel/Dropbox/15_Summer_2014/XAFS/2014-07-18/

# Local copy.
rsync --recursive --archive /media/disk1/ /media/disk2
# It's the trailing slash on the source directory that matters,
# not the trailing slash on the trailing directory.
# Forgetting the trailing slash will generate this:
# /media/disk2/disk1/...
# Because rsync will treat it like a file.
rsync --archive --verbose --progress --human-readable --whole-file --no-compress /media/${USER}/FC30-3DA9/DCIM/ $HOME/Pictures/digital-photos/by-camera/Nikon_COOLPIX_L810/2015-03-20_and_following
# http://devblog.virtage.com/2013/01/to-trailing-slash-or-not-to-trailing-slash-to-rsync-path/

# One-way merge directories without wiping out files in the target directory.
rsync --archive --ignore-existing '/path/to/source/' '/path/to/target/'
# See what will occur without running it.
rsync --archive --ignore-existing --progress --dry-run '/path/to/source/' '/path/to/target/'


# Rsync local directory to another local directory (like cp, but shows progress and only sends deltas)
rsync --recursive --progress --partial /origin/path /target/path
# For rsync 3.1.0 / protocol 31 and later.
rsync --recursive --partial --info=progress2 /origin/path /target/path
# https://serverfault.com/questions/219013/showing-total-progress-in-rsync-is-it-possible

# If you care about things like permissions, modification times, and symlinks:
rsync --archive --progress --partial /origin/path /target/path
# or
rsync --archive --info=progress2 --partial /origin/path /target/path

# If you want to see the differences between all the files and how much data was transferred.
rsync --itemize-changes --verbose --recursive --progress --partial --archive /origin/path /target/path
# If you are e.g. copying large files and want to use a checksum rather than the (much faster) heuristic of size and modification time.
rsync --checksum /path/1/ubuntu-14.04-server-amd64.iso /path/2/ubuntu-14.04-server-amd64.iso

# Search with less case insensitive
less -i
#(Or just press -i while less is running)

# List networks
sudo lshw -C network

# See connected networky stuff like browsers
lsof -i -P +c 0 +M

# See information about battery, power, etc.
upower --dump | less
upower -d
# See all power-related paths.
upower -e
# Check battery state/power level
acpi    # shows battery info by default.
acpi -b # show battery specifically.
cat /proc/acpi/battery/BAT0/state # deprecated.
# 5387 mAh is 100%
# 3087 mAh is 58%
# 7900 mWh is 14%, so full capacity should be about 56000 mWh
# See more detailed information about battery life.
upower -i /org/freedesktop/UPower/devices/battery_BAT0
acpi -V
gnome-power-statistics
gnome-power-manager

# Show kernel information about battery:
cat /sys/class/power_supply/BAT*/uevent
# https://bugzilla.xfce.org/show_bug.cgi?id=11447

# Restart upowerd
sudo killall upowerd && sudo /usr/lib/upower/upowerd & disown

# Check processor/cpu/chip information
cat /proc/cpuinfo
less /proc/cpuinfo

# Check for AES hardware support.
grep aes /proc/cpuinfo
# https://unix.stackexchange.com/questions/14077/how-to-check-that-aes-ni-is-supported-by-my-cpu

# Show what the disks and partitions are, e.g. /dev/sda and /dev/sda1 /dev/sda2.
sudo fdisk -l
# Disk /dev/sda: 512.1 GB, 512110190592 bytes
# 255 heads, 63 sectors/track, 62260 cylinders, total 1000215216 sectors
# Units = sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 4096 bytes
# I/O size (minimum/optimal): 4096 bytes / 4096 bytes
# Disk identifier: 0x0008fe9b
#
#    Device Boot      Start         End      Blocks   Id  System
# /dev/sda1   *        2048   967141375   483569664   83  Linux
# /dev/sda2       967143422  1000214527    16535553    5  Extended
# Partition 2 does not start on physical sector boundary.
# /dev/sda5       967143424  1000214527    16535552   82  Linux swap / Solaris

# Another example:

# Disk /dev/sda: 931.5 GiB, 1000204886016 bytes, 1953525168 sectors
# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 4096 bytes
# I/O size (minimum/optimal): 4096 bytes / 4096 bytes
# Disklabel type: dos
# Disk identifier: 0x534b2987
#
# Device     Boot      Start        End    Sectors   Size Id Type
# /dev/sda1  *          2048 1937225727 1937223680 923.8G 83 Linux
# /dev/sda2       1937227774 1953523711   16295938   7.8G  5 Extended
# /dev/sda5       1937227776 1953523711   16295936   7.8G 82 Linux swap / Solaris
#
# Partition 3 does not start on physical sector boundary.
#
#
# Disk /dev/sdb: 477 GiB, 512110190592 bytes, 1000215216 sectors
# Units: sectors of 1 * 512 = 512 bytes
# Sector size (logical/physical): 512 bytes / 512 bytes
# I/O size (minimum/optimal): 512 bytes / 512 bytes
# Disklabel type: dos
# Disk identifier: 0x0008fe9b
#
# Device     Boot     Start        End   Sectors   Size Id Type
# /dev/sdb1  *         2048  967141375 967139328 461.2G 83 Linux
# /dev/sdb2       967143422 1000214527  33071106  15.8G  5 Extended
# /dev/sdb5       967143424 1000214527  33071104  15.8G 82 Linux swap / Solaris

# Show partitions, formats, and UUIDs.
sudo blkid
# /dev/sda1: UUID="B545-D15C" TYPE="vfat" PARTLABEL="EFI System Partition" PARTUUID="088bfc20-e02e-4c0f-a9a0-97393ea66a22"
# /dev/sda2: UUID="8aba78a5-df87-471d-ab5c-a3846c6858a9" TYPE="ext4" PARTUUID="5aac593a-e2c0-4924-9532-2a0b592fe1de"
# /dev/sdb1: LABEL="media" UUID="e5eb52cb-c135-4493-b810-43ffe4cf2e94" TYPE="ext4" PARTUUID="76758f34-a677-4c9c-9c84-4fb183f8bbf2"
# /dev/loop0: TYPE="squashfs"
# /dev/loop1: TYPE="squashfs"
# /dev/loop2: TYPE="squashfs"
# /dev/loop3: TYPE="squashfs"
# /dev/loop4: TYPE="squashfs"
# /dev/loop5: TYPE="squashfs"
# /dev/loop6: TYPE="squashfs"
# /dev/loop7: TYPE="squashfs"
# /dev/loop8: TYPE="squashfs"
# /dev/loop9: TYPE="squashfs"
# /dev/loop10: TYPE="squashfs"
# /dev/loop11: TYPE="squashfs"
# /dev/loop12: TYPE="squashfs"
# /dev/loop13: TYPE="squashfs"
# /dev/loop14: TYPE="squashfs"
# /dev/loop15: TYPE="squashfs"
# /dev/loop17: TYPE="squashfs"
# /dev/loop18: TYPE="squashfs"
# /dev/loop19: TYPE="squashfs"
# /dev/loop20: TYPE="squashfs"
# /dev/loop21: TYPE="squashfs"
# /dev/loop22: TYPE="squashfs"
# /dev/loop23: TYPE="squashfs"
# /dev/loop25: TYPE="squashfs"
# /dev/loop26: TYPE="squashfs"
# /dev/loop27: TYPE="squashfs"
# /dev/loop28: TYPE="squashfs"
# /dev/loop29: TYPE="squashfs"
# /dev/loop30: TYPE="squashfs"
# /dev/loop31: TYPE="squashfs"

# Another easy way to see disks and partitions whether they are mounted or not
# Does not require sudo.
lsblk
# NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
# sda      8:0    0   477G  0 disk
# ├─sda1   8:1    0 461.2G  0 part /
# ├─sda2   8:2    0     1K  0 part
# └─sda5   8:5    0  15.8G  0 part [SWAP]
# sr0     11:0    1  1024M  0 rom

# More thorough listing for mounted partitions.
findmnt
# TARGET                                SOURCE      FSTYPE          OPTIONS
# /                                     /dev/sda1   ext4            rw,relatime,errors=remount-ro,data=ordered
# ├─/sys                                sysfs       sysfs           rw,nosuid,nodev,noexec,relatime
# │ ├─/sys/kernel/security              securityfs  securityfs      rw,nosuid,nodev,noexec,relatime
# │ ├─/sys/fs/cgroup                    tmpfs       tmpfs           ro,nosuid,nodev,noexec,mode=755
# │ │ ├─/sys/fs/cgroup/systemd          cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/lib/systemd/systemd-cgroups-agent,name=s
# │ │ ├─/sys/fs/cgroup/cpuset           cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,cpuset
# │ │ ├─/sys/fs/cgroup/cpu,cpuacct      cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,cpu,cpuacct
# │ │ ├─/sys/fs/cgroup/devices          cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,devices
# │ │ ├─/sys/fs/cgroup/freezer          cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,freezer
# │ │ ├─/sys/fs/cgroup/net_cls,net_prio cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,net_cls,net_prio
# │ │ ├─/sys/fs/cgroup/blkio            cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,blkio
# │ │ └─/sys/fs/cgroup/perf_event       cgroup      cgroup          rw,nosuid,nodev,noexec,relatime,perf_event
# │ ├─/sys/fs/pstore                    pstore      pstore          rw,nosuid,nodev,noexec,relatime
# │ ├─/sys/kernel/debug                 debugfs     debugfs         rw,relatime
# │ └─/sys/fs/fuse/connections          fusectl     fusectl         rw,relatime
# ├─/proc                               proc        proc            rw,nosuid,nodev,noexec,relatime
# │ └─/proc/sys/fs/binfmt_misc          systemd-1   autofs          rw,relatime,fd=22,pgrp=1,timeout=300,minproto=5,maxproto=5,direct
# │   └─/proc/sys/fs/binfmt_misc        binfmt_misc binfmt_misc     rw,relatime
# ├─/dev                                udev        devtmpfs        rw,relatime,size=10240k,nr_inodes=490000,mode=755
# │ ├─/dev/pts                          devpts      devpts          rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000
# │ ├─/dev/shm                          tmpfs       tmpfs           rw,nosuid,nodev
# │ ├─/dev/hugepages                    hugetlbfs   hugetlbfs       rw,relatime
# │ └─/dev/mqueue                       mqueue      mqueue          rw,relatime
# ├─/run                                tmpfs       tmpfs           rw,nosuid,relatime,size=787732k,mode=755
# │ ├─/run/lock                         tmpfs       tmpfs           rw,nosuid,nodev,noexec,relatime,size=5120k
# │ ├─/run/rpc_pipefs                   rpc_pipefs  rpc_pipefs      rw,relatime
# │ ├─/run/user/118                     tmpfs       tmpfs           rw,nosuid,nodev,relatime,size=393868k,mode=700,uid=118,gid=126
# │ └─/run/user/1000                    tmpfs       tmpfs           rw,nosuid,nodev,relatime,size=393868k,mode=700,uid=1000,gid=1000
# │   └─/run/user/1000/gvfs             gvfsd-fuse  fuse.gvfsd-fuse rw,nosuid,nodev,relatime,user_id=1000,group_id=1000
# └─/etc/machine-id                     tmpfs[/machine-id]
#                                                   tmpfs           ro,relatime,size=787732k,mode=755

# Show disk logical name (e.g. /dev/sda), model number, vendor, serial, and size.
sudo lshw -class disk
# Show disk model number, serial number, firmware revision, configuration, rpm ("nominal rotation rate"), and enabled features.
sudo hdparm -I /dev/sda
# Show disk model number, serial number, firmware revision, size, and SMART disk health data.
sudo smartctl -a /dev/sda
sudo smartctl --all /dev/sda
smartctl --info /dev/sda

# Run SMART test.
sudo smartctl -t long /dev/sda
#[sudo] password for nathaniel:
#smartctl 6.6 2016-05-31 r4324 [x86_64-linux-4.15.0-23-generic] (local build)
#Copyright (C) 2002-16, Bruce Allen, Christian Franke, www.smartmontools.org
#
#=== START OF OFFLINE IMMEDIATE AND SELF-TEST SECTION ===
#Sending command: "Execute SMART Extended self-test routine immediately in off-line mode".
#Drive command "Execute SMART Extended self-test routine immediately in off-line mode" successful.
#Testing has begun.
#Please wait 170 minutes for test to complete.
#Test will complete after Fri Jun 29 00:56:53 2018
#
#Use smartctl -X to abort test.


# Show how much RAM there is.
sudo dmidecode --type memory | grep -i size
# Alternately, use this; does not required root.
grep MemTotal: /proc/meminfo
# RAM form factor
sudo dmidecode --type memory
## dmidecode 2.12
#SMBIOS 2.6 present.
#
#Handle 0x0005, DMI type 16, 15 bytes
#Physical Memory Array
#	Location: System Board Or Motherboard
#	Use: System Memory
#	Error Correction Type: None
#	Maximum Capacity: 16 GB
#	Error Information Handle: Not Provided
#	Number Of Devices: 2
#
#Handle 0x0006, DMI type 17, 28 bytes
#Memory Device
#	Array Handle: 0x0005
#	Error Information Handle: Not Provided
#	Total Width: 64 bits
#	Data Width: 64 bits
#	Size: 4096 MB
#	Form Factor: SODIMM
#	Set: None
#	Locator: ChannelA-DIMM0
#	Bank Locator: BANK 0
#	Type: DDR3
#	Type Detail: Synchronous
#	Speed: 1333 MHz
#	Manufacturer: 0443
#	Serial Number: 41C43E65
#	Asset Tag: 9876543210
#	Part Number: RMT3020EC58E9F1333
#	Rank: Unknown
#
#Handle 0x0007, DMI type 17, 28 bytes
#Memory Device
#	Array Handle: 0x0005
#	Error Information Handle: Not Provided
#	Total Width: 64 bits
#	Data Width: 64 bits
#	Size: 4096 MB
#	Form Factor: SODIMM
#	Set: None
#	Locator: ChannelB-DIMM0
#	Bank Locator: BANK 2
#	Type: DDR3
#	Type Detail: Synchronous
#	Speed: 1333 MHz
#	Manufacturer: 04CD
#	Serial Number: 00000000
#	Asset Tag: 9876543210
#	Part Number: F3-12800CL11-4GBSQ
#	Rank: Unknown



# Check hard drive partitions
cat /proc/diskstats

# Get general dump of hardware info
lshw

# Get a new DVD drive to work
sudo regionset /dev/dvd4

# Capture a disc image
cat /dev/sr0 > my-disc.iso
# or
cp /dev/sr0 my-disc.iso
# or
dd if=/dev/dvd4 of=/path/to/output/my-disc.iso && eject
# or
readom dev=/dev/sr0 f=$HOME/Downloads/disc.iso && eject
# or
pv < /dev/sr0 > my-disc.iso

# Don't need to use an absolute path.
readom dev=/dev/sr0 f=./disc.iso && eject

# TODO: does rsync work?
rsync

# Also eject:
cp /dev/sr0 my-disc.iso; eject
# Also alert when something goes wrong:
cp /dev/sr0 my-disc.iso && eject || zenity --error --text='Disc copy failed.'

# or
cdrdao
# https://superuser.com/questions/616392/copying-windows-installation-cd-to-iso-on-ubuntu
# https://unix.stackexchange.com/questions/224277/is-it-better-to-use-cat-dd-pv-or-another-procedure-to-copy-a-cd-dvd
# http://www.1stbyte.com/2012/10/19/create-iso-image-from-cd-or-dvd-disk-in-linux/
safecopy /dev/dvd out.iso && eject
# https://askubuntu.com/questions/138152/software-to-copy-a-scratched-cd-dvd-blueray-to-an-iso-file
# do a quick first-run.
safecopy --stage1 /dev/sr0 safecopy.iso
safecopy --stage2 /dev/sr0 safecopy.iso
safecopy /dev/cdrom out.iso
safecopy /dev/dvd out.iso
safecopy /dev/sr0 safecopy.iso

# Safecopy with timing and eject, ignoring badblocks.
time safecopy -o /dev/null /dev/sr0 my-disc.iso; eject

isohybrid systemrescuecd-x86-4.8.0.iso
# After formatting USB to FAT32 or ext3:
sudo cp systemrescuecd-x86-4.8.0.iso /dev/sdb
sudo sync
sudo file -s /dev/sdb
# /dev/sdb: DOS/MBR boot sector ISO 9660 CD-ROM filesystem data 'sysrcd-4.8.0' (bootable); partition 1 : ID=0x17, active, start-CHS (0x0,0,1), end-CHS (0x1d1,63,32), startsector 0, 954368 sectors
sudo qemu-system-x86_64 -hda /dev/sdb

isoinfo -d -i /dev/cdrom
# CD-ROM is in ISO 9660 format
# System id:
# Volume id: QSS_CD
# Volume set id:
# Publisher id:
# Data preparer id:
# Application id:
# Copyright File id:
# Abstract File id:
# Bibliographic File id:
# Volume set size is: 1
# Volume set sequence number is: 1
# Logical block size is: 2048
# Volume size is: 40271
# Joliet with UCS level 3 found
# NO Rock Ridge present

# Copy an ISO to a USB flash drive on /dev/sdg
umount /media/usb
cp debian.iso /dev/sdg && sync
# Or, more realistically:
umount /media/usb
sudo cp debian-live-8.4.0-amd64-xfce-desktop.iso /dev/sdg && sync
# Beware, this cannot be interrupted, even with kill -9.
# https://www.debian.org/CD/faq/#write-usb
# https://unix.stackexchange.com/questions/360693/how-does-copying-the-debian-iso-directly-to-a-usb-drive-work


# Write a disk image to USB flash drive at /dev/sdc.
sudo dd if=./memtest86-usb.img of=/dev/sdc conv=fsync status=progress
sudo dd if=./memtest86-usb.img of=/dev/sdc bs=16M status=progress oflag=sync

umount /media/nathaniel/SIMMAX
# > Error unmounting block device 8:16: GDBus.Error:org.freedesktop.UDisks2.Error.DeviceBusy: Error unmounting /dev/sdb: target is busy
# Can also do this:
umount /dev/sdb
# but this is deprecated:
# man:umount(8)
# > A file system is specified by giving the directory where it has been mounted.
# > Giving the special device on which the file system lives may also work, but
# > is obsolete, mainly because it will fail in case this device was mounted on
# > more  than one directory.
# > Note that a file system cannot be unmounted when it is 'busy' - for
# > example, when there are open files on it, or when some process has its
# > working directory there, or when a swap file on it is in use.

# Restart the gui for ubuntu
unity-2d-shell --reset

# Show numeric gateway ip address
route -n
# Another way to get the same thing
netstat -rn
# Show gateway name
route

# How to start a new flashbake directory:
#1. Initialize the git repository in the relevant directory.
git init
#2. Make a .flashbake file.
echo "*.txt" > .flashbake
#3. Make a .gitignore file (optional).
#4. Add a cronjob like this:
*/15 * * * * /usr/local/bin/flashbake ~/Dropbox/writings/ 5 2> ~/Dropbox/flashbake-status.txt

# Restart sound daemon, e.g. when flash has choppy audio
pulseaudio --kill
pulseaudio --start # start it up again as a daemon

# Debugging wifi.
# Get information about wifi adapter,
# including driver version
# and logical name (e.g. wlan0).
sudo lshw -C network > wifi-card-info.txt
# Get log of network manager.
sudo service network-manager stop
sudo NetworkManager --no-daemon 2>&1 | tee NetworkManager.log
# Better way of logging network manager, if you use systemd.
journalctl -fu NetworkManager
# Look in kernel log (ring buffer).
dmesg | grep 'rtl8192\|wlan' | tee dmesg.log

# Detach process from gnome-terminal
Ctrl-Z # Access shell prompt
bg     # Put job in background, but let it keep running.
# Note job number, or use
jobs
disown -h %1 # Detach job 1 from current terminal (%1 is the jobspec/job identifier)
# -h : mark each JOBSPEC so that SIGHUP is not sent to the job if the shell receives a SIGHUP

# Restart compiz from a terminal emulator
# Note: Disown defaults to %1, so make sure you don't have any other jobs.
# bash: warning: deleting stopped job 1 with process group
DISPLAY=:0 compiz --replace & disown
# If that doesn't work...
unity --reset & disown


# Generate 5-word passphrase
shuf --head-count=5 /usr/share/dict/words
shuf -n 5 /usr/share/dict/words
# Get rid of the words with apostrophes.
grep -v "'" /usr/share/dict/words | shuf -n 5
# Get rid of apostrophes and capital letters.
grep -v '[A-Z]' /usr/share/dict/words | grep -v "'" | shuf -n 5

# Get five random files from a directory.
shuf -en 5 /bin/*
# https://unix.stackexchange.com/questions/506302/how-to-shuffle-file-names-randomly-in-a-directory
# https://unix.stackexchange.com/questions/38335/best-method-to-collect-a-random-sample-from-a-collection-of-files
# https://stackoverflow.com/questions/701402/best-way-to-choose-a-random-file-from-a-directory
# https://stackoverflow.com/questions/414164/how-can-i-select-random-files-from-a-directory-in-bash
# https://stackoverflow.com/questions/701505/best-way-to-choose-a-random-file-from-a-directory-in-a-shell-script

# if you install dictionaries-common,
# you may need to run
sudo dpkg-reconfigure dictionaries-common
# or
sudo select-default-wordlist
# to make sure /usr/share/dict/words isn't a broken symlink pointing to /etc/dictionaries-common/words

# See running jobs
lpstat
# List printers
lpstat -s
lpstat -v
cat /etc/printcap | tr "|" "\t" | cut -f 1 | grep -v "#"
tr "|" "\t" < /etc/printcap | cut -f 1 | grep -v "#"

# Detailed printer info.
lpstat -l -p canon_laserjet

# List of completed print jobs.
lpstat -W completed | less

# Print document from the command line to a network printer by printer's name
lpr -P "Brother-HL-4070CDW" doc.pdf
# Print in double-sided
lpr -p "Brother-HL-4070CDW" -o sides=two-sided-long-edge doc.pdf
# List options for printer
lpoptions -p Brother-HL-4070CDW -l
# Use options with lpr
lpr -P "Brother-HL-4070CDW" -o PageSize=Letter -o PageRegion=A4 -o Duplex=DuplexNoTumble -o Resolution=1200x1200dpi doc.pdf
# See the print queue by printer's name
lpq -P "Brother-HL-4070CDW"

# List avahi/bonjour services like printers on the local area network (LAN)
# Need avahi-utils
avahi-browse --all --verbose --terminate --resolve
avahi-browse -avtr
# Need arp-scan package
sudo arp-scan --localnet | less
sudo arp-scan --interface eth3 --localnet | less
# When avahi-daemon sucks up 100% cpu
# https://bugs.launchpad.net/ubuntu/+source/avahi/+bug/1059286
# *Ubuntu only*
sudo restart cups && sudo restart avahi-daemon

sudo service cups restart

# Restart cups in Ubuntu 16.04 (?) and later.
systemctl restart cups.service
# or just:
systemctl restart cups

# Discover machines on the LAN
ifconfig eth0
# Note Bcast address. Now ping it:
ping -b -c 3 -i 20 $BROADCASE_ADDRESS

# Chat using netcat.
# On computer #1 (chloride):
nc -l -p 4444
# On computer #2 (thinpad):
nc chloride.phys.iit.edu 4444
# Set a 1-second timeout in case the port is blocked.
nc -w 1 chloride.phys.iit.edu 4444
# Press enter when you want to send a line.
# Press Ctrl-C when you are done.

# Example log:
# nbeaver@chloride:~$ nc -l -p 4444
# Hi, thinkpad!
# Hi, chloride!
# Are we done here?
# Yes, goodbye.
# Alright, bye.
# ^C
# nc chloride.phys.iit.edu 4444
# Hi, thinkpad!
# Hi, chloride!
# Are we done here?
# Yes, goodbye.
# Alright, bye.

# If another machine tries to join, it gets this message:
# nbeaver@omega:~$ nc chloride.phys.iit.edu 4444
# chloride.phys.iit.edu [216.47.138.69] 4444 (?) : Connection refused

telnet chloride.phys.iit.edu 80
# Use Ctrl-] q to get out of it.
# $ telnet chloride.phys.iit.edu 80
# Trying 216.47.138.69...
# Connected to chloride.phys.iit.edu.
# Escape character is '^]'.
# ^]q
#
# telnet> q
# Connection closed.

# Check if a port is filtered on a remote machine.
nmap -p T:60000 chloride.phys.iit.edu
# $ nmap -p T:60000 chloride.phys.iit.edu
#
# Starting Nmap 6.47 ( http://nmap.org ) at 2015-08-07 15:08 CDT
# Nmap scan report for chloride.phys.iit.edu (216.47.138.69)
# Host is up (0.027s latency).
# PORT      STATE    SERVICE
# 60000/tcp filtered unknown
#
# Nmap done: 1 IP address (1 host up) scanned in 0.39 seconds
# nathaniel@thinkpad:~/tmp$ nmap -p T:4444 chloride.phys.iit.edu
#
# Starting Nmap 6.47 ( http://nmap.org ) at 2015-08-07 15:08 CDT
# Nmap scan report for chloride.phys.iit.edu (216.47.138.69)
# Host is up (0.025s latency).
# PORT     STATE  SERVICE
# 4444/tcp closed krb524
#
# Nmap done: 1 IP address (1 host up) scanned in 0.19 seconds

# Scan remote host for IRC server.
nmap -p 6667 onyx.lan.
#
# Starting Nmap 7.60 ( https://nmap.org ) at 2021-03-18 20:50 EDT
# Nmap scan report for onyx.lan. (192.168.174.113)
# Host is up (0.0090s latency).
# rDNS record for 192.168.174.113: onyx.lan
#
# PORT     STATE SERVICE
# 6667/tcp open  irc
#
# Nmap done: 1 IP address (1 host up) scanned in 0.13 seconds

# See what your browser is doing.
nc -l -p 8000 -v

# Check if port is open for e.g. SSH port.
nc -vz localhost 9999
# https://stackoverflow.com/questions/1998297/ssh-check-if-a-tunnel-is-alive/24356001#24356001

# After sshing in, any of these
users
who
w
# will tell you who is logged in.
# Also try
last
# to see who was logged in previously.
# To message user nbeaver, enter
write nbeaver <enter>
# Type message. They can write you back, too.
wall <enter>
# Type message, Ctrl-D

# Grep wifi connections for WPA passkeys.
sudo grep -r '^psk=' /etc/NetworkManager/system-connections/

# Passkeys, prepended with 'psk='.
sudo grep -hr '^psk=' /etc/NetworkManager/system-connections/

# Just the passkeys.
sudo sed -n 's/^psk=//gp' /etc/NetworkManager/system-connections/*

# Grep wifi connections for passkeys and passwords (uses grep "OR" \|)
sudo grep -r '^psk=\|^password=' /etc/NetworkManager/system-connections/

# Encrypt file with gpg (will prompt for passphrase)
gpg --symmetric super-secret-file.txt

# Generate encypted file with vim
vim -x encrypted-file.txt

# Start editing at bottom of file with vim
vim + myfile.txt

# Edit stdin in vim
vim -
# Slower method:
echo 'hi' | vim /dev/stdin

# Time a slow start-up.
vim --startuptime vim.log ~/path/to/file/to/edit
vim --startuptime $(tempfile) ~/path/to/file/to/edit

# On bash command line, edit current command in your favorite $EDITOR (e.g. vim)
Ctrl-X Ctrl-E
# edit-and-execute-command (C-x C-e)
# Invoke an editor on the current command line, and execute the result as shell
# commands. Bash attempts to invoke $VISUAL, $EDITOR, and emacs as the editor,
# in that order.
# https://www.gnu.org/software/bash/manual/html_node/Miscellaneous-Commands.html

# On bash command line, cut word before cursor
Ctrl-W
# On bash command line, cut word after cursor
Esc-W
# On bash command line, incremental undo
Ctrl-X Ctrl-U
# On bash command line, move forward/backword one character
Ctrl-F
Ctrl-B
# On bash command line, move forward/backword one word
Esc-F
Esc-B
# On bash command line, reverse incremental search through previous commands
Ctrl-R
Ctrl-S # forward
# While using reverse incremental search:
Enter  # Executes command immediately
Ctrl-J # Copies command to prompt, allowing further editing
Ctrl-G # Escapes incremental search without doing anything
# Move to beginning of history
Alt-Shift-,
# Move to end of history
Alt-Shift-.
# Bash history modifiers (bang commands) http://www.softpanorama.org/Scripting/Shellorama/bash_command_history_reuse.shtml
# The technical term is "event designator" http://www.catonmat.net/blog/top-ten-one-liners-from-commandlinefu-explained/
!! # execute last command
!-1 # execute last command
!!:1 # first argument of the last command
!1 # first argument of the last command
!!:$ # last argument of preceding commnad
!$ # last argument of preceding commnad
!gzip # execute most recent gzip command
!?etc.gz # Like Ctrl-R, runs most recent command matching 'etc.gz'

# Remove spaces and duplicate lines
cat myfile.txt | tr --squeeze-repeats ' ' | sort | uniq > my-condensed-file-with-duplicates-removed.txt
sudo grep -r helper /var/log/

# Why sort | uniq, not sort -u? Because of unexpected behavior:
# https://www.solipsys.co.uk/new/UnexpectedInteractionOfFeatures.html?sb17h

# Latex build for Bibtex
pdflatex -synctex=1 -interaction=nonstopmode %.tex|bibtex %.aux|pdflatex -synctex=1 -interaction=nonstopmode %.tex|evince %.pdf

# Generate combined file with name of file included
tail --lines=+1 version.log lsb_releaser-rd.log partial-crash-log.log lspci-vnvn.log > log-merge.log
tail -n +1 version.log lsb_releaser-rd.log partial-crash-log.log lspci-vnvn.log > log-merge.log

# Use awk to give column 2, space, column 1, tab, then the last column
awk '{print $2,$1 "\t" $NF}' iit-phonebook-duplicates-removed-cleaned-up.txt | uniq > iit-name-and-email.txt

# Kill escalation
kill 21213 # sends SIGTERM (like Ctrl-C) to process 21213
kill -15 21213 # sends SIGTERM (like Ctrl-C) to process 21213
kill -2 21213 # send SIGINT to process 21213
kill -1 21213 # send SIGHUP to process 21213
kill -3 21213 # send SIGQUIT (like Ctrl-\) to process 21213; will dump core
kill -9 21213 # sends unblockable KILL signal to kernel

# Pause all Firefox processes for 3 seconds.
kill -SIGSTOP $(pgrep firefox); sleep 3; kill -SIGCONT $(pgrep firefox)

# Kill a process, wait a second, then see if it's still running
kill -3 4782 && sleep 1 && ps aux | grep 4782
kill 3105; sleep 1; ps -p 3105

# Find connected program
netstat -tulanp | less
netstat --tcp --udp --listening --all --numeric --program | less # long version
# List open ports
netstat -pln
# See list of things that are listening remotely
netstat -tnlp | grep -v 127.0.0 | grep -v ::1:

sudo netstat -lnp | less

# Disk usage of current directory (total only)
du -sh
du --summarize --human-readable
# List ten directory or files taking up the most space
du -hsx * | sort -rh | head -10
du --summarize --human-readable --one-file-system * | sort --human-numeric-sort --reverse | head --lines=10

# Ignore hidden files.
du -sh --exclude "./.*"

# Get disk usage of everything not in the home directories.
sudo du -sh --exclude='/home/*' /
# use less disk doing it.
sudo ionice -c 3 du -sh --exclude='/home/*' /
# Also exclude /proc/ and /run/:
sudo ionice -c 3 du -sh --exclude='/home/*' --exclude='/proc/*' '/run/*' /

# Adding metadata to pdfs with pdftk
# Add an info dictionary if there isn't one already (harmless)
pdftk book.pdf cat output book.pdf
# Extract metadata
pdftk book.pdf dump_data > info.txt
# Edit metadata
vim info.txt
# Update pdf metadata
pdftk book.pdf update_info  info.txt output out-book.pdf
# Dump all metadata
for f in *.pdf; do echo "=====$f=====" >> dump.txt; pdftk "$f" dump_data &>> dump.txt; done

pdftk needs-password.pdf cat output out.pdf do_ask

# Copy all files in a remote directory to this computer.
scp -r iit@id1.mr.aps.anl.gov:~/Pelliccione/Te_edge_12_17_2012 /home/nathaniel/Dropbox/10_Fall_2012/APS/data-analysis/

# Run redshift with location near Chicago
redshift -l 41:-87
# Improved accuracy and run in the background:
nohup redshift -l manual:41.9:-87.6 -t 5700:3600 -g 0.8 -m vidmode -v & disown
# Note: don't let this conflict with the ~/.config/redshift.conf file.
# Note: this will produce a nohup.out file. If you don't like it, use it this way:
nohup redshift -l 41.9:-87.6 -t 5700:3600 -g 0.8 -m vidmode -v  2>/dev/null 1>/dev/null & disown
# https://stackoverflow.com/questions/10408816/how-to-use-unix-command-nohup-without-nohup-out

# Using gpg for encryption
gpg -c myfile.txt # Generates myfile.txt.gpg
# Be ready to provide a passphrase
gpg -c -o myfile.enc myfile # If you want to specify the output name
# Don't forget to erase the original file!
# Decrypt the encrypted file and push it to stdout
gpg -d myfile.enc
# Decrypt the encrypted file and save it to a file
gpg -o myfilenew myfile.enc

# Encrypt a tar file with your own public key.
# Hasn't been verified yet
tar --preserve-permissions --create --compress --file /etc/cups | gpg --encrypt --recipient 'nathaniel@thinkpad' --output '/home/nathaniel/SpiderOak Hive/etc-backup/cups.tar.gz.enc'

# Get all kinds of data, including disk usage
vmstat 1

# Rename all file ending in Unknown.pdf and strip the ' - Unknown' part of their name
for f in *Unknown.pdf; do mv "$f" ${f% - Unknown.pdf}.pdf; done

# Avoiding the '^[[A' or '^[[B' effect when trying to get previous command
# (pressing up or down arrow) for a cli program
rlwrap cmd
rlwrap java -cp /FromWeb/frink.jar frink.parser.Frink "$@"
rlwrap math
# Save a logfile of output (including echoed input)
rlwrap -l mylog.txt math

# Show how the terminal interprets keypresses.
cat -v
# E.g.
# up arrow = ^[[A
# down arrow = ^[[B
# left arrow = ^[[D
# right arrow = ^[[C
# F1 = ^[OP
# F4 = ^[OS
# F5 = ^[[15~
# F7 = ^[[18~
# Home = ^[OH
# End = ^[OF
# Insert = ^[[2~
# Delete = ^[[3~
# PgUp = ^[[5~
# PgDn = ^[[6~
# Escape = ^[

# Text to speech
echo 'Hello, world!' | espeak --stdin
echo 'Hello, world!' | festival --tts

# List to your computer say "Ping!" every 2 seconds
ping -i 2 localhost | sed -u 's/.*/ping/' | espeak
# Inspired by a story from the author of the ping utility, Mike Muuss.
# http://ftp.arl.mil/mike/ping.html
# Ping google.com instead, and use Mac OS X 'say' command:
ping google.com | sed -u 's/.*/ping/' | xargs -n1 say
# https://news.ycombinator.com/item?id=8861819
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/07248c2f-4809-4b19-9ff0-6fa8e554b8f6.json

# Trace the route/path of the connection to an ip address or website
tracepath google.com
tracepath 10.96.21.19

# Windows-only: using the Windows version of traceroute.
tracert 8.8.8.8
tracert 192.168.0.1

# Check network connectivity for dropped packets
ping -f -i 1 8.8.8.8
# Observe where the packets are being dropped at the same time
mtr -t 8.8.8.8
# Press 'p' in mtr to pause.

# Generate random 30 character alphanumeric password
strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n'; echo

# Get information about zip files in current directory
for f in *.zip; do unzip -v $f; done

# Cracking zip files:
# Dictionary method
fcrackzip --use-unzip --verbose --dictionary --init-password /usr/share/dict/words platelet.zip
fcrackzip -uvDp /usr/share/dict/words platelet.zip
# Brute-force method, no knowledge of password, only setting length limits
fcrackzip -u -l 3-4 geek.zip
time fcrackzip -u -l 3-4 geek.zip

# PASSWORD FOUND!!!!: pw == geek
#
# real	0m49.633s
# user	0m1.916s
# sys	0m2.236s

# Do something for each line of a file
while read line; do
    echo $line  < /dev/null # to keep the command from consuming stdin.
done < file.txt
# On one line
while read line; do echo -e "$line\n"; done < file.txt
# http://bash.cyberciti.biz/guide/While_loop
# Example: see the type of the first command in each of the bash history.
while read line; do type $(echo -n "$line" | cut -d' ' -f1); done < ~/.bash_history |& less
while read line; do whois "$line" | grep 'NetName'; done < list-of-ip-addresses.txt
# Most commands already run over lines of a text file already,
# so it's not often that this kind of command is necessary.

# Whack-a-mole with an unwanted process.
while true; do killall avahi-daemon; echo $?; sleep 10; done

# Run a command until it fails.
while popd; do :; done
while ping -c 1 google.com; do sleep 1; done
# https://stackoverflow.com/questions/12967232/repeatedly-run-a-shell-command-until-it-fails

# Run a command until it succeeds.
until ping -c 1 google.com; do sleep 1; done

# Run redshift in the background so that the terminal can be closed
# and use nohup so that it says open even after logging out
nohup redshift -l 41:87 & disown

# Allow everyone to read a file.
sudo chmod a+r file
# Turn off world-readable status.
sudo chmod o-r file
# Turn off world-editable status.
sudo chmod o-w file

# Protect home directory from access by other users.
chmod o-rwx $HOME
# https://askubuntu.com/questions/46501/why-can-other-users-see-the-files-in-my-home-folder
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/2d031b99-6945-45bd-be31-71382d661d73.json

# The default shell:
echo $SHELL
# The actual shell you're running inside (name of the running process):
echo $0
# The actual executable run by the shell of the running process.
readlink -f "$(which "$0")"
readlink --canonicalize "$(which "$0")"
# Follow the links leading there.
namei $(which $0)

# Change the login shell to bash if your username is nbeaver.
chsh --shell /bin/bash nbeaver
# Or, more automatically:
chsh --shell $(which bash) $USER
# Note that chsh will only work if you are in /etc/passwd.
# Otherwise you will have to edit .profile and add this.
export SHELL=/bin/bash
bash
# This will require you to hit Ctrl-D twice when one want to log out,
# once when you exit bash and once when you exit dash.
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/7a49c243-47f7-4a5a-a42a-87357d134b0d.json

# Find out whether a package is installed or not.
# Also tells you the version and whether it's installed from a ppa.
# Also tells you if you have an old package and could install a newer candidate with apt-get upgrade.
apt-cache policy gnash browser-plugin-gnash
apt-cache policy ".*gnash.*"
# Useful for scripts.
dpkg -s browser-plugin-gnash

# Gives much of the same info as policy (version, architecture) but also shows if e.g. config files are still installed.
# Does not show if there is a newer package available or not.
dpkg --list "*gnash*"
dpkg -l "*gnash*"

# Also useful for checking if a package is installed.

# Get description of package
aptitude show gnash
dpkg --status gnash
dpkg -s gnash

# Find out corresponding package to given command (what package a command "belongs" to)
dpkg -S $(which gnash)
dpkg --search $(which gnash)
# May take a long time to do the disk access, though.
#   $ time dpkg -S /usr/sbin/NetworkManager
#   network-manager: /usr/sbin/NetworkManager

#   real	0m54.106s
#   user	0m0.564s
#   sys	0m0.268s
# Same search, but much faster.
dlocate /usr/share/dict/words
dlocate libc.so.6

# Find which package rm is from.
# The trailing $ is necessary to prevent e.g. matches to /bin/rmdir.
dlocate "$(which rm)\$"
# Similar:
dlocate /usr/bin/time$
# Prevents matches to pstree etc.
$ dlocate '/bin/ps$'
procps: /bin/ps

#   $ time dpkg -S /usr/share/dict/words
#   diversion by dictionaries-common from: /usr/share/dict/words
#   diversion by dictionaries-common to: /usr/share/dict/words.pre-dictionaries-common
#   dictionaries-common, wamerican: /usr/share/dict/words
#
#   real	0m0.395s
#   user	0m0.300s
#   sys	0m0.088s
#   $ time dlocate /usr/share/dict/words
#   wamerican: /usr/share/dict/words
#   dictionaries-common: /usr/share/dict/words
#   diversion by dictionaries-common from: /usr/share/dict/words
#   diversion by dictionaries-common to: /usr/share/dict/words.pre-dictionaries-common
#
#   real	0m0.054s
#   user	0m0.016s
#   sys	0m0.016s

# Same search, but also works for uninstalled packages.
apt-file search $(which gnash)
apt-file search libc.so.6
# This doesn't require an internet connection,
# but apt-file update does.

#   $ time apt-file search /usr/share/dict/words
#   dictionaries-common: /usr/share/dict/words
#   wamerican: /usr/share/dict/words
#
#   real	0m2.820s
#   user	0m2.812s
#   sys	0m0.228s

# Find which package contained a header file.
# Useful for compiling from source.
apt-file -x search '/fftw3.h$'
# libfftw3-dev: /usr/include/fftw3.h
apt-file -x search '/glib.h$'

apt-file search showkey
# kbd: /usr/bin/showkey
# kbd: /usr/share/man/man1/showkey.1.gz
# manpages-es-extra: /usr/share/man/es/man1/showkey.1.gz
# manpages-zh: /usr/share/man/zh_CN/man1/showkey.1.gz
# manpages-zh: /usr/share/man/zh_TW/man1/showkey.1.gz
# texlive-lang-polish: /usr/share/doc/texlive-doc/generic/tex-virtual-academy-pl/latex2e/macro/showkeys.html
# texlive-latex-base: /usr/share/texlive/texmf-dist/tex/latex/tools/showkeys.sty
# texlive-latex-base-doc: /usr/share/doc/texlive-doc/latex/tools/showkeys.pdf
# texlive-latex-extra-doc: /usr/share/doc/texlive-doc/latex/dlfltxb/dlfltxbmarkup-showkeys.pdf
# texlive-latex-extra-doc: /usr/share/doc/texlive-doc/latex/dlfltxb/dlfltxbmarkup-showkeys.tex
# texlive-science: /usr/share/texlive/texmf-dist/tex/latex/chemcono/showkeysff.sty
apt-file search -x '/showkey$'
# kbd: /usr/bin/showkey

# Guess the executable or command associated with a package.
# This actually lists all the files installed, so we need to grep out the executables.
# Caveat: will not tell you about wrapper scripts or arguments that need to be passed.
# In this case, it's trying to figure out the handbrake gui program which is named completely unlike HandbrakeCLI.
dpkg -L handbrake-gtk | grep bin
/usr/bin
/usr/bin/ghb
dpkg --listfiles handbrake-gtk | grep bin

# This does the same thing, but you don't need to actually install the package to use it.
apt-file list handbrake-gtk

# If you want to get really fancy, you can search in the .desktop file to see what gets executed.
grep "Exec" $(dpkg -L handbrake-gtk | grep '/usr/share/applications/.*\.desktop$')
# For just the executable command.
grep "Exec" $(dpkg -L handbrake-gtk | grep '/usr/share/applications/.*\.desktop$') | cut -f2 -d"="
# Warning: this will hang if there are no .desktop files associated with the package.

# List the files installed by a .deb file
dpkg -c /var/cache/apt/archives/example_1.0.0-1_all.deb
dpkg --contents

# Unarchive a debian file.
ar vx skype-debian_4.3.0.37-1_i386.deb

# List contents of a debian file.
ar t /var/cache/apt/archives/ack-grep_2.14-4_all.deb
# debian-binary
# control.tar.gz
# data.tar.xz

# List the contents of the tar.gz file.
ar p /var/cache/apt/archives/ack-grep_2.14-4_all.deb control.tar.gz | tar --ungzip --list --to-stdout | less
# ./
# ./control
# ./md5sums
# ./preinst
# ./postrm
# ./postinst

# Example of script that will run after a package is installed.
/var/lib/dpkg/info/apt.postinst
/var/lib/dpkg/info/linux-base.postinst
/var/lib/dpkg/info/linux-image-3.16.0-4-amd64.postinst

# Send the contents of debian control file to stdout.
ar p /var/cache/apt/archives/ack-grep_2.14-4_all.deb control.tar.gz | tar -z -x --to-stdout ./control

# Install a .deb file.
sudo dpkg -i example-package.deb
# Install a .deb along with its prerequisites.
sudo gdebi skype-debian_4.3.0.37-1_i386.deb

# Download debian package into current directory
apt-get download mypackage

# Can also get it from the web mirrors.
wget http://ftp.us.debian.org/debian/pool/contrib/h/horae/horae_071~svn537-2_all.deb

# Extract the files in a .deb package to a specified directory
dpkg -x /var/cache/apt/archives/example_1.0.0-1_all.deb ~/path/to/extracted/files
dpkg --extract
dpkg-deb -x skype-deb_4.3.0.37-1_i386.deb /tmp/extract/
# Extract the files in a .deb package to a specified directory,
# and list all the files that were extracted (verbose extract)
dpkg -X /var/cache/apt/archives/example_1.0.0-1_all.deb ~/path/to/extracted/files
dpkg --vextract

# Make a screencast by capturing output.
ffmpeg -f x11grab -s `xdpyinfo | grep 'dimensions:'|awk '{print $2}'` -r 25 -i :0.0 output.mkv
ffmpeg -f x11grab -s 1600x900 -r 25 -i :0.0 output.mkv
ffmpeg -f x11grab -s 1600x900 -r 25 -i $DISPLAY output.mkv

# Stop after 30 seconds.
ffmpeg -f x11grab -s 1600x900 -r 25 -i $DISPLAY -t 30 output.mkv
# https://askubuntu.com/questions/436956/stop-the-recording-after-some-period-of-time
# https://ffmpeg.org/ffmpeg-utils.html#Time-duration
# Wait 5 seconds, then start.
sleep 5; ffmpeg -f x11grab -s 1600x900 -r 25 -i $DISPLAY -t 30 output.mkv

# Make a silent screencast that lasts 30 seconds.
sleep 5; timeout 30s recordmydesktop --no-sound -o example.ogv
# This is nicer than ffmpeg because it shows a screen overlay
# so you know when it's started and when it's done.

xdpyinfo | grep 'dimensions:' | awk '{print $2}'
xrandr | grep -P '\d+x\d+ .*\*' | awk '{print $1}'
xrandr | grep '*' | awk '{print $1}'

# Find 'Howe' but not 'However'
grep -P '(?!.*However)Howe' -r .
# https://unix.stackexchange.com/questions/96480/with-grep-how-can-i-match-a-pattern-and-invert-match-another-pattern
# https://stackoverflow.com/questions/4538253/how-can-i-exclude-one-word-with-grep
# https://perldoc.perl.org/perlre.html#Regular-Expressions
# TODO: can this be done without Perl regular expressions?
printf 'However\nHowe\nhowe\nHowey\n' | grep -P '(?!.*However)Howe'
# Use silver searcher to do the same thing.
ag '(?!.*However)Howe'

# See programs using the Internet.
lsof -i -P | less

# Compile with the gfortran compiler
gfortran myprogram.f95 -o myprogram

# Show kernel information (e.g. 64-bit vs 32-bit)
uname --all
# Linux
# Darwin
# Only the kernel architecture, e.g. x86_64
uname --machine
uname -m
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/f69252a3-a58b-48bc-9fd2-89e9e5d29f94.json

# Shows kernal architecture as well,
# theoretically the same as uname -m.
arch
# x86_64
# i386

# Darwin-only command to get machine architecture.
machine
# i486

# Show byte-order.
perl -MConfig -e 'printf "%s\n", $Config{byteorder}'
# 12345678
# 1234


# Show cpu information
lscpu
# (e.g. 64-bit vs 32-bit)
lscpu | grep 'Architecture:'
# Show only the architecture name, e.g. x86_64
lscpu | grep '^Architecture:' | awk '{print $2}'
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/101630e8-efc4-4566-bbc8-78e6ac76120f.json

# Try to fix wifi
sudo echo SUSPEND_MODULES="$SUSPEND_MODULES rtl1892ce" >> /etc/pm/config.d/unload_modules

# Matrix-like command. Totally useless.
cat /dev/urandom | hexdump

# Get EXIF metadata for an image, including duplicate and unknown tags, sorted by group (for family 1).
exiftool -a -u -g1 IMG_3689.JPG
exiftool -duplicates -unknown -groupHeadings 1 IMG_3689.JPG

# All GPS metadata.
exiftool -n -GPS'*' img_0001.jpg

# Just GPS position.
exiftool -n -GPSPosition img_0001.jpg

# Strip EXIF metadata.
exiftool -all= IMG_3689.JPG
mogrify -strip IMG_3689.JPG
# http://www.hacktux.com/read/remove/exif
# http://www.linux-magazine.com/Online/Blogs/Productivity-Sauce/Remove-EXIF-Metadata-from-Photos-with-exiftool

# Crop a white border.
convert -trim myfile.png myfile-cropped.png
# In place:
mogrify -trim myfile.png
# https://askubuntu.com/questions/351767/how-to-crop-borders-white-spaces-from-image

# Also trim colors that are close to the border color.
convert -fuzz 25% -trim myfile.png myfile-cropped.png
# https://www.imagemagick.org/Usage/bugs/fuzz_distance/

# Mount an external drive.
sudo mkdir /media/nathaniel/external
sudo mount /dev/sdb1 /media/nathaniel/external/ -o uid=1000,gid=1000,utf8,dmask=027,fmask=137
sudo mount -t ext4 /dev/sdb1 /media/nathaniel/external/ -o uid=1000,gid=1000,utf8,dmask=027,fmask=137
# Can get errors like this:
#mount: wrong fs type, bad option, bad superblock on /dev/sdb1,
#       missing codepage or helper program, or other error
#
#       In some cases useful info is found in syslog - try
#       dmesg -w


# Mount a ram drive
mkdir -p /mnt/ram
mount -t ramfs -o size=20m ramfs /mnt/ram

# Unmount partitions and detach disk
df # to see mounted partitions
df -h # to see human readable sizes
df -T # to see filesystem types

df -B1 | numfmt --header --field 2-4 --to=si

sudo udisks --unmount /dev/sdb1 && sudo udisks --unmount /dev/sdb2 && sudo udisks --detach /dev/sdb

# Unmount a fuse filesystem
fusermount -u /path/to/mount/point

# Get list of recently installed packages
zcat --force /var/log/dpkg.log* | grep "\ install\ " | sort --reverse | less
# Get a list of recently removed packages.
zcat --force /var/log/dpkg.log* | grep "\ remove\ " | sort --reverse | less

# TODO: get list of recently updated packages that works offline.

# Add something to your $PATH, a colon-separated list of directories.
export PATH=$PATH:$HOME/my-path
PATH=${PATH}:/opt/bin

# See directories in $PATH, one per line.
echo $PATH | tr ':' '\n'
# Process each directory in $PATH using a for loop.
IFS=':'; for dir in $PATH; do printf -- "$dir\n"; done;
# Note the lack of quotes around $PATH to ensure it gets split.
# Fancy version:
printf '%s\n' "$PATH" | tr ':' '\n'

# Do the same for manpath(1) (see manpath(5)).
manpath | tr ':' '\n'

# View colored output in less
less --RAW-CONTROL-CHARS
less -R

# Suspend to screensaver and lock screen
xscreensaver-command -lock
# Choose display; normally :0.0 unless you have another x server running.
# See the current one with `echo $DISPLAY`.
xscreensaver-command --lock --display :0.0
# On xfce
xflock4
# For gnome
gnome-screensaver-command --lock

# Turn off power saving.
xset -dpms
# Turn on power saving.
xset dpms
# Turn off screensaver.
xset s off
# Turn on screensaver.

# Do both (e.g. when watching a movie)
xset -dpms; xset s off

# Just use a blank screen for a screenshot.
xset s blank

# Turns off screen after five minutes (300 seconds).
xset s 300 300
# "The length  and period parameters for the screen saver function determines
# how long the server must be inactive for screen saving to activate, and the
# period to change the background pattern to avoid burn in.  The arguments are
# specified in seconds.  If only one numerical parameter is given, it will be
# used for the length."

# See all keybindings
bind -p | less
bind -P | grep 'can be' | less

# List a user's crontab
crontab -u username -l | less
# List your crontab
crontab -u $USER -l | less

# Temporarily stopping /usr/sbin/cron process.
sudo /etc/init.d/cron stop
# Restart it.
sudo /etc/init.d/cron start
# TODO: why is this not called crond?

# List your incrontab
incrontab -u $USER -l
# if you get this:
# user 'nathaniel' is not allowed to use incron
# fix it manually with
sudo vim /etc/incron.allow
# or in one command with:
echo "$USER" | sudo tee -a /etc/incron.allow
echo "$USER" | sudo tee --append /etc/incron.allow
# ignore stdout.
echo "$USER" | sudo tee -a /etc/incron.allow > /dev/null
# or use a here-file:
sudo tee -a /etc/incron.allow <<< $USER
sudo tee --append /etc/incron.allow <<< $USER

# This is apparently how to solve your XFCE problems
rm -rf ~/.cache/sessions

# Change all spaces in file names into underscores
rename 's/\ /_/g' *

# Rename files by removing spaces entirely.
rename 's/ //g' *

# Remove asterisks from filenames in current directory.
rename 's/\*//g' ./*

# Recursively remove asterisks from filenames.
find . -name '*\**' -print -exec rename -n 's/\*//g' '{}' \;
find . -name '*\**' -exec rename 's/\*//g' '{}' \;

# Remove some illegal characters on Windows.
rename 'y/ *"<>:\\|?/_/' ./*
# Do it recursively.
find . -name '*[\*"><?:\\|]*' -print -exec rename -n 's/[\*"><\?:|]//g' '{}' \;
find . -name '*[\*"><?:\\|]*' -exec rename 's/[\*"><\?:|]//g' '{}' \;

# Change all spaces in file names into underscores, even files with weird names
find . -depth | rename 's/\ /_/g'

# Extract embedded images from a pdf and dump them as JPEGs into the current directory
pdfimages -j mypdf.pdf mypdf-images
# A somewhat neater solution for all pdfs in current directory.
for f in *.pdf; do dir="${f%.*}"; mkdir -p "$dir"; pdfimages -j "$f" "$dir/$dir"; done
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/6c0081a3-5c10-4cdf-826b-1bd778ae8ef0.json

# Show info about pages 1-10 of a PDF.
pdfimages -f 1 -l 10 -list example.pdf | less

# Get the first field of a text file and put it all on one line
cut -f 1 mytext.txt | tr '\n' ' ' | less

# Change a tab-separated file (TSV) to a comma-separated file (CSV) in the most naive fashion possible.
cat in.tsv | tr '\t' ',' > out.csv

# Simple file sharing
# https://web.archive.org/web/20111227004516/http://superuser.com/questions/108394/peer-to-peer-tool-for-file-transfer
# (On sending machine:)
# 1. Navigate to directory of choice.
# 2. Run
python -m SimpleHTTPServer
# or, for python 3.0,
python3 -m http.server 8000
# 3. Find ip address and tell it to receiving machine.
# (On receiving machine)
# 4. In web browser, go to http://IP_OF_SERVER:8000
# 5. Download!

# If you want to know which packages are available, use one of these. Does not require root priveleges.
apt-get --simulate install list_of_packages
aptitude --simulate install list_of_packages # this one also tells you how much space it will require

# Show URIs and MD5sum.
apt-get install --quiet --yes --print-uris 0ad
# 'http://ftp.debian.org/debian/pool/main/0/0ad-data/0ad-data_0.0.17-1_all.deb' 0ad-data_0.0.17-1_all.deb 566073422 MD5Sum:b82e30c2927ed595cabbe8000ebb93b0
# 'http://ftp.debian.org/debian/pool/main/0/0ad-data/0ad-data-common_0.0.17-1_all.deb' 0ad-data-common_0.0.17-1_all.deb 776702 MD5Sum:95e12da902488b00f3813ad352f706ca
# 'http://ftp.debian.org/debian/pool/main/g/gloox/libgloox12_1.0.11-1_amd64.deb' libgloox12_1.0.11-1_amd64.deb 404626 MD5Sum:9978f9fa6141f6b53116a21f750eb230
# 'http://ftp.debian.org/debian/pool/main/m/mozjs24/libmozjs-24-0_24.2.0-2_amd64.deb' libmozjs-24-0_24.2.0-2_amd64.deb 1662902 MD5Sum:7da4ce7f7e48a74029c5127c00d93b05
# 'http://ftp.debian.org/debian/pool/main/n/nvidia-texture-tools/libnvtt2_2.0.8-1+dfsg-5+b1_amd64.deb' libnvtt2_2.0.8-1+dfsg-5+b1_amd64.deb 118260 MD5Sum:df53028977383ddec6981325eb742d56
# 'http://ftp.debian.org/debian/pool/main/0/0ad/0ad_0.0.17-1_amd64.deb' 0ad_0.0.17-1_amd64.deb 2862930 MD5Sum:8b679b5afa15afc1de5b2faee1892faa

apt-get download --print-uris php5-imagick
# 'http://ftp.debian.org/debian/pool/main/p/php-imagick/php5-imagick_3.2.0~rc1-1_amd64.deb' php5-imagick_3.2.0~rc1-1_amd64.deb 100534 SHA256:c01825bb5190466e94e1ddae0ae6d5a54d796b89fb6ca3b0fe428e39c75c4fff

# Get just the URI.
apt-get download --print-uris php5-imagick | cut -d' ' -f1 | sed -e 's/^.//' -e 's/.$//'
# http://ftp.debian.org/debian/pool/main/p/php-imagick/php5-imagick_3.2.0~rc1-1_amd64.deb

# If you want to get the source code for a package, run this. It does not require root priveleges.
apt-get source <package-name>
# If you want to build it from source, do this:
sudo apt-get build-dep <package-name>
apt-get -b source <package-name>
# Alternatives that do the same thing:
# apt-get --build source <package-name>
# apt-get --compile source <package-name>

# TODO: does this work?
DEB_BUILD_OPTIONS=nostrip,noopt apt-get source -b <package-name>

# If you have the sources from other repos available,
# you can download and try to build those instead.
apt-get -b source zotero-standalone/unstable

# If you just want to see what packages are required to build from source:
apt-cache showsrc coreutils  | grep 'Build-Depends:'

# If you're having problems building from source:
auto-apt run ./configure

# Install
./install

# Strip out comment lines (lines starting with #, i.e. '^#') and blank lines (i.e. '^$')
grep -v '^#\|^$' file.sh
# Include optional whitespace before comment character.
grep -v '^\s*#\|^$' file.sh
# Note that this does not match comments that occur on the same line as the source code.
# Filter out comments.
grep '^[^#]' /etc/sysctl.conf
grep -v '^#' /etc/sysctl.conf
grep -v '^$\|^#' /etc/sysctl.conf
grep -Ev '^$|^#' /etc/sysctl.conf
grep -v '^$\|^\s*\#' /etc/sysctl.conf
grep -v "^\($\|#\)" /etc/sysctl.conf
# http://www.linuxjournal.com/content/tech-tip-view-config-files-without-comments
# http://www.commandlinefu.com/commands/view/841/output-files-without-comments-or-empty-lines

# Find files with "pattern1" OR "pattern2".
grep -rl "pattern1\|pattern2"
# Find files with "pattern1" AND "pattern2".
find . -type f  -exec grep -lZ "pattern1" {} + | xargs -r0 grep -l "pattern2"
# https://unix.stackexchange.com/questions/68138/use-grep-to-find-all-files-in-a-directory-with-two-strings
# https://unix.stackexchange.com/questions/67794/how-to-search-files-where-two-different-words-exist

# Copy hidden files (dotfiles)
cp -r test/.[a-zA-Z0-9]* target_directory

# Find all symbolic links in a folder
find ~/Dropbox -type l -ls

# Find all symbolic links in a folder to a folder
find ~/Dropbox/ -lname '*Dropbox*'

# Find all filenames with unicode characters.
LC_ALL=C find . -name '*[![:print:]]*' | visit_paths.py

# Find all directories with a name including 'Link'. These are suspicious characters Dropbox has dereferenced into directories instead of symbolic links.
find ~/Dropbox -type d -name '*Link*'

# Make a symbolic link at ~/bin/expgui to a file called "expgui" in current directory.
# Properly handles spaces in path to current directory by quoting.
ln --symbolic "$PWD/expgui" ~/bin/expgui
ln --symbolic "$(pwd)/expgui" ~/bin/expgui

# Make a symbolic link with spaces in the name of the link.
ln -s ~/.gnupg/ "~/symbolic links/Link to .gnupg"
# Overwrite a symbolic link using --force flag.
ln --symbolic --force ~/source/ ~/target/overwritten-link

# Change all text files with 'apt-get' in the name to 'package'
rename 's/apt-get/package/' *.txt

# See what drives are mounted
less /etc/mtab

# Unmount a drive (use the directory it's mounted at, not /dev/)
umount /media/SMALLBEANS

# Move files in a directory up one
mv */* ./

# Move files in current directory to parent directory
# Note: using cp or rsync is all well and good for this, too, but what if the files are huge? mv can move directories without copying files.
mv -- * .[^.]* ..
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/510c302e-fb2b-4a2a-898f-b98ba0326453.json

# Re-encode a file to play on a standard device, e.g. Sony Bravia TV
ffmpeg -i sintel.m4v -target ntsc-dvd output.mpg

# Do it for every file, and run on three processors (if it's compiled to support multithreading)
for f in *.m4v; do ffmpeg -threads 3 -i $f -target ntsc-dvd $(basename $f .m5v).mpg; done
# Do it for a big TV, and run it on 4 processors
for f in *.m4v; do ffmpeg -threads 4 -i $f -s wxga -vcodec mpeg1video $(basename $f .m4v).mpg; done

# Run handbrake from the commandline to do much the same thing, but for an .iso disk image
HandBrakeCLI -Z "High Profile" -i a_movie.iso -o a_movie.mp4
# http://superuser.com/questions/329349/how-do-i-convert-iso-to-mp4-without-mounting-with-ffmpeg

# Count number of files in working directory, recursively
find . -type f | wc -l
# Ignore hidden files and files in hidden directories.
find . -type f -not -path '*/\.*' | wc -l

# Find filenames without a period in them.
find . -type f -not -name '*\.*' | less

# Set up an ad-hoc wireless network between two linux machines
# http://unixlab.blogspot.com/2010/01/setting-up-ad-hoc-wireless-network.html
# On machine A
ifconfig wlan0 down
iwconfig  wlan0 channel 4
iwconfig  wlan0 mode ad-hoc
iwconfig  wlan0 essid 'fermilevel'
iwconfig  wlan0 key 1234567890
ifconfig  wlan0 192.168.1.1
# on machine B
ifconfig wlan0 down
iwconfig  wlan0 channel 4
iwconfig  wlan0 mode ad-hoc
iwconfig  wlan0 essid 'fermilevel'
iwconfig  wlan0 key 1234567890
ifconfig  wlan0 192.168.1.2

# See what the frequency of the wifi card is.
iwconfig wlan0 | grep Frequency

rfkill list
# 0: phy0: Wireless LAN
# 	Soft blocked: no
# 	Hard blocked: no
# 3: hci0: Bluetooth
# 	Soft blocked: no
# 	Hard blocked: no


#
sudo iwlist wlan0 scan | less

# Check what channel nearby wifi is using
# to change router and reduce interference.
sudo iwlist wlan0 scan | grep Channel
# https://www.reddit.com/r/LifeProTips/comments/4jcp2o/lpt_download_wifi_analyzer_to_determine_what/

# See supported frequencies for wifi card (e.g. is it 2.4 Ghz or 5 GHz?)
iwlist wlan0 freq

# Search for a particular process by name.
ps u -C duplicity

# Add upp memory usage by name.
printf '%s%%\n' $(ps -C chromium --no-headers -o pmem | paste -sd+ | bc)

printf '%s%%\n' $(ps -C chromium --no-headers -o pmem | paste -sd+ | bc)

# Recently installed packages.
zcat -f /var/log/dpkg.log* | grep "\ install\ " | sort | tail
# Full list of recently installed packages.
zcat -f /var/log/dpkg.log* | grep "\ install\ " | sort -r | less

# Search for all directories containing 'doc' in /usr/share except the ones in /usr/share/doc
find /usr/share/ -path /usr/share/doc -prune -o -type d -name '*doc*' -print

# Get an Artist - Song output from an m3u playlist
grep EXT playlist.m3u | cut -d, -f 2 | less

# Find out which shell session you're using
ps -p $$
# Find out the process of the shell.
echo $$
# Same as above except for subshells.
echo $BASHPID

# Show full-format listing, including parent process id of a process (PPID).
ps -f 29478
# Show full-format listing if all you know is part of the name.
ps -f $(pgrep SpiderOak)
# Note: this searches by invoked name,
# not actual executable, so if you ran "editor myfile.txt",
# you have to run
pgrep editor
# not "pgrep vim" or "pgrep emacs".
# Similarly,
pgrep x-www-browser
# not "pgrep firefox" or "pgrep chromium".
# Unfortunately, only the proc/$PID/exe can tell you that.

ps --sort=-size -Fp $(pgrep dbus-daemon)
ps --sort=-rss -Fp $(pgrep dbus-daemon)

ps --sort=-rss -o pid,cmd,rss -fp $(pgrep bash)

# Compress and tar a directory called 'meansum'
tar -czvf meansum.tgz meansum/
tar --create --gzip --verbose --file meansum.tgz meansum/

# The reddit disapproval face
ಠ_ಠ
# Requires debian package fonts-knda
# https://tracker.debian.org/pkg/fonts-knda
unicode ಠ
# U+0CA0 KANNADA LETTER TTHA
# UTF-8: e0 b2 a0  UTF-16BE: 0ca0  Decimal: &#3232;
Ctrl-Shift-U 0ca0 <Enter> # Insert ಠ

# Find out which fonts support a particular glyph.
# https://askubuntu.com/questions/368121/list-of-installed-fonts-that-support-a-certain-character
hb-shape /usr/share/fonts/truetype/lohit-kannada/Lohit-Kannada.ttf ಠ
# [U0CA0=0+645]
hb-shape /usr/share/root/fonts/FreeSans.ttf ಠ
# [.notdef=0+819]

# Related:
# https://stackoverflow.com/questions/4458696/finding-out-what-characters-a-font-supports

# List only directories.
ls -d1 */
# https://www.reddit.com/r/bash/comments/2z4rzo/why_ls_d_and_not_ls_d/

# Show full path of all folders and files in current directory.
ls -d1 "$PWD"/*
# or, if you want to include the directory as well:
find "$PWD"/ -maxdepth 1
# Note: does not resolve symlinks.
# This does.
readlink -f -- *
readlink --canonicalize -- *

# Directories only.
ls -d1 "$PWD"/*

# Use a text file as a command line argument
w3m $(<temp.txt)

# Get the fonts used by a pdf; useful to determine if it's OCR'ed or not,
# and also if the fonts are embedded or not.
pdffonts file.pdf

# Get only the fonts from the first page. If it's not OCR'ed, the output will be this: [none]
pdffonts -l 1 *.pdf | tail -n +3 | cut -d' ' -f1 | sort | uniq
find . -type f -name "*.pdf" -print -exec pdffonts -l 1 '{}' ';' | less

# Check if fonts are embedded or not.
pdffonts myfile.pdf | tail -n +3 | cut -b 73-75

# Get return (error) value of last command.
echo $?
# Get return (error) values of all commands from last pipeline.
echo ${PIPESTATUS[@]}

# Annoying KDE problems
# https://bugs.kde.org/show_bug.cgi?id=120421
killall korgac

# Get random 6 digit number
echo $RANDOM

#
od -vAn -N4 -tu4 < /dev/urandom
od -An -N2 -i /dev/random
# http://www.cyberciti.biz/faq/bash-shell-script-generating-random-numbers/

# X over SSH
ssh -X nbeaver@rontgen.phys.iit.edu

# Execute a graphical program over SSH (in this case, gedit)
dbus-launch gedit

# If you're using vnc over a slow connection, this is far better than X over SSH.
vncviewer -compresslevel 9 -via iit@id1.mr.aps.anl.gov 164.54.244.13
# For really crummy connections, reduce the quality.
vncviewer -compresslevel 9 -quality 0 -via iit@id1.mr.aps.anl.gov 164.54.244.13

# One way to check iowait,
# although this isn't very useful on multicore systems.
# http://www.linuxquestions.org/questions/linux-server-73/what-is-iowait-exactly-623450/
mpstat

# See disk activity without being root.
# Another way to check iowait.
iostat
# Show with extended statistics in kilobytes per second with device utilization info and omit devices unused,
# repeating every second.
iostat -xkdz 1
# -x     Display extended statistics.
# -k     Display statistics in kilobytes per second.
# -d     Display the device utilization report.
# -z     Tell iostat to omit output for any devices for which there was no activity during the sample period.

# Show mounted drives in near little table
mount | column -t
# Pipe to less for easier reading.
mount | column -t | less -S

# Show packages and Debian version numbers in neat columsn.
dpkg-query --show | column -t | less

# From column(1) man page.
(printf "PERM LINKS OWNER GROUP SIZE MONTH DAY HH:MM/YEAR NAME\n"; ls -l | sed 1d) | column -t
# PERM        LINKS  OWNER  GROUP  SIZE   MONTH  DAY  HH:MM/YEAR  NAME
# drwxr-xr-x  2      root   root   4096   Apr    9    15:18       bin
# drwxr-xr-x  3      root   root   4096   Apr    10   10:14       boot
# drwxr-xr-x  20     root   root   3480   May    12   09:35       dev
# drwxr-xr-x  223    root   root   16384  May    12   13:07       etc
# drwxr-xr-x  4      root   root   4096   May    9    17:22       home
# lrwxrwxrwx  1      root   root   31     Apr    8    13:06       initrd.img  ->  /boot/initrd.img-3.16.0-4-amd64
# drwxr-xr-x  21     root   root   4096   May    8    08:47       lib
# drwxr-xr-x  2      root   root   4096   Apr    9    14:18       lib32
# drwxr-xr-x  2      root   root   4096   Apr    8    13:07       lib64
# drwxr-xr-x  2      root   root   4096   Apr    2    15:34       live-build
# drwx------  2      root   root   16384  Apr    8    13:06       lost+found
# drwxr-xr-x  4      root   root   4096   Apr    8    13:15       media
# drwxr-xr-x  2      root   root   4096   Apr    2    15:14       mnt
# drwxr-xr-x  4      root   root   4096   May    9    20:52       opt
# dr-xr-xr-x  299    root   root   0      May    8    08:54       proc
# drwx------  9      root   root   4096   May    10   11:42       root
# drwxr-xr-x  36     root   root   1440   May    12   09:41       run
# drwxr-xr-x  2      root   root   12288  Apr    9    14:49       sbin
# drwxr-xr-x  2      root   root   4096   Apr    2    15:14       srv
# dr-xr-xr-x  13     root   root   0      May    8    08:54       sys
# drwxrwxrwt  34     root   root   4096   May    12   13:25       tmp
# drwxr-xr-x  13     root   root   4096   Apr    9    14:51       usr
# drwxr-xr-x  12     root   root   4096   Apr    9    13:36       var
# lrwxrwxrwx  1      root   root   27     Apr    8    13:09       vmlinuz     ->  boot/vmlinuz-3.16.0-4-amd64



# Kill stopped jobs
kill $(jobs -ps)
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/dbadb0c9-5590-46af-b846-095c44a66e2c.json

# Use a string as if it were a file.
# Note that it adds a newline at the end.
# This construction is called a here-string.
cat <<< 'HI'
md5sum <<< 'This is only a test.'
# b9fdcb35dba569b1ca651f2b243b5144  -
cksum <<< 'This is only a test.'
# 2744897339 21
# Give length in bytes and CRC-32 checksum.
# http://git.savannah.gnu.org/cgit/coreutils.git/tree/src/cksum.c
# Although this is not necessary because these commands can read stdin, too.
printf  'HI\n' | cat
printf 'This is only a test.\n' | md5sum
# b9fdcb35dba569b1ca651f2b243b5144  -
printf 'This is only a test.\n' | cksum
# 2744897339 21
# Python version.
import binascii
binascii.crc32("This is only a test.\n")
# 828642827
import hashlib
hashlib.md5("This is only a test.\n").hexdigest()
# 'b9fdcb35dba569b1ca651f2b243b5144'

# From here: http://mmb.pcb.ub.es/~carlesfe/unix/tricks.txt
# let people in your group access folders without messing up file permissions (never do 'chmod g+x * -R'!)
find . -type d -exec chmod g+x {} \;

# Run a command 5 minutes later
echo "echo blah" | at now + 5 minutes
# or
at now + 5 minutes
# warning: commands will be executed using /bin/sh
# at> echo "Done"
# Use Ctrl-D to finish.
# at> <EOT>
# See 'at' commands
atq
# Remove at commands
atrm

# Reminder to go to bed at 10:30pm
echo  "DISPLAY=$DISPLAY xmessage Go to bed\!" | at 22:30

# Editing text file 'in place' (i.e. without having to make the temp file on your own)
# https://unix.stackexchange.com/questions/11067/is-there-a-way-to-modify-a-file-in-place
# Remove all lines containing foo:
sed --in-place '/foo/d' myfile
# Keep all lines containing foo but remove the lines that don't:
sed --in-place '/foo/!d' myfile
# Make a backup of file while sed is working on it (makes a file called hello.txt.bak)
sed --in-place=.bak --expression='s/hello/jello/' hello.txt

# Remove lines like these:
#1451597860
# but retain a backup just in case.
sed -i'.bak' '/^#[0-9]\+/d;' .bash_history

# Remove byte order mark (BOM).
sed -i '1 s/^\xef\xbb\xbf//' *.txt
# https://stackoverflow.com/questions/1068650/using-awk-to-remove-the-byte-order-mark
# http://stackoverflow.com/a/3622153/1608986
# Note: idempotent.

# Add newline to a file if it doesn't have it already (idempotent).
sed -i -e '$a\' file
# https://unix.stackexchange.com/questions/31947/how-to-add-a-newline-to-the-end-of-a-file

# Get a numbered list of headers in from the 1st line of a csv file.
sed 's/,/\n/g;q' file.csv | nl
# http://www.commandlinefu.com/commands/view/14647/printout-a-list-of-field-numbers-from-a-csv-file-with-headers-as-first-line.

# Do the same, but for the 4th line (in case there are other headers).
sed -n '4{s/,/\n/g;p;q}' file.csv | nl
# Explanation:
# suppress default printing with -n,
# global (g) sed substitution (s) on the 4th line,
# print (p) the resulting output,
# and then quit (q).

# See all lines between two patterns.
sed -n '/StartPattern/,/EndPattern/p' FileName
# http://www.shellhacks.com/en/Using-SED-and-AWK-to-Print-Lines-Between-Two-Patterns
# https://stackoverflow.com/questions/12443122/using-sed-to-print-between-two-patterns
sed -n '/xenon/,/yak/p' /usr/share/dict/words

# SSH without a password (using ssh keys). You only need to do this once.
ssh-keygen -t rsa
# Use defaults (blank password)
# In my case, public key was saved as ~/.ssh/id_rsa.pub
# Now copy public key to remote computer. I originally used:
scp /home/nathaniel/.ssh/id_rsa.pub nbeaver@chloride.phys.iit.edu:~/.ssh/authorized_keys
# This will overwrite the file authorized_keys, so only do this if it doesn't already exist.
# There is actually a builtin command to do this sensibly (surprise, surprise!):
ssh-copy-id -i ~/.ssh/id_rsa.pub nbeaver@chloride.phys.iit.edu

for keyfile in ~/.ssh/id_*; do ssh-keygen -l -f "${keyfile}"; done | uniq
# https://blog.g3rt.nl/upgrade-your-ssh-keys.html

# How to tell if someone is ssh'ed into this machine:
last
# Or
ps aux | grep ssh
# Example:
# nbeaver   7395  0.0  0.0   4756   572 ?        Ss   Oct18   0:00 /usr/bin/ssh-agent /usr/bin/dbus-launch --exit-with-session x-session-manager
# nbeaver  16870  0.0  0.1   8180  1480 ?        S    22:01   0:00 sshd: nbeaver@pts/1

# Restart the ssh daemon.
sudo /etc/init.d/ssh restart

# Restart the apache web server.
sudo /etc/init.d/apache2 restart
sudo apache2ctl graceful

# If you have System V init installed:
sudo service apache2 restart

# Disable system speaker in X:
xset -b
# Turn off console beeps (system bell) for all programs
xset b off
# Set the beep length to 0 (does the same as turning it off)
setterm -blength 0
# Check if the beep is on or not
xset q | grep bell
# These will still make it possible for the beep to go off,
# e.g. for other users or at the login screen.
# A more thorough way to turn off the system bell:
rmmod pcspkr
# making it permanent
sudo -s
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
# alternately, without becoming superuser:
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf
# I came up with this myself, but I guess I wasn't the first.
# http://pushl.hatenablog.com/entry/2012/12/22/035018
# silent version:
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf > /dev/null

# Show information about a kernel module, including version.
modinfo pcspkr | less

# Instead of this:
sudo su
# do this:
sudo -s
# https://unix.stackexchange.com/questions/132748/sudo-not-preserving-ps1

# From http://overapi.com/linux/
# Run cmd1 then cmd2
cmd1 ; cmd2
# Run cmd2 if cmd1 is successful
cmd1 && cmd2
# Run cmd2 if cmd1 is not successful
cmd1 || cmd2
# Show distribution (version of Linux)
less /etc/issue
lsb_release -a
# Show executable path
echo $PATH
# Run last command starting with abc
!abc
# Print last command starting with abc
!abc:p
# Last argument of previous command
!$
# Last argument of previous command
ALT-.
# All arguments of previous command
!*

# Check video file for errors
# http://606u.dir.bg/avicheck/
ffmpeg -v 5 -i file.avi -f null -
ffmpeg -loglevel 5 -i file.avi -f null -
# Alternative, piping to less.
ffmpeg -v error -i file.avi -f null - 2>&1 | less
ffmpeg -v error -i file.avi -map 0:1 -f null - 2>&1 | less
# https://stackoverflow.com/questions/34077302/quickly-check-the-integrity-of-video-files-inside-a-directory-with-ffmpeg

# Double video volume (256 is unchanged)
# https://superuser.com/questions/31176/increase-volume-of-an-mkv-video-from-linux-terminal
ffmpeg -i vid.mkv -vol 512 -vcodec copy output.mkv
# Split up video into segments
# https://superuser.com/questions/31135/split-mpeg-video-from-command-line
# https://unix.stackexchange.com/questions/1670/how-can-i-use-ffmpeg-to-split-mpeg-video-into-10-minute-chunks-for-youtube-uploa
ffmpeg -i source-file.foo -ss 0 -t 600 -c copy first-10-min.m4v
ffmpeg -i source-file.foo -ss 600 -t 600 -c copy second-10-min.m4v
ffmpeg -i input.mpg -ss 00:00:10 -t 00:00:30 -c copy out1.mpg -ss
# Go all the way to the end.
ffmpeg -i input.mp4 -ss 00:00:10 after-first-10-seconds.mp4

# Get audio file from video
ffmpeg -i myvid.mp4 ./out.mp3
# Get audio from video without re-encoding
# http://www.commandlinefu.com/commands/view/13359/dump-audio-from-video-without-re-encoding.
ffmpeg -i file.ext -acodec copy -vn out.ext

# Convert audio file to mp3
ffmpeg -i in.ext out.mp3
# Somewhat better method (less loss of quality)
ffmpeg -v 5 -y -i input.m4a -acodec libmp3lame -ac 2 -ab 192k output.mp3
# Use a tool designed for it.
faad -o my.wav my.m4a
# Or the lame option. :)
lame -h -b 192 my.wav my.mp3

# Get frames from a video five and a half minutes in for 10 seconds.
ffmpeg -ss 00:5:30 -i tmp.mkv -t 10 '%04d.png'
# Get all frames from a video.
ffmpeg myfile.mkv 'out/%04d.png'

# Convert a sequence of JPEG images into a video running at 3 frames per second.
# Images in jpg/ directory and named like image_0001.jpg, image_0002.jpg, ...
ffmpeg -y -start_number 0 -framerate 3 -i jpg/image%04d.jpg -c:v libx264 -pix_fmt yuv420p out.mp4
# https://unix.stackexchange.com/questions/68770/converting-png-frames-to-video-at-1-fps


# Convert a sequence of JPEG images into a video running at 30 frames per second,
# but duplicate the frames so it's effective framerate is 3 fps.
# Images in jpg/ directory and named like image_0001.jpg, image_0002.jpg, ...
ffmpeg -y -start_number 0 -framerate 3 -i jpg/image%04d.jpg -c:v libx264 -pix_fmt yuv420p -r 30 out.mp4

# Convert a sequence of JPEG images into a video running at 30 frames per second,
# but duplicate the frames so it's effective framerate is 3 fps.
# Images in jpg/ directory and anything ending in `.jpg'.
ffmpeg -y -start_number 0 -framerate 3 -pattern_type glob -i 'jpg/*.jpg' -c:v libx264 -pix_fmt yuv420p -r 30 out.mp4

# See open files in home directory
lsof ~
lsof $HOME

# Start less at the first instance of a pattern
less -p ghemical /var/log/dpkg.log

# Start less at the 100th line.
less +100 /var/log/messages
less +100g /var/log/messages
# Start at 25% of the file.
less +25p /var/log/messages
# Start at the 1000th byte of the file.
less +1000P /var/log/messages
# https://superusersome.wordpress.com/2015/06/08/less-quickly-jump-to-line-number-in-large-file/
# https://superuser.com/questions/113039/less-quickly-jump-to-line-number-in-large-file

# Start less at the bottom of a file
less +G /var/log/dpkg.log
# Unnecessary use of cat.
cat /var/log/dpkg.log | less
# See a file in reverse line number.
tac /var/log/dpkg.log | less
# See a file in reverse columns, but same line order.
rev /var/log/dpkg.log | less

# Determine iso resolution, codec, etc:
ffmpeg -i image.iso
avconv -i image.iso
# mediainfo will only tell you ISO format and file size :(

# Blank the screen temporarily (turn off display, turn off the screen)
xset dpms force standby
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/5b791952-7792-4ca5-bb38-cf622f3cdc8a.json

# /usr/share/man/man3/DPMSSetTimeouts.3.gz
# "The  value  standby is the amount of inactivity time, in seconds, before
# standby mode is invoked. The actual effects of this mode are dependent on the
# characteristics of the monitor and frame buffer card. Standby mode is
# implemented by shutting off the horizontal sync signal, and pulsing the
# vertical  sync  signal.  Standby mode  provides  the  quickest  monitor
# recovery  time.   Note also that many monitors implement this mode identical
# to suspend mode."

# Sleep for a while in case keyboard or mouse activity would wake the screen up again.
sleep 1; xset dpms force standby

xset dpms force off
sleep 1; xset dpms force off
# "The  value  off  is  the  amount of time of inactivity,in seconds, before
# the third and final level of power savings is invoked. Off mode's physical
# and electrical characteristics are implementation defined. In DPMS compliant
# hardware, it is implemented by shutting off both horizontal and vertical sync
# signals,  resulting  in powering  down of the monitor.  Recovery time is
# implementation dependent.  Usually the recovery time is very close to the
# power-up time of the monitor."

# Use less on multiple files
less file1 file2 file3
# While in less:
:n
:p
# Save logfile with less (if it's a stream).
:s
# When getting this: "Cannot edit standard input"
# Pipe it on to vim.
g # top of file
| # pipe
$ # to end of file
vim - # the command to pass it to
# http://unix.itsprite.com/unixpiping-into-less-and-editing-cannot-edit-standard-input-error-workarounds/
# https://unix.stackexchange.com/questions/23304/piping-into-less-and-editing-cannot-edit-standard-input-error-workarounds
# http://unix.stackexchange.com/a/43460

# Bluetooth
blueman-manager

# Change mp3 sample rate of every mp3 file in a directory
mkdir converted
for i in *.mp3; do sox --multi-threaded "$i" -r 44100 "converted/$i"; done
# Make sure you don't try to to change the files in place; they will be trashed.
# Either put them in a another directory, as above, or modify the file name.

cat Sn_Ni3Sn4_nano_02-21-2013.002 | tail -n +18 | column -t | less
tail Sn_Ni3Sn4_nano_02-21-2013.002 -n +18 | column -t | less

# Run through a bunch of text files like cat, but with the filenames visible
tail --lines=+1 *.txt | less

# Get the head and tail of a file.
(head; tail) < /usr/share/dict/words
# https://stackoverflow.com/questions/8624669/unix-head-and-tail-of-file?rq=1

# Diff two man pages by running one into stdout and the other to stderr.
# (Not the same as named pipes, as far as I can tell.)
man chattr > 1; man chmod > 2; diff -u 1 2 | less
# Another method, using process substitution:
diff <(man chattr) <(man chmod)

# Watch a file for changes
tail -f myfile.log
less +F myfile.log
# https://serverfault.com/questions/445899/less-with-update-file-like-functionality

# See unique lines immediately.
tail -f access.log | stdbuf -oL cut -d ' ' -f1 | uniq

# Pause/freeze/halt/stop the terminal output using the shell.
Ctrl-S
# Resume the output.
Ctrl-Q

# Open file using $EDITOR or $VISUAL in less:
v

# Diff gzipped files (diffuse is my favorite graphical diff at the moment).
diffuse <(zcat file1.gzip) <(zcat file2.gzip)
# Uses process substitution.

diffuse ~/.local/share/man/man1/youtube-dl.1 <(zcat /usr/share/man/man1/youtube-dl.1)

# IRC chat command to register nickname
/msg NickServ register [password] email@email-provider.com
# All freenode servers listen on ports:
# 6665, 6666, 6667, 6697 (SSL only), 7000 (SSL only), 7070 (SSL only), 8000, 8001 and 8002
# All GeekShed servers accept standard connections on the following ports:
# 6667, 6660, 6661, 6662, 6663, 6664, 6665, 6666, 6668, 6669, 7029, 7070, 1494, 1755, and 6697 (SSL only).
# IIT filters 6666, 6667, 6668, and 6669, and a lot more. SSL works just dandy, though.
# Start a new channel, e.g. #openkim. Make sure you are registered first.
/join #openkim

# List open network ports and the process that owns them
sudo lsof -i
sudo netstat -lptu
sudo netstat -tulpn
sudo netstat -tuplen
# Check which ports are open on this machine, what states they are in, and what service owns them.
nmap localhost


# Using nmap
# Print a list of target hosts
sudo nmap -sL 216.47.138.* | less
# Skip port scan/'ping scan'/slightly more intrusive than -sL/determines if host is online
nmap -sP 198.37.19.*
nmap -sn 10.10.10.0/24
nmap -sP localhost
nmap -sn localhost
# http://www.linuxforums.org/forum/newbie/51732-see-all-users-currently-lan-2.html
# These can take a while...
# TCP scan, assuming network 192.168.1.0/255.255.255.0.
nmap -T Aggressive -sT 192.168.1.*
# ICMP echo request scan
nmap -T Aggressive -sP 192.168.1.*
# UDP scan
nmap -T Aggressive -sU 192.168.1.*
# Enable OS detection
sudo nmap -O 198.37.20.176
sudo nmap -O ord08s06-in-f7.1e100.net
# From the nmap man page, tells which ports are open, OS, and traceroute
nmap -A -T4 scanme.nmap.org
nmap -A -T4 198.37.20.176

# See local machines on current router.
# -sn means "No port scan"
nmap -sn '192.168.0.*'
# https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network

arp -n
# https://security.stackexchange.com/questions/36198/how-to-find-live-hosts-on-my-network

# See printer status from the command line
lpstat -t

# Determine the process id (PID) by clicking on an open window with the mouse
xprop _NET_WM_PID
# Determine executable related to window
xprop WM_CLASS
# Search for the process number, e.g. 1400
ps -p 1400
#   PID TTY          TIME CMD
# 23594 ?        00:00:00 xclip

# Show more information about the process.
ps -p 23594 -f
# UID        PID  PPID  C STIME TTY          TIME CMD
# nathani+ 23594 23593  0 16:39 ?        00:00:00 xclip -out


ps -p $(xprop _NET_WM_PID | cut -d' ' -f 3)

# Determine more info about a window
xwininfo

# focus an application based on name, e.g. banshee
wmctrl -a banshee
# move that application to the current desktop and focus it
wmctrl -R xload

# Show display you're using (e.g. :0.0)
xdpyinfo | grep 'name of display:'
# Alternative:
echo $DISPLAY

# Suspend the bash shell
# https://unix.stackexchange.com/questions/364401/what-is-the-purpose-of-the-bash-suspend-builtin-command
suspend
# Oh my goodness! How do I get it back?
ps aux | grep bash | less
ps aux | grep 'Ts+' | less
# We want this one:
1000     11004  0.0  0.1  10172  6552 pts/2    Ts+  15:01   0:00 /bin/bash
# 'kill' the process (actually bring it back to life):
kill -SIGCONT 11004
# Maybe `kill(1)` should be called `signal(1)` instead.

# Output multiline strings
echo -e '1\n2'
printf "%d\n%d\n" 1 2
echo '1
> 2'

# Convert fahrenheit to celsius
units --terse 'tempF(212)' 'tempC'
# This also works.
printf 'tempF(212)\ntempC' | units -q

# Load default units file ('') as well as a personal units file (personal units file can access standard units as well as its own).
units -f '' -f ~/Dropbox/projects/units/my-units.dat

# Trying to kill all those blasted error reports from when xscreensaver dies.
killall apport-gtk
# Well, that got rid of the bug reporting windows. But what about those tray notifications that say,
# 'crash reported detected'? You have to click on all of them individualy.
sudo service stop whoopsie # Doesn't help.
sudo vim /etc/default/whoopsie # Changed true to false; didn't help.
killall xfce4-notifyd # Didn't help.
sudo service apport stop # Didn't help.
sudo rm /var/crash/* # This works!
sudo vim /etc/default/apport # This might be even better if the error reporting continues to be annoying.

# Using your very own text editor even if someone's VISUAL is set to something else
# and you don't want to change it.
env VISUAL=pico crontab -e

# Save environment variables to a text file.
env > myenv.txt
# Run a script in that environment.
env - $(cat myenv.txt) /path/to/myscript
# Avoid use of `cat` command:
env - $(< myenv.txt) /path/to/myscript
# https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.html

# Find symlinks to a file. From here:
# https://unix.stackexchange.com/questions/3710/how-do-i-see-what-symlinks-exist-for-a-given-directory
find -L /haystack -xtype l -samefile name-of-file

# Get a listed of sorted email addresses from a text file. From
# https://stackoverflow.com/questions/2898463/using-grep-to-find-all-emails
egrep -o "[^[:space:]]+@[^[:space:]]+" raw.txt | tr -d '<,>' | sort | uniq > sorted-email-list.txt
# This looks good, too: http://www.commandlinefu.com/commands/view/4118/extract-email-adresses-from-some-file-or-any-other-pattern
grep -Eio '([[:alnum:]_.-]+@[[:alnum:]_.-]+?\.[[:alpha:].]{2,6})'

# Find matching lines in all files below and eliminate duplicates.
grep -hr 'mystring' | sort | uniq | less
grep --no-filename --recursive 'mystring' | sort | uniq | less

# Open that network manager connection editor that normally you click on the wifi icon to access.
nm-connection-editor

# Readline wizardry:
alt-shift-8 # (i.e. M-*) put all the matching completions on the line
Ctrl-W # delete preceding word
Alt-D # delete following word
Ctrl-U # delete line
Ctrl-A-K # delete line
Ctrl-XX # move between EOL and current cursor position
Ctrl-Shift-- # Undo
Ctrl-X Ctrl-U # Undo
# There really isn't a redo command.
Ctrl-Y # Paste whatever you last deleted

# See which processes are using disk, i.e. doing I/O.
sudo iotop --only
# Can also use htop, which does not require root.
htop

# See connections in promiscuous mode and turn on port display.
sudo iftop -pP
sudo iftop -pP -i wlan2

# See which processes are using the most bandwidth
sudo nethogs wlan0

# See info pages, but in the 'less' pager. Much nicer.
info gpg | less
info coreutils | less

# Reverse DNS lookup
host 216.47.138.69
# 69.138.47.216.in-addr.arpa domain name pointer chloride.phys.iit.edu.

nslookup 216.47.138.69
# Server:		127.0.0.1
# Address:	127.0.0.1#53
#
# 69.138.47.216.in-addr.arpa	name = chloride.phys.iit.edu.
nslookup debian.org

nslookup 8.8.8.8
#Server:		192.168.1.254
#Address:	192.168.1.254#53
#
#Non-authoritative answer:
#8.8.8.8.IN-ADDR.ARPA	name = google-public-dns-a.google.com.

# Slightly more detailed
host -a 216.47.138.69
dig -x 216.47.138.69
# Also works on domain names
host senfter.debian.org
host example.com

# Just get ip address(es).
dig +short example.com

# Run a trace.
dig +trace w3.org

dig @8.8.8.8 www.google.com

# Show DNS servers.
systemd-resolve --status
resolvectl status
# https://unix.stackexchange.com/questions/328131/how-to-troubleshoot-dns-with-systemd-resolved

# Choose a mirror to download from by comparing speed and latency
sudo netselect -vv debian.uchicago.edu mirror.anl.gov

# Find out upload and download speed.
# Based on speedtest.net.
speedtest-cli

# Alernative method, using the router.
# http://firstin-lastout.com/2013/07/how-to-test-wifi-speed/
iperf -s -u -i1
iperf -c 192.168.2.1 -u -i1 -l 1300 -b 100m -t 600
# Replace 192.168.2.1 with router ip address from route -n.
iperf --client 192.168.2.1 --udp --interval 1 --len 1300 --bandwidth 100m --time 600

# See the ARP (Address Resolution Protocol) table.
arp
/usr/sbin/arp

# See available network interfaces, e.g. wlan, eth
ip link show
netstat -i
/usr/sbin/ifconfig -a
# Just the interface names.
ls -1 /sys/class/net/
netstat -i | tail -n+3 | cut -f 1 -d' '

# Show the default route interface.
route | grep '^default' | awk '{print $NF}'
# List all active route interfaces.
route | tail -n+3 | awk '{print $NF}' | sort | uniq

# Find out your ip address
ifconfig
ip addr show
# or just
ip addr
# Using moreutils
ifdata -pa eth0

# See what an interface can do, e.g. if wakeonlan is enabled
ethtool eth3
sudo /sbin/ethtool eth0

# Wake on LAN using mac address
wakeonlan 00:0d:56:d2:a8:24
wakeonlan -i 216.47.138.69 00:0d:56:d2:a8:24

# You want it to shutdown and you really mean it!
sudo /sbin/poweroff -d -f -h -i -p
# Newer ones use this syntax.
sudo /sbin/poweroff --force --poweroff --verbose
# Or maybe this?
sudo shutdown -h now
sudo init 0
sudo halt
# Rebooting
sudo shutdown -r now
# If you are SSH'd into the machine,
# you will be prompted for the hostname.

# Cancel shutdown.
shutdown -h

# See what the time is anywhere in the world, interactively.
tzselect
# See what the time is in India.
echo -e '5\n14\n1' | tzselect 2>&1 | grep 'Local time' # time in India
echo -e '2\n49\n11\n1' | tzselect 2>&1 | grep 'Local time' # time in Chicago (CST)

# A better way.
export TZ=America/Chicago && date && unset TZ
export TZ=Asia/Kolkata && date && unset TZ
export TZ=Asia/Dhaka && date && unset TZ
# or just
TZ=Asia/Dhaka date
TZ=America/Argentina/Buenos_Aires date
TZ=Asia/Hong_Kong date
# /usr/share/zoneinfo/zone.tab
# http://www.cyberciti.biz/tips/date-command-set-tz-environment-variable.html
# https://unix.stackexchange.com/questions/48101/how-can-i-have-date-output-the-time-from-a-different-timezone
# https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
# http://www.trueelena.org/computers/howto/date_hints_and_tips.html

# What time will it be 10 hours from now in Bangladesh?
export TZ=Asia/Dhaka && date --date='10 hours' && unset TZ
# What time will it be here when it's 10 hours later in Dhaka?
TZ="Asia/Dhaka" date --date='10 hours'
# What time of day will it be in India if it's at a specified Central Standard Time?
TZ=Asia/Kolkata date -d 'Monday, February 24, 2014 9:00am CST' +%r
# What will be the full date?
TZ=Asia/Kolkata date -d 'Monday, February 24, 2014 9:00am CST' +'%A, %B %e, %r'

grep Alaska /usr/share/zoneinfo/zone.tab
# US  +550737-1313435 America/Metlakatla  Pacific Standard Time - Annette Island, Alaska
# US  +611305-1495401 America/Anchorage   Alaska Time
# US  +581807-1342511 America/Juneau  Alaska Time - Alaska panhandle
# US  +571035-1351807 America/Sitka   Alaska Time - southeast Alaska panhandle
# US  +593249-1394338 America/Yakutat Alaska Time - Alaska panhandle neck
# US  +643004-1652423 America/Nome    Alaska Time - west Alaska

# Which day of the week was the stock market crash of October 29, 1929?
date +%A --date="October 29, 1929"
# Tuesday
# This was known as "Black Tuesday".

# Demonstrate the changeover from Julian to Gregorian calendars.
ncal -J -H 1752-09-13 September 1752
ncal -H 1752-09-14 September 1752
# "Wednesday 2 September 1752 was followed by Thursday 14 September 1752."
# https://en.wikipedia.org/wiki/Calendar_%28New_Style%29_Act_1750

# Using the BSD calendar.
cal sept 1752
# https://unix.stackexchange.com/questions/17903/is-cal-broken-what-happened-in-september-1752

# Events and holidays on January 1st, 1970.
calendar -t 19700101

# calendar -t 19691231
# calendar: specified date is outside allowed range

# See if you've got any linux backports installed
apt-cache policy linux-backports-modules-cw-* | grep Installed | uniq

# See options for a virtual package.
apt-cache show awk
# N: Can't select versions from package 'awk' as it is purely virtual
# N: No packages found

# Only shows the options that are already installed.
apt-cache showpkg awk
# Package: awk
# Versions:
#
# Reverse Depends:
#   base-files,awk
# Dependencies:
# Provides:
# Reverse Provides:
# mawk:i386 1.3.3-17
# gawk:i386 1:4.1.1+dfsg-1
# original-awk 2012-12-20-2
# mawk 1.3.3-17
# gawk 1:4.1.1+dfsg-1

aptitude search -F %p '~Pawk'
# cpl-plugin-hawki-calib
# cpl-plugin-hawki-doc
# gawk
# gawk:i386
# mawk
# mawk:i386
# original-awk
# original-awk:i386
# python-tomahawk

aptitude search -F %p '?provides(awk)'
# Problem: it matches everything with the name awk in it.

# Solution:
aptitude search -F %p '?provides(^awk$)'

aptitude search -F %p '?provides(^x-window-manager$)'

# Alternative with apt-cache, though it includes names, too:
apt-cache search --names-only '^awk$'
# gawk - GNU awk, a pattern scanning and processing language
# mawk - a pattern scanning and text processing language
# original-awk - The original awk described in "The AWK Programming Language"

grep-available -F Provides -s Package awk
# Package: original-awk
# Package: mawk
# Package: gawk
# Package: python-tomahawk

apt-cache search --names-only x-terminal-emulator

update-alternatives --display awk
# awk - auto mode
#   link currently points to /usr/bin/gawk
# /usr/bin/gawk - priority 10
#   slave awk.1.gz: /usr/share/man/man1/gawk.1.gz
#   slave nawk: /usr/bin/gawk
#   slave nawk.1.gz: /usr/share/man/man1/gawk.1.gz
# /usr/bin/mawk - priority 5
#   slave awk.1.gz: /usr/share/man/man1/mawk.1.gz
#   slave nawk: /usr/bin/mawk
#   slave nawk.1.gz: /usr/share/man/man1/mawk.1.gz
# Current 'best' version is '/usr/bin/gawk'.

namei "$(which awk)"
# f: /usr/bin/awk
#  d /
#  d usr
#  d bin
#  l awk -> /etc/alternatives/awk
#    d /
#    d etc
#    d alternatives
#    l awk -> /usr/bin/gawk
#      d /
#      d usr
#      d bin
#      - gawk

namei /etc/mtab
#f: /etc/mtab
# d /
# d etc
# l mtab -> ../proc/self/mounts
#   d ..
#   d proc
#   l self -> 8283
#     d 8283
#   - mounts

# Show network connections from the command line
nmcli device status
# Disconnect from eth0
nmcli device disconnect eth0

# List available WiFi access points.
nmcli dev wifi
# Sort available wifi access points by signal strength, strongest at the top
# Have to start with first field, then go 93 characters out, sort numerically, and reverse so largest is at the top.
nmcli dev wifi | sort -k1.93nr
# More robust, cutting out the * at the beginning that marks the current connection and then going to the 6th field,
# which is the signal strength percentage.
nmcli dev wifi | cut -c4- | sort -k6nr | less
# This seems to work better for older version of nmcli.
nmcli dev wifi | sort -k8n | less

# Do a connectivity check.
nmcli networking connectivity check

# Remove files with dashes, e.g. a file called '-'
rm -- -
rm ./-
unlink -
# Difference between rm and unlink:
# https://unix.stackexchange.com/questions/151951/what-is-the-difference-between-rm-and-unlink
# https://serverfault.com/questions/38816/what-is-the-difference-between-unlink-and-rm

# Remove all files without being goofed up by leading dashes.
rm -- *

# Wipe/truncate a file without removing it.
cat /dev/null > /path/to/file
# or
> /path/to/file
# or
: > /path/to/file
# or
printf "" > /path/to/file
# or
true > /path/to/file
# or
truncate --size=0 /path/to/file
# or
truncate -s 0 /path/to/file
# https://superuser.com/questions/849413/why-would-you-cat-dev-null-var-log-messages
# http://www.tech-recipes.com/rx/2993/how_to_empty_or_clear_the_contents_of_an_existing_unix_file/
# http://www.tldp.org/LDP/abs/html/io-redirection.html

# Kill an unresponsive SSH session
# http://www.cyberciti.biz/faq/openssh-linux-unix-osx-kill-hung-ssh-session/
<Enter> ~ .

# Escape latex special characters (reserved characters)
echo "55% increase" | pandoc -t latex
# 55\% increase
echo '~ # $ % ^ & _ { } < > \ |' | pandoc -t latex
# \textasciitilde{} \# \$ \% \^{} \& \_ \{ \} \textless{} \textgreater{} ~\textbar{}
echo '~ # $ % ^ & _ { } < > \ |' | pandoc -t latex --listings
# \textasciitilde{} \# \$ \% \^{} \& \_ \{ \} \textless{} \textgreater{} ~\textbar{}

# Convert files using pandoc, e.g. markdown to latex
pandoc -f markdown -t latex myfile.markdown  > myfile.tex
# Convert big files using pandoc.
pandoc +RTS -K64M -RTS -f markdown -t latex big.md -o big.tex
# For this error message (error code 2):
#     Stack space overflow: current size 16777216 bytes.
#     Use `+RTS -Ksize -RTS' to increase it.

# Check if advanced globbing patterns are on
shopt extglob
# Turn them on
shopt -s extglob

# Note on using mv command:
mv folder1/ folder2
# is different from
mv folder1 folder2
# TODO: how is it different? What about this?
mv folder1 folder2/

# Move all but one of a file
# https://stackoverflow.com/questions/670460/move-all-files-except-one
mv ~/Linux/Old/!(Tux.png) ~/Linux/New/

# All files in /usr/share/applications/ that aren't desktop files.
echo /usr/share/applications/!(*.desktop)

# Get current beamline status at APS
w3m 'http://www.aps.anl.gov/aod/blops/status/srStatus.html' | grep "Operations Status"

# Insert all possible completions (readline completion trick)
<Alt><Shift>8 # i.e. M-*

# More readline stuff
C-x C-u # undo
M-f # forward one word. M is meta, i.e. alt key.
M-b # back one word. M is meta, i.e. alt key.

# Put this in .inputrc for menu completion (like vim, where it cycles through options)
"\C-f": menu-complete

# Fun on the beamline. :)
iit@bm1:~$ w
 21:06:54 up 272 days,  3:11, 10 users,  load average: 0.00, 0.00, 0.04
USER     TTY      FROM              LOGIN@   IDLE   JCPU   PCPU WHAT
segre    tty1                      19Dec12 177days  0.37s  0.35s -bash
kwiatal  tty2                      26Mar13 80days  0.46s  0.39s -bash
katsouda pts/0    :0.0             Thu14    2.00s  2:02   5:18  gnome-terminal
katsouda pts/1    :0.0             14:46    1:02m 13.10s  5:18  gnome-terminal
katsouda pts/4    :0.0             14:46    1:32m 17:04   5:18  gnome-terminal
iit      pts/5    mr116.mr.aps.anl 20:05    0.00s  0.05s  0.01s w
katsouda pts/8    :0.0             14:46    1:03m  0.02s  5:18  gnome-terminal
katsouda pts/7    :0.0             14:46    1:01m  0.02s  5:18  gnome-terminal
iit      pts/11   mr116.mr.aps.anl 19:17    1:33m  0.10s  0.02s pager -s
gu34012  pts/9    mr011.mr.aps.anl 07Jun13  1:08m 22:37  22:36  /opt/mx/bin/mxmotor -F /opt/mx/etc/motor.dat -s /home/gu34012/.mx/bm1_scan.dat
# Tell Razib to open a new terminal while we're waiting for a raster scan to complete and tell me what he sees with 'who am i'.
iit@bm1:~$ who am i
iit      pts/5        2013-06-14 20:05 (mr116.mr.aps.anl.gov)
it@bm1:~$ write katsoudas pts/10
Hello, Razib!
iit@bm1:~$ who am i
iit      pts/5        2013-06-14 20:05 (mr116.mr.aps.anl.gov)
iit@bm1:~$
Message from katsoudas@bm1 on pts/10 at 21:18 ...
Is this some kind of joke
EOF
iit@bm1:~$ ps aux | grep ssh
# Blah blah blah...
iit       6467  0.0  0.0  11640  1608 ?        SN   20:05   0:00 sshd: iit@pts/5
# That's me!

# Display which tty you are on
tty

# Show mtime (modification time, age of data in file, updated by writing to file)
ls -l
# Show ctime (inode change time, updated by writing to file or changing permissions)
ls -lc
# Show atime (access time, updated by reading the file)
ls -lu
# Directory times are updated when a file in them is added, removed or renamed, but not when it is only modified.

# When apt-get is updating and running dpkg, then gets interrupted, use this:
sudo dpkg --configure -a

# See reverse dependecies (which packages depend on a specified package)
apt-cache rdepends gcc
# Limit to those that are installed
apt-cache --installed rdepends gcc
# Do it recursively
apt-cache --installed --recurse rdepends gcc
# Do it recursively and choose which kinds of dependencies to show.
apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances ipython-notebook | grep apache2 | less

# Looks for build-deps (source packages).
grep-dctrl -F Build-Depends autoconf -s Package /var/lib/apt/lists/*Sources
grep-dctrl -F Build-Depends cmake -s Package /var/lib/apt/lists/*Sources

# Show why a package is installed.
aptitude why apache2
aptitude why coreutils

lspci -nnk | grep -A3 "Network controller"

# The venerable finger command
finger iit
# iit@bm1:~$ finger iit
# Login: iit            			Name: IIT General Usage Account
# Directory: /home/iit                	Shell: /bin/bash
# Office: IIT - MRCAT, 630.252.1710 -
# On since Tue Jun 18 18:35 (CDT) on pts/0 from 107-210-253-34.lightspeed.cicril.sbcglobal.net
# No mail.
# No Plan.
# Find out who you are (username)

whoami
# Find out if you have root (sudoing) privileges
sudo -v
# or
groups | grep sudo
# Find out what you can do if you have sudo privileges
sudo -l

# Find out your full name.
getent passwd "$USER" | cut -d ':' -f 5

# Change your full name.
chfn -f "Joe Blow" jblow

# Find out host information, including FQDN, etc.
getent hosts
# Example output:
# nbeaver@chloride:~$ getent hosts
# 127.0.0.1       chloride localhost.localdomain localhost
# 127.0.1.1       chloride.phys.iit.edu chloride.phys.iit.edu
# 216.47.138.69   monarch.spinlock.hr krb.spinlock.hr ldap.spinlock.hr monarch krb ldap
# 127.0.0.1       ip6-localhost ip6-loopback

# Find out what your hostname is.
hostname
uname -n
# Find out more.
hostname -f
# nbeaver@omega:~$ hostname -f
# omega.cs.iit.edu
# nbeaver@chloride:~$ hostname -f
# chloride

dnsdomainname
# nbeaver@omega:~$ dnsdomainname
# cs.iit.edu
# nbeaver@chloride:~$ dnsdomainname
# nbeaver@chloride:~$

# Numeric ip address.
hostname -i
# nbeaver@omega:~$ hostname -i
# 216.47.152.135

# Find words in the dictionary starting with certain letters
look xa

# Convert an image from a pdf to one that LaTeX can work with, a png
pnmtopng park-2009-synthesis.ppm > park-2009-synthesis.png

# Copy some text to clipboard
echo "Hi" | xsel --clipboard
echo "Hi" | xsel -b
# Append some text to clipboard
echo "Hi" | xsel
# Clear xsel clipboard
xsel -c -p; xsel -c -s; xsel -c -b;

# Pipeline with clipboard.
xsel -bo | base64 | xsel -b

# Copy working directory to clipboard
pwd | xsel -b
# Copy working directory to clipboard, no trailing newline
pwd | tr -d '\n' | xsel -b
# Alternative method; shell-dependent (non-portable)
echo -n $(pwd) | xsel -b
echo -n "$PWD" | xsel -b
# Yet another method, robust against oddly named directories.
printf "%s" "$PWD" | xsel --clipboard
printf -- "$PWD" | xsel --clipboard

# Copy current directory without the full path or trailing newline.
printf -- "$(basename "$PWD")" | xsel --clipboard
# Avoid use of basename.
printf -- "${PWD##*/}" | xsel --clipboard
# https://stackoverflow.com/questions/1371261/get-current-directory-name-without-full-path-in-bash-script

# Copy a file to the clipboard.
cat file.txt | xsel -b
xclip file.txt

# Copy SSH public key to clipboard with xclip.
xclip -sel clip < ~/.ssh/id_rsa.pub

# After copying an image to the clipboard,
# save it to a file with xclip.
xclip -selection clipboard -t image/png -o > out.png
# Requires xclip 81 or later.
# Sometimes works with image/jpeg (acroread snapshots), sometimes not (gnuplot wxt).
# Have not seen it work with image/tiff yet.
# https://unix.stackexchange.com/questions/145131/copy-image-from-clipboard-to-file
# http://ubuntuforums.org/showthread.php?t=1335075
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/5a413ea5-d4f0-46d9-b7c8-b7170a74b847.json

# Lookup information about a website or ip address
whois iit.edu

# Remove newlines, trailing and otherwise
tr -d '\n'

# Find trailing whitespace.
grep -r '\s$'

# Remove trailing whitespace in place.
sed -i 's/[ \t]*$//' file.txt

# Get the last entry in history
history |
	tail -n2 | # Get last two entries.
	head -n1 | # Get second to last entry, since this command will be the last entry.
	cut -c 8-  # The first 8 characters of the history file are the command number, e.g. "42893  ls"

# Get the 2nd line of a bunch of files.
awk 'FNR==2' * > out.txt

# Rsync is pretty awesome.
sudo rsync --verbose --progress --archive --compress --rsh ssh --rsync-path="sudo rsync" /var/www/pmwiki nbeaver@chloride.phys.iit.edu:/var/www/

# Access stuff like bluetooth settings if you can't remember how to launch it graphically.
gnome-control-center network

# List bluetooth devices.
hciconfig

# Cool use of the find command: http://www.tuxradar.com/content/command-line-tricks-smart-geeks
# Find all files in home directory modified or created today.
find ~ -type f -mtime 0
# If you know it's an mp3...
find ~ -type f -mtime 0 -iname '*.mp3'

# Find all files modified in the last 15 minutes.
find . -type f -mmin -15

# Find most recently modified files. (Assumes no newlines in filename.)
find . -printf "%T@ %Tc %p\n" | sort -n | less
find -type f -printf '%T+ %p\n' | sort | less

# Find most recently modified files, list only path to file. (Assumes no newlines in filename.)
find . -printf "%T@\t%p\n" | sort -n | cut -f '2-'

# Find oldest file in directory tree.
find -type f -printf '%T+ %p\n' | sort | head -n 1

# Find files in your home directory that you don't own
find $HOME ! -user $USER
# https://stackoverflow.com/questions/5927489/looking-for-files-not-owned-by-someone
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/2b0656bc-9ea5-466b-8734-dcc1570be067.json

# Install from source, but turn it into a debian package first
./configure && make && checkinstall

# Run make in parallel (e.g. on four cores).
make --jobs 4

# Show the real directory of a symlinked one
pwd -P
# Move to real directory
cd -- "$(pwd -P)"

# Display a quick message
xmessage "You are late"
xmessage -display :0.0 "You are late"
xmessage -display $DISPLAY "You are late"

# Take a screenshot remotely.
DISPLAY=:0 import -window root screenshot.png

# Morse code!
echo "Hello" | morse -s | tr -d '\n'
echo ' .... . .-.. .-.. ---  ...-.-' | morse -d

# What's taking up space on your home directory?
# Sort numerically in KB (1024 bytes).
du -d 1 ~ | sort -nr | less
du --max-depth=1 $HOME | sort --reverse --human-numeric-sort | less
# Sort human-based, e.g. 250MB, 10KB, etc.
du -hd 1 ~ | sort -hr | less
du --human --max-depth=1 $HOME | sort --reverse --human-numeric-sort | less
# https://serverfault.com/questions/62411/how-can-i-sort-du-h-output-by-size
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/64c52fa6-cdde-4e8b-9671-1b74978cdc2c.json

# Suspend the computer to RAM and wake up 60 seconds later
sudo rtcwake -m mem -s 60
# Don't suspend, just shchedule a wakeup 60 seconds later
sudo rtcwake -m no -s 60
# requires util-linux package

# If your package manager gives you trouble, don't bother swearing, just reinstall!
sudo apt-get --reinstall --purge install flashplugin-installer

# Or if the package is fixed in a newer version:
sudo apt-get update
sudo apt-get --fix-broken install
# Then, if you have problems:
sudo dpkg --configure -a
# And run apt-get -f install again.
# Yes, this is a bit ridiculous.

# Update the flash plugin, since Debian can't legally package it.
sudo update-flashplugin-nonfree --install

# Browse gopher with lynx
lynx gopher://gopher.floodgap.com/1/world

# TODO: Get html with lynx.

# Link to USPS package tracking for three packages
https://tools.usps.com/go/TrackConfirmAction.action?tLabels=23063250000076469472,23063250000076469489,VH642248316US

# Mute master sound
amixer set Master mute
# Unmute master sound
amixer set Master unmute
# Set master to 50%.
amixer set Master 50
# http://www.tldp.org/HOWTO/Alsa-sound-6.html
# http://www.linuxjournal.com/content/change-volume-bash-script

# See master settings.
amixer get Master

# List only dotfiles, including `.' and `..'.
ls -a | grep '^\.'
ls -d .*
# List only dotfiles.
echo .[^.]*
find .  -mindepth 1 -maxdepth 1 -name '.*'
# List only hidden directories.
find .  -mindepth 1 -maxdepth 1 -name '.*' -type d
# List only hidden files.
find .  -mindepth 1 -maxdepth 1 -name '.*' -type f
# These don't work for hidden files like .a
ls -d .??*
echo .??*
# https://stackoverflow.com/questions/22408455/how-to-list-only-the-dot-files-and-dot-folder-names-without-the-content-in-them
# https://stackoverflow.com/questions/698764/use-rsync-to-copy-only-hidden-files
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/924d5f3a-512b-4c0e-8219-6a47002d9014.json

# Graphically change timezone
time-admin
# From the command-line
sudo dpkg-reconfigure tzdata

# List timezones
timedatectl list-timezones
# Set timezone with systemd.
timedatectl set-timezone America/New_York

# See current timezone
timedatectl status
cat /etc/timezone
date +%Z

# Combine/merge/join/concatenate pdf files together
pdfjoin 1.pdf 2.pdf  # creates a 2-join.pdf file with both 1 and 2.
pdfunite 1.pdf 2.pdf 1-and-2.pdf # creates a 1-and-2.pdf file with both 1 and 2.
pdftk *.pdf cat output onelargepdfile.pdf
# Change the order of pages of a pdf.
pdftk in.pdf cat 5-12 1-4 output out.pdf
# Insert pages into a pdf
pdftk A=missing15-16.pdf B=pg15-16.pdf cat A1-14 B A15-end output manual.pdf
# Insert pages in whatever order necessary into a pdf
pdftk A=missing15-16.pdf B=pg15-16.pdf cat A1-14 B2 B1 A15-end output manual.pdf
# Not sure if these work on an encrypted pdf:
# https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf

# Combine/merge/join/concatenate pdf files together in numerical order of filename,
# instead of alphanumeric order. Uses evil parsing of ls, which is a bad idea.
# http://mywiki.wooledge.org/ParsingLs
# Sorry.
pdfjoin $(ls -v)

# Splitting pdfs.
# Get only a single page (number 17 in this case).
pdftk myoldfile.pdf cat 17 output mynewfile.pdf
# Get a range of pages (10 through 12 and 17 to the end in this case).
pdftk myoldfile.pdf cat 10-12 17-end output mynewfile.pdf
# Get all but a single page (number 17 in this case).
pdftk myoldfile.pdf cat '~17' output mynewfile.pdf
# http://linuxcommando.blogspot.com/2013/02/splitting-up-is-easy-for-pdf-file.html
gs -sDEVICE=pdfwrite -dNOPAUSE -dBATCH -dSAFER -dFirstPage=1 -dLastPage=4 -sOutputFile=outputT4.pdf T4.pdf
# http://linuxcommando.blogspot.com/2014/01/how-to-split-up-pdf-files-part-2.html
convert file1.pdf[0] file2.pdf[0-1,3] output.pdf
# http://linuxcommando.blogspot.com/2015/03/how-to-merge-or-split-pdf-files-using.html

convert -density 300 temp.pdf out.png


convert -density 600 temp.pdf out.jpeg


# Digitize page 23 of a PDF (pages start from 0).
convert -density 300 temp.pdf[22] out.png

# Downscale a big JPEG to 999kB or less.
convert big.jpg -define jpeg:extent=999kb smaller.jpg

# Convert JPEG to PDF with rotation.
convert -rotate 90 input.jpg out.pdf

# Convert JPEG to PDF and limit page size to letter.
convert -units pixelsperinch -density 72 -page letter input.jpg out.pdf
convert -units pixelsperinch -density 72 -page a4 input.jpg out.pdf
convert -units pixelsperinch -page letter -units PixelsPerInch -density 300x300 -resize 2551x3295 -extent 2551x3295 input.jpg out.pdf
# https://stackoverflow.com/questions/11693137/how-do-i-control-pdf-paper-size-with-imagemagick

# Oh my gosh, I just entered my password in the terminal
# and now it will be in the bash history! What can I do?
unset HISTFILE
# Whew!
# Can also use this:
history -cw
# https://askubuntu.com/questions/625277/terminal-incognito-mode
# Or maybe just change your password.

# Remote desktop into a Windows machine
rdesktop 123.45.678.910
# Remote desktop into a Windows machine, autofill user and graphically prompt for password
rdesktop -u nbeaver 123.45.678.910
# Remote desktop into a Windows machine, autofill user and prompt for password from command line
rdesktop -u nbeaver -p - 123.45.678.910
# Remote desktop with FreeRDP, a remote desktop program with more features
xfreerdp -u nbeaver 123.45.678.910

# VNC into a machine (Windows or Linux) with a VNC server running (TightVNC in this case)
vncviewer dhcp195.wh.iit.edu:5900
# Note that you have to right-click to scroll up or left.
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=617724
# https://bugs.launchpad.net/ubuntu/+source/tightvnc/+bug/111039

# VNC into a Linux server
# First, ssh into the sever and run this (or run it ahead of time)
x11vnc -display :0
# Next, run this on the client.
xvncviewer -via iit@bm1.mr.aps.anl.gov bm1:0
xvncviewer -via nbeaver@chloride.phys.iit.edu chloride:0

# VNC into a Windows computer by running X over ssh through a linux server,
# in case e.g. firewall blocks so you can't even ping the Windows machine.
ssh -X iit@bm1.mr.aps.anl.gov
dbus-launch vncviewer 164.54.244.15:5900
rdesktop -u PTStat -f 164.54.244.15
# me@laptop:~$ ssh -X iit@bm1.mr.aps.anl.gov
# me@remote-server:~$ dbus-launch vncviewer 164.54.244.15:5900
# me@remote-server:~$ rdesktop -u PTStat -f 164.54.244.15

# See cron updates and ssmtp status
less /var/log/syslog
tail -f /var/log/syslog

# See all kinds of system information.
tail -f /var/log/{messages,kern.log,dmesg,Xorg.0.log}
# Log it as well.
tail -f /var/log/{messages,kern.log,dmesg,Xorg.0.log} | tee log.txt

# See attached USB devices
lsusb
# Bus 002 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
# Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
# Bus 001 Device 003: ID 04f2:b221 Chicony Electronics Co., Ltd integrated camera
# Bus 001 Device 002: ID 8087:0024 Intel Corp. Integrated Rate Matching Hub
# Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
# You can tell there is not point in getting a USB 3.0 device for this machine,
# because all the hubs are 2.0. Also, when looking at the physical machine, USB 3 ports are painted blue.

usb-devices
# From usbutils package.
# Reads stuff like /sys/bus/usb/devices/2-1.2/product

# Identify printer model.
sudo escputil -d -r /dev/usb/lp0
# Check printer ink levels.
sudo escputil -i -r /dev/usb/lp0
# Check printer status (including ink levels).
sudo escputil -s -r /dev/usb/lp0
# Run nozzle check.
sudo escputil -n -r /dev/usb/lp0
# Alignment (does not work for me, sadly.)
sudo escputil -a -r /dev/usb/lp0

# Add a ppa (personal package archives)
sudo add-apt-repository 'ppa:ubuntu-mozilla-daily/ppa'
sudo apt-get update
sudo apt-get upgrade

# Remove a ppa.
sudo add-apt-repository --remove 'ppa:ubuntu-mozilla-daily/ppa'
# Another example:
sudo add-apt-repository --remove 'ppa:openscad/releases'
# Note that this doesn't remove the file from /etc/apt/sources.list.d/

# Figure out what is listening on port 80.
netstat -tulpn | grep :80
fuser 80/tcp
lsof -i :80 | grep LISTEN
# http://www.cyberciti.biz/faq/find-linux-what-running-on-port-80-command/

lsof -iTCP | less

# Show which process has particular port number open.
lsof -i :8000
# COMMAND   PID      USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
# python  13790 nathaniel    3u  IPv4 59798486      0t0  TCP *:8000 (LISTEN)
# https://www.debian-administration.org/article/184/How_to_find_out_which_process_is_listening_upon_a_port

# Will return 1 if insufficient permissions, e.g. for sshd.
lsof -i :22


sudo lsof -i :631
# COMMAND    PID USER   FD   TYPE   DEVICE SIZE/OFF NODE NAME
# cups-brow  892 root    5u  IPv6 52509000      0t0  TCP localhost:58445->localhost:ipp (CLOSE_WAIT)
# cups-brow  892 root    7u  IPv4    20672      0t0  UDP *:ipp
# cupsd     3284 root   10u  IPv6 53523258      0t0  TCP localhost:ipp (LISTEN)
# cupsd     3284 root   11u  IPv4 53523259      0t0  TCP localhost:ipp (LISTEN)

# Look at executable running process id 2720
ls -l /proc/2720/exe
# lrwxrwxrwx 1 nathaniel nathaniel 0 Aug  9 11:05 /proc/2720/exe -> /usr/lib/firefox/firefox
# Look at first vim process.
ls -l /proc/$(pgrep vim | head -n1)/exe
# Look at all vim processes.
for i in $(pgrep vim); do ls -l /proc/$i/exe; done
# Look at all processes with names matching 'sh'.
for i in $(pgrep sh); do ls -l /proc/$i/exe; done

# See what files it has open.
ls -l /proc/2720/fd

# Launch printer stuff from command line
system-config-printer

# Add a red dot to the prompt, e.g. when recording; from here:
# https://news.ycombinator.com/item?id=6190600
PS1=`printf "\033[1;31m\342\227\217\033[0m\\$ "` sh

# Sort a file in place and guarantee uniqueness as well.
sort --unique myfile.txt --output=myfile.txt
sort  myfile.txt -u -o myfile.txt

# Eject dvd drive
eject /dev/dvd4
# Close dvd drive (does not work on most laptops)
eject -t /dev/dvd4
# Toggle dvd drive (also does not work on most laptops)
eject -T /dev/dvd4

# Start a new x session (generally you already have 0 running)
# Go to a tty using e.g. ctrl-alt-F1
startx -- :1 &
# or do this
xinit -- :1

# Check the web cam based on the device file
camorama -d /dev/video1
cheese -d /dev/video0


update-alternatives --display editor
update-alternatives --list x-terminal-emulator
update-alternatives --list editor

# Change default terminal emulator
sudo update-alternatives --config x-terminal-emulator
# /var/lib/dpkg/alternatives/x-terminal-emulator
sudo update-alternatives --set editor /usr/bin/vim.basic
# /var/lib/dpkg/alternatives/editor

# Display current window manager.
update-alternatives --display x-window-manager
# Change display manager, e.g. kwin_x11, mutter, openbox, twm, xfwm4
sudo update-alternatives --config x-window-manager
# Relevant files:
# /etc/alternatives/x-window-manager
# /usr/bin/x-window-manager
# /var/lib/dpkg/alternatives/x-window-manager
# /var/log/alternatives.log
# Relevant links:
# https://www.debian.org/doc/manuals/debian-handbook/sect.customizing-graphical-interface.da.html

# Change session manager, e.g. gnome-session, lxsession, openbox-session, startkde
sudo update-alternatives --config x-session-manager
# https://www.debian.org/doc/manuals/debian-reference/ch07.en.html


# Example of how the symlink changes:
#  d /
#  d etc
#  d alternatives
#  l x-window-manager -> /usr/bin/openbox
#    d /
#    d usr
#    d bin
#    - openbox

# Using globstar.
shopt -s globstar
vim -p **/*.txt
# When the globstar shell option is enabled, and * is used in a pathname
# expansion context, two adjacent *s used as a single pattern will match all
# files and zero or more directories and subdirectories. If followed by a, two
# adjacent *s will match only directories and subdirectories.

# See which packages are using the most disk space.
dpkg-query -W --showformat='${Installed-Size} ${Package}\n' | sort -nr | less

# Using gcc (gnu c compiler) without a makefile (on the fly, so to speak)
gcc testing.c # compile c file into 'a.out' binary
gcc -Wall -o "testing" "testing.c" # compile into 'testing' binary and show warnings
gcc -Wall -o "testing" "testing.c" -lm # compile with math.h
gcc -Wall -o "testing" "testing.c" --llapack # compile with lapack

# Show what gcc defines.
gcc -dM -E - < /dev/null

# use the recoll command from the terminal
recoll -t oatmeal | less -S
# Search for exact phrase.
recoll -t '"moved permanently"'
# Useful for timing queries.
time recoll -t '"moved permanently"'

recoll -t -l "dir:/usr/share/games/fortunes/ orphan" 2>/dev/null | less

recoll -t -l "ext:py dir:archive/ import logging" 2>/dev/null | less

recoll -t 'dir:"home/nathaniel/SpiderOak Hive/writings/looseleaf/posts/" orphan' 2>/dev/null | less

recoll -t dir:posts whack

# Find text files with mimetype text/plain that don't end with '.txt'.
recoll -t -l 'mime:text/plain -ext:txt' 2>/dev/null | less

# https://askubuntu.com/questions/641386/in-recoll-how-to-view-the-list-of-files-that-have-been-indexed-in-a-specific-di

# See ten newest processes
ps k-start_time
# List nine oldest processes.
ps -ef --sort start_time | head
ps ax --sort lstart | head
ps ax --sort bsdstart | head
# See oldest processes first
ps axkstart_time | less
# See newest processes first
ps axk-start_time | less
ps --sort -start_time -ef | less

# Downloading flash videos
# Ohloh comparison:
# https://www.ohloh.net/p/compare?project_0=clive&project_1=cclive&project_2=youtube-dl
youtube-dl 'http://youtu.be/otXf1VukQkU' # lots of development activity
quvi 'http://youtu.be/otXf1VukQkU'   # quvi is a library that other languages can call, too
clive  'http://youtu.be/otXf1VukQkU' # stands for 'command live video extraction'
cclive 'http://youtu.be/otXf1VukQkU' # rewrite of clive in C++

youtube-dl --write-info-json 'https://www.youtube.com/watch?v=T0noDEI2nLY'

youtube-dl --write-auto-sub --write-info-json --sub-lang en 'https://www.youtube.com/watch?v=QncdLPYLPkA'

# Pick a certain file.
youtube-dl -F 'https://www.youtube.com/watch?v=C0DPdy98e4c'
# [youtube] C0DPdy98e4c: Downloading webpage
# [youtube] C0DPdy98e4c: Downloading video info webpage
# [info] Available formats for C0DPdy98e4c:
# format code  extension  resolution note
# 171          webm       audio only DASH audio   15k , vorbis@128k, 28.67KiB
# 249          webm       audio only DASH audio   25k , opus @ 50k, 43.28KiB
# 250          webm       audio only DASH audio   38k , opus @ 70k, 59.42KiB
# 251          webm       audio only DASH audio   54k , opus @160k, 85.16KiB
# 140          m4a        audio only DASH audio  127k , m4a_dash container, mp4a.40.2@128k, 274.02KiB
# 278          webm       192x144    144p   27k , webm container, vp9, 13fps, video only, 52.21KiB
# 160          mp4        192x144    144p   37k , avc1.4d400b, 25fps, video only, 62.40KiB
# 133          mp4        320x240    240p   51k , avc1.4d400d, 25fps, video only, 85.11KiB
# 242          webm       320x240    240p   69k , vp9, 25fps, video only, 131.47KiB
# 134          mp4        480x360    360p   84k , avc1.4d4015, 25fps, video only, 138.98KiB
# 243          webm       480x360    360p  106k , vp9, 25fps, video only, 200.87KiB
# 135          mp4        640x480    480p  121k , avc1.4d401e, 25fps, video only, 197.65KiB
# 244          webm       640x480    480p  153k , vp9, 25fps, video only, 287.41KiB
# 43           webm       640x360    medium , vp8.0, vorbis@128k, 280.86KiB
# 18           mp4        480x360    medium , avc1.42001E, mp4a.40.2@ 96k, 540.04KiB (best)
youtube-dl -f 135 'https://www.youtube.com/watch?v=C0DPdy98e4c'

# When gvfsd-metadata spazzes out on you, run this.
rm -rf ~/.local/share/gvfs-metadata
# This is a well-known bug.
# https://bugs.launchpad.net/ubuntu/+source/gvfs/+bug/517021
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=624507

# Searching for unicode characters.
charmap # nice gui, but more than I generally need
unicode beta # find all unicode characters with 'beta' in the name
unicode '.*greek.*small.*beta.*' | less # you can use regular expressions, too
unicode 'greek small letter beta' | less # gets one results
unicode -w 'greek small letter beta' | less # gets the wikipedia page about the unicode characters
# Upside down letters
unicode 'letter turned a'
# Superscripts
unicode  "modifier letter small a"
# Looking it up by character
unicode -i UTF-8 ╗
# Look it up by hex (UTF-16BE)
unicode -x 2557
unicode -x 002557
unicode U+2557
# Look it up by decimal number
unicode -d 9559
# Look it up by octal
unicode -o 22527
# Find all symbols with a description including 'dot' but not 'letter' using regular expressions.
unicode --max 1000 --regex '^(?=.*dot)(?!.*letter).*'
# source:
# https://stackoverflow.com/questions/8240765/is-there-a-regex-to-match-a-string-that-contains-a-but-does-not-contain-b
# Using `ga` in vim gives hex, decimal, and octal, useful for searching unicode(1).
# Using `g8` in vim gives UTF-8 representation, not useful for searching unicde (1).

# See who's been sshing into the machine lately.
sudo grep -i ssh /var/log/auth.log | less -S

# Goodness, am I in a shell launched by bash, or by sshd or something else?
echo $SHLVL # If this is 1, the shell was launched by a terminal, sshd, etc. If not, it was launched by another shell.
# Who is the parent process, anyway?
ps -p $PPID

echo $PPID
grep PPid /proc/$$/status | awk '{print $2}'

# See the contents of a gzip'd file without creating a temp file.
zcat file.gz
# See how much space a gzip'd file would take up without actually unzipping it.
gunzip --list file.gz
# With nicer formatting.
gunzip --list file.gz | numfmt --header=1 --field=1 --to=iec-i | numfmt --header=1 --field=2 --to=iec-i
# For files not in gzip format:
zcat file.gz | wc -c | numfmt --to=iec-i
# The 'zcat' command is just a wrapper for `gzip -cd`.
gzip -cd file.gz | wc -c | numfmt --to=iec-i
gzip --stdout --decompress file.gz | wc --bytes | numfmt --to=iec-i

# Show file size nicely.
wc --bytes file | numfmt --to='iec-i' --suffix='B'

# See paged contents of a gzip'd file without creating a temp file.
zless file.gz

# One way to re-run a process in gdb:
# 1. Look up the process with ps.
ps aux | grep comsol
1000     24466  0.0  0.0   2236   660 pts/9    S+   12:45   0:00 /bin/sh /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/comsol
1000     24497  106  3.8 820832 152864 pts/9   Sl+  12:45   0:12 /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/glnx86/comsollauncher --launcher.ini /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/glnx86/comsol.ini
# 2. Paste the corresponding command after gdb --args.
gdb --args /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/glnx86/comsollauncher --launcher.ini /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/glnx86/comsol.ini
# 3. Trouble is, anything set up by wrapper scripts won't work...

# Probably a better way to run a process in gdb.
# 1. Run the process.
# 2. Look up the process with ps.
ps aux | grep comsol
1000       503  7.7  4.4 853340 179816 pts/9   Sl+  12:55   0:19 /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/glnx86/comsollauncher --launcher.ini /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/glnx86/comsol.ini
# 3. Attach gdb to the process by process id (may need to be root).
sudo gdb /home/nathaniel/local_programs/COMSOL/COMSOL43b_install/COMSOL43b/bin/glnx86/comsollauncher 503
# 4. Once in gdb, press c to continue execution of program.
# Another way to attach to a running process.
gdb -p 503

# Debug a core dump created by a perl process.
gdb /usr/bin/perl -c ./core

# Filter out control sequences like backspace, return, etc.
cat myfile.txt | col -b > filtered.txt

# List books in calibre library.
calibredb list --fields 'title,authors,size'
# Full documentation here:
# http://manual.calibre-ebook.com/cli/calibredb.html#calibredb-list

# Find out which Linux distribution you are running.
cat /etc/issue
# Find out which Debian/Ubuntu distribution you have installed.
lsb_release -a
# See also: uname -a

# See one-letter macros definitions for LaTeX.
texdef -t latex a b c d e f g h i j k l m n o p q r s t u v x y z A B C D E F G H I J K L M N O P Q R S T U V X Y Z
# See the definition of the AA macro (for Angstroms).
texdef AA
latexdef AA
# https://texfaq.org/FAQ-ltxcmds
# https://tex.stackexchange.com/questions/235681/where-is-printtoctitle-defined

# See all non-printing characters in a text file
cat -A myfile.txt

# See wifi network usage,
# including how much you've downloaded,
# if e.g. you have data caps on your internet.
vnstat -i wlan1
# See it updated every 2 seconds (by default)
watch vnstat -i wlan0
# See graphical display.
vnstati -d -s -i wlan1 -o - | display
vnstati --days --summary --iface wlan1 --output - | display


# Watch a rapidly changing text file.
watch cat idxstatus.txt
# See the date changing (primitive clock)
watch date
# Note that this is often better than tail --follow,
# especially if the file is being truncated rapidly.

# A poor man's live coding environment.
touch temp.sh
watch -t -n 0.1 'bash temp.sh'
# watch --no-title --interval 0.1 'bash temp.sh'
vim -c 'autocmd TextChanged,TextChangedI <buffer> write' temp.sh

# watch a piped command
watch 'ps aux | grep mycommand'

# Watch for a command to show an error.
watch -e -n 1 false

# Process files with spaces in the filenames
IFS=$'\n'
for file in *.txt ; do
    # commands on $file here
done
# Another option is to use find with --exec flag

# Check what your IFS is:
cat -etv <<<"$IFS"
cat --show-all <<< "$IFS"
# http://www.cyberciti.biz/faq/unix-linux-bash-split-string-into-array/

# Do a one-liner, e.g. from the command line.
# In this case, append a newline to each file.
for f in *; do echo -e '\n' >> "$f"; done

# Append file2 onto file1.
cat file2 >> file1
# If you need to use sudo.
cat file2 | sudo tee -a file1 > /dev/null
# Only works in zsh.
< file2 >> file1
>> file1 < file2
# https://stackoverflow.com/questions/4969641/append-one-file-to-another-in-linux

# find duplicate files (assuming that identical file size means they're the same)
duff *
duff -r /path/to/directory
# find duplicate files (assuming that identical file sizes does not necessarily mean the same)
duff -t *
duff -rt /path/to/directory
# Other options:
fdupes
rdfind /path/to/directory

# Set the default Gnome browser
update-alternatives --config gnome-www-browser
# Default for foreign programs (system-wide)
update-alternatives --config x-www-browser

# Using make
# Ignore errors, just keep on trucking.
make -i
# Choose the directory to make into
make -C /path/to/directory
make --directory=/path/to/directory

gtk-redshift -l 41.9:-87.6 -t 5700:3600 -g 0.8 -m vidmode

# Lock the screen
xflock4

# Quick way to find process ids based on command name
pgrep cron
# See the full line, not just the id
pgrep -a vim
# Search the exact thing
pgrep -x bash

# Show version numbers with apt-get
sudo apt-get update -V
# get changelog (requires internet connection)
apt-get changelog git
# TODO: does this require you do apt-get first?

# See output
annotate-output

# Open emacs in the terminal instead of a separate window
emacs -nw
emacs --no-window-system

# Figure out your current DNS server
cat /etc/resolv.conf | grep nameserver
# Remove censorship of domains
nameserver 176.58.120.112

# Make a directory with the format yyyy-mm-dd of today's date
mkdir $(date -I)
# Note: the -I / --iso-8601 was deprecated until 2011-10-27.
# https://unix.stackexchange.com/a/164834
# https://unix.stackexchange.com/questions/164826/date-command-iso-8601-option
# https://lists.gnu.org/archive/html/bug-coreutils/2006-01/msg00155.html

# This does the same thing, but takes a little longer to type:
mkdir $(date +"%F")


# A more complete date, suitable for e.g. filenames.
date +"%Y-%m-%d_%T%p_%Z"
# e.g 2015-03-23_01:06:39AM_CDT
# Warning: this will not work on Windows, because colons cannot exist in filenames.

# Seconds since the Unix epoch (1970-01-01), suitable for filenames and logfiles.
date +%s
# Example: 1441752464
# Drawback: not very human-readable, not portable.

# Convert Unix epoch (timestamp) to human-readable time.
date --date='@1441752464' +%c
# Tue 08 Sep 2015 05:47:44 PM CDT

# Convert Unix epoch (timestamp) to ISO timestamp for current timezone.
date --iso-8601=seconds --date='@1441752464'
# 2015-09-08T17:47:44-05:00

# A complete human-readable date,
# not suitable for filenames or directory names,
# but fine for log files.
date +%c
# Looks like this:
# Tue 08 Sep 2015 05:46:13 PM CDT

# Make a popup message
gdialog --msgbox "Test"
kdialog --msgbox "Test"
# Make a popup message over SSH
export DISPLAY=:0.0 && gdialog --msgbox "Test"
# If you hit Ctrl-C, it stops (i.e. releases the terminal so you can type again) and disappears from the screen on the remote machine.
# If the user closes the box, does the same thing.
# If you're not sure which screen someone is connected to, use `w`
w
# This will show e.g. :0 :1. The dot part is the (optional) screen number, if the X-server is using multiple screens.
# https://unix.stackexchange.com/questions/17255/is-there-a-command-to-list-all-open-displays-on-a-machine
# You can also do obnoxious things like make the window bigger and add Pango markup to change font size and color.
zenity --warning --width=400 --height=400 --text='<span font="32" color="red">Look out!</span>'

# Launch a process while making it think that the date and time is different than it actually is.
faketime 'last Friday 5 pm' /bin/date
faketime '2008-12-24 08:15:42' /bin/date
datefudge "2007-04-01 10:23" date -R

# Easter egg in 'man'.
faketime 00:30:00 man
# gimme gimme gimme
# What manual page do you want?
# https://unix.stackexchange.com/questions/405783/why-does-man-print-gimme-gimme-gimme-at-0030/405874#comment726280_405874
# https://git.savannah.nongnu.org/cgit/man-db.git/commit/src/man.c?id=002a6339b1fe8f83f4808022a17e1aa379756d99

# Launch ipython notebook.
ipython notebook

# List installed kernels.
ipython kernelspec list
jupyter kernelspec list

# Some ipython tricks
# Save lines 1-7 and 10 to myfile.py
%save myfile 1-7 10
# Append lines 11-12
%save -a myfile 11-12

# Joke program to print dates in the Discordian calendar
# http://en.wikipedia.org/wiki/Discordian_calendar
ddate
# Joke message; spit out a random Discordian slogan.
ddate +%.

# Weborf web server as daemon
weborf --basedir ~/weborf/ --cache ~/Downloads/weborf-cache/ --noexec --mime -d

# See security updates
apt-get -s dist-upgrade | grep "^Inst" | grep -i securi
# https://askubuntu.com/questions/81585/what-is-dist-upgrade-and-why-does-it-upgrade-more-than-upgrade

# Login with mobile shell
mosh username@remote.computer
# Login with a different port than the default (60000-61000)
mosh -p 53000 username@remote.computer

# Diff by word
wdiff a.txt b.txt
# Diff by word and suppress common words (useful for very long lines)
wdiff --no-common a.txt b.txt
wdiff -3 a.txt b.txt

# List all installed fonts.
fc-list

# List all monospace fonts.
fc-list :spacing=100 | less

# List all FreeSerif fonts.
fc-list :family=FreeSerif

# List all fonts that support Arabic.
fc-list :lang=ar

# List all X server fonts.
xlsfonts

# List all fonts that support the maple leaf character (U+1F341 MAPLE LEAF 🍁)
printf '%x' \'🍁 | xargs -I{} fc-list ":charset={}"
printf '%x' "'🍁'" | xargs -I{} fc-list ":charset={}"
# -I Replace occurrences of  replace-str  in  the  initial-arguments  with
#    names  read from standard input.

# "If the leading character is a single-quote or double-quote, the value shall
# be the numeric value in the underlying codeset of the character following the
# single-quote or double-quote."
# https://stackoverflow.com/questions/890262/integer-ascii-value-to-character-in-bash-using-printf
# https://pubs.opengroup.org/onlinepubs/009695399/utilities/printf.html

# How to ditch KDE completely
sudo apt-get purge kdelibs-bin kdelibs5-data
# Note: purge will not remove files in /home/, only files in /etc/.
# "Configuration files residing in ~ are not usually affected by this command."
# https://help.ubuntu.com/community/AptGet/Howto

# Report a debian bug
reportbug
# Report a bug for a particular file
reportbug --filename /usr/share/xfce4/helpers/iceweasel.desktop
# Report a bug for a particular package
reportbug iceweasel
# Report a bug for a command in your path
reportbug --path --filename=cd
# Send kudos instead of reporting a bug
reportbug --kudos
# Report a bug with mutt (note that --attach will not transfer to mutt)
reportbug --mutt

# Test local mail by sending a message to yourself.
echo "This is a test email from $LOGNAME" | mail --subject='test message' "$LOGNAME@localhost"
# For bsd-mailx:
echo "This is a test email from $LOGNAME" | mail -s 'test message' -- "$LOGNAME@localhost"

# Entering unicode on Linux.
Ctrl-Shift-U 2103 <Enter> # Insert ℃ (degrees Celsius)
Ctrl-Shift-U b0   <Enter> # Insert ° (degree symbol)
Ctrl-Shift-U 3b1  <Enter> # Insert α (alpha)
Ctrl-Shift-U 3b2  <Enter> # Insert β (beta)
Ctrl-Shift-U 2082 <Enter> # Insert ₂ 
Ctrl-Shift-U ae   <Enter> # Insert ® (registered trademark sign)

# Using zsync for downloads
zsync 'http://releases.ubuntu.com/12.04.4/ubuntu-12.04.4-desktop-i386.iso.zsync'
# Do not do this! It will download the entire iso and then tell you "Bad line - not a zsync file?"
zsync 'http://releases.ubuntu.com/12.04.4/ubuntu-12.04.4-desktop-i386.iso'

# Using the venerable bc command
echo '1 + 2' | bc
# Using the even more venerable dc command
echo '1 2 + p' | dc

# A simple stopwatch; press Ctrl-C or Ctrl-D to end.
time cat
# https://lifehacker.com/285093/turn-the-terminal-into-a-stopwatch-with-time-cat
# An even simpler stopwatch; press enter or Ctrl-D to end
time read
# https://www.commandlinefu.com/commands/view/1567/a-very-simple-and-useful-stopwatch
# Press any key to stop the watch
time read -sn1
# A stopwatch that counts up the seconds until it's stopped.
i=0; while true; do echo $i; sleep 1; i=$((i+1)); done
i=0; while true; do echo $i; sleep 1; ((i++)); done
for ((i=0;; i++)); do echo $i; sleep 1; done

# Getting help about bash builtins like read, cd, echo, printf, and type
# They don't have man pages of their own, and the bash man page is way too long to sift through.
# If you're already in a bash shell:
help read | less
help cd | less
# Otherwise:
bash -c "help read" | less
bash -c "help cd" | less

# See when the last apt-get update was
stat -c %y /var/lib/apt/periodic/update-success-stamp
# more reliable check of date/time of last update
stat -c %y /var/cache/apt/pkgcache.bin
# or even
stat /var/cache/apt/

# Do speech to text
# Convert to 16khz 16bit mono wav file
ffmpeg -i file.mp3 -ar 16000 -ac 1 -sample_fmt s16 file.wav
# Convert the wavefile to text
pocketsphinx_continuous -infile file.wav > file.txt
# Specify the folder with pocketsphinx-en-us model.
pocketsphinx_continuous -hmm /usr/share/pocketsphinx/model/en-us/en-us -infile file.wav > out.txt

# Concatenate / combine mp3s files.
ffmpeg -i "concat:file1.mp3|file2.mp3" -acodec copy output.mp3
# https://superuser.com/questions/314239/how-to-join-merge-many-mp3-files#314245

# Gnuplot png output
set term png # or pngcairo
set output "out.png"
plot x**2
set term wxt

# Seeing the changes in a package before updating
apt-get install apt-listchanges
sudo dpkg-reconfigure apt-listchanges
# https://unix.stackexchange.com/questions/46509/disable-changelogs

# See bugs in a package before updating
apt-get install apt-listbugs

# Un-pin fixed packages automatically.
# First, backup the pinned packages.
cp /etc/apt/preferences.d/apt-listbugs ~/tmp/
# Next, write to the file.
# We have to use tee to have the permissions to write to the file.
# https://stackoverflow.com/questions/16573888/redirect-output-to-a-file-permission-denied
/usr/share/apt-listbugs/aptcleanup | sudo tee /etc/apt/preferences.d/apt-listbugs
# Note that this will take a long time, almost thirty seconds in my case.
# real	0m22.681s
# user	0m11.024s
# sys	0m1.664s

# Instead of pinning, just hold the package to keep it from getting updated with the other packages.
apt-mark hold lvm2
apt-mark unhold lvm2
# See held packages.
apt-mark showhold
# https://www.reddit.com/r/debian/comments/3d4v06/looking_to_up_my_debian_game_aptlistbugs_tells_me/

# Use imagemagick to find out information about several files
identify *.jpg

# Use imagemagick to get even more metadata.
identify -verbose *.jpg
# http://xahlee.info/img/metadata_in_image_files.html
# https://superuser.com/questions/219642/what-software-can-i-use-to-read-png-metadata

# Use imagemagick to combine/stitch/concatenate/append two images together, top to bottom.
convert in1.png in2.png -append out.png
# http://www.imagemagick.org/Usage/layers/
# https://superuser.com/questions/290656/combine-multiple-images-using-imagemagick

# Use imagemagick to combine/stitch/concatenate/append two images together, left to right.
convert in1.png in2.png +append out.png


# Use imagemagick to convert png to jpeg
convert file.png file.jpeg

# Use imagemagick to clean up a whiteboard picture
# https://gist.github.com/lelandbatey/8677901
convert $1 -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 $2

# Use imagemagick to get the first page of pdf and turn it into a png.
convert file.pdf[0] file.png

# Add a white background to first page of pdf instead of being transparent.
convert -background white -flatten file.pdf[0] file.png
# https://stackoverflow.com/questions/22994313/imagemagick-convert-pdf-with-transparency-to-jpg
# https://tex.stackexchange.com/questions/64505/how-to-make-each-pdf-page-of-a-beamer-output-have-an-opaque-background-when-it-i

# Also use higher density.
convert -density 600 -background white -flatten file.pdf[0] file.png

# Trim excess border of a uniform color.
convert -trim image.png image-trimmed.png
convert -trim image{.png,-trimmed.png}
# http://www.imagemagick.org/script/command-line-options.php?#trim

# Leave a 10-pixel black border behind.
convert -bordercolor black -trim -border 10x10 in.png out.png

# Turn all of a uniform color to a different color.
convert in.png -fill white -opaque blue   balloon_white.gif
convert in.png -fill white -draw 'color 0,0 replace' out.png

convert in.png -fill white -opaque 'rgb(114,159,207' out.png
convert in.png -fill white -opaque '#729FCF' out.png

# Create a png of uniform, solid red.
convert -size '100x100' 'canvas:#FF0000' red.png
convert -size '100x100' 'canvas:red' red.png
# http://stackoverflow.com/questions/7771975/imagemagick-create-a-png-file-which-is-just-a-solid-rectangle
# http://superuser.com/questions/294943/is-there-a-utility-to-create-blank-images
# http://www.imagemagick.org/Usage/canvas/#solid

# Invert colors (like a negative).
convert in.png -negate out.png
mogrify -negate in.png

# Convert a color image to black and white,
# or keep it black and white when convert formats
convert -colorspace Gray  color.jpg black_and_white.jpg
# https://stackoverflow.com/questions/13317753/convert-rgb-to-grayscale-in-imagemagick-command-line

# Use imagemagick to reduce the size to 10% of all jpegs, over writing the originals (in place).
mogrify -resize 10x10% *.jpg
# If you want a set resolution.
mogrify -resize 640x480 *.jpg
# If you want a set resolution, even if it distorts the image.
mogrify -resize 640x480! *.jpg
# https://www.novell.com/coolsolutions/tip/16524.html

# Specify a certain file size.
convert original.jpeg -define jpeg:extent=300kb output.jpg
# Also scale down.
convert original.jpeg -define jpeg:extent=300kb -scale 25% output.jpg
# https://stackoverflow.com/questions/6917219/imagemagick-scale-jpeg-image-with-a-maximum-file-size

# Resize all the images in an .odt file:
unzip images.odt -d out/
cd out/
# Otherwise, zip will add out/ to all the paths.
mogrify -resize 10x10% Pictures/*
# We can't junk the paths, since we need to keep the structure.
zip -rm ../resize.odt *
cd ..
rmdir out/

# Or do this:
dir="$(mktemp -d --tmpdir=.)"
unzip images.odt -d "$dir"
cd "$dir"
mogrify -resize 10x10% Pictures/*
zip -rm ../resize.odt *
cd ..
rmdir "$dir"

# On one line:
dir="$(mktemp -d --tmpdir=.)" && unzip -q file.odt -d "$dir" && cd "$dir" && mogrify -resize 10x10% Pictures/* && zip -qrm ../resized.odt * && cd .. && rmdir "$dir"
# TODO: delete dir variable.
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/361f2d3b-beeb-4a29-bcf6-070edaec63a9.json

# restart xfce4 panels
xfce4-panel -r

# see status of dropbox daemon
dropbox status

# Get shareable links of file.
dropbox sharelink temp.txt
# https://www.dropbox.com/s/svviiznki24rc7r/temp.txt?dl=0

# Copy contents of subversion repository into current directory
svn co svn://anonscm.debian.org/debichem/unstable/gelemental/ ./
# or into a named directory:
svn checkout http://svn.csrri.iit.edu/mx/trunk mx

# Check out particular local revision.
svn upgrade # prevent E155036
svn update -r 1175

# Checkout a particular revision.
svn checkout -r 1175 https://subversion.xray.aps.anl.gov/EXPGUI/
svn --quiet checkout -r 1175 https://subversion.xray.aps.anl.gov/EXPGUI/

# Create a patch for using with subversion.
svn patch

# See current revision number.
svn info

# Discard local changes.
svn revert file.txt

# Set the screen brightness (backlight) from the command line
xbacklight -set 100
# See current brightness
xbacklight -get

# Show maximum brightness.
cat /sys/class/backlight/intel_backlight/max_brightness
# 4437

# Forcibly set it to max brightness.
sudo tee /sys/class/backlight/intel_backlight/brightness < /sys/class/backlight/intel_backlight/max_brightness
sudo tee /sys/class/backlight/acpi_video0/brightness < /sys/class/backlight/acpi_video0/max_brightness

# Forcibly set it to a given brightness, e.g. 2000.
echo 2000 | sudo tee /sys/class/backlight/intel_backlight/brightness

# gnuplot command we typically use at the beamline
gnuplot> plot "smx.001" u 1:(log($2/$3)) w lp
# Keep up gnuplot with shell after running a script
gnuplot script.gnuplot -
# gnuplot command with just part of the file:
gnuplot> plot "smy.001" every ::0::136 u 1:(log($2/$3)) w lp

# Ways to prevent a package from being installed
Synaptic → Package → Lock version.
sudo apt-mark hold package-name
echo package-name hold | sudo dpkg --set-selections
# For aptitude only
sudo aptitude hold package-name

# Install a specific package version
sudo apt-get install 'iceweasel=30.0~b5-2'
sudo apt-get install 'recoll=1.17.3-2'
# e.g. "The following packages will be DOWNGRADED:"
sudo apt-get  install --reinstall 'linux-image-amd64=3.16+63'

# Install a package from a specific distribution.
apt-get -t squeeze-backports install freecad
# The -t can go afterward, too.
apt-get install -t wheezy-backports pcmanfm
# Install newer kernel.
apt-get -t jessie-backports install linux-image-amd64

# See installed linux kernel package
apt-cache policy linux-headers-$(uname -r)
# e.g. linux-headers-3.16.0-4-amd64
# <foo>_<VersionNumber>-<DebianRevisionNumber>_<DebianArchitecture>
# https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics.en.html#s-pkgname

# Get a new ip address via DHCP.
sudo dhclient -r eth0
# http://serverfault.com/questions/42799/how-to-force-linux-to-reacquire-a-new-ip-address-from-the-dhcp-server

# Check if a LaTeX package is installed; tengwarscript in this case.
kpsewhich tengwarscript.sty
# Local local LaTeX folder.
kpsewhich -var-value TEXMFHOME
# LaTeX paths
kpsexpand '$TEXMF'
# See if AMS fonts are installed.
kpsewhich amsfonts.sty
# See if AMS symbols are installed.
kpsewhich amssymb.sty

# Run as sudo with a graphical password entry rather than typing password into terminal.
# (Useful when launching a graphical program without the ability to type into a terminal.)
gksudo synaptic

# Set default browser
update-alternatives --config x-www-browser

# Search for all matches for a manpage, not just the first section found.
man --all printf
man -a printf

# Search all sections for man page called exact string 'printf'.
man -k '^printf$'
man -k '^signal$'

# See all repeated manpage sections.
man -k . | cut -d' ' -f 1 | sort -f | uniq -i -c | sort -n | less
man --apropos . | cut --delimiter=' ' --fields=1 | sort --ignore-case | uniq --ignore-case --count | sort --numeric-sort | less
# e.g. intro has the most.
#      4 locale
#      4 printf
#      4 queue
#      4 rand
#      4 random
#      4 socket
#      4 time
#      4 uuid
#      5 md5
#      8 intro

# Open manpage html page in chromium browser.
man --html=/usr/bin/chromium man

# Open manpage html page in default browser.
man --html=x-www-browser man
man --html=sensible-browser man
# Or set the $BROWSER variable.
BROWSER=iceweasel man --html man

# Convert Excel file (xls) to CSV
ssconvert -O 'separator=;' my-spreadsheet.xls out.csv

# Convert ODS to Excel.
ssconvert --export-type=Gnumeric_Excel:xlsx2 in.ods out.xlsx

# Convert all docx to pdf with LibreOffice from the command line
soffice --convert-to pdf *.docx  --headless
# "libreoffice is a shell script that sets up the environment and passes the command line arguments to the soffice.bin binary."
# Note: other instances of LibreOffice must be closed. https://bugs.documentfoundation.org/show_bug.cgi?id=37531

# Convert ODS (OpenDocument spreadsheet) file to Excel XLSX.
soffice --convert-to xlsx mixture-target-mass.ods --headless
# http://ask.libreoffice.org/en/question/2641/convert-to-command-line-parameter/
# http://cgit.freedesktop.org/libreoffice/core/tree/filter/source/config/fragments/filters
# Note: other instances of LibreOffice must be closed. https://bugs.documentfoundation.org/show_bug.cgi?id=37531

# See output formats from unoconv(1).
unoconv --show |& grep Excel
unoconv --format ods --show |& less

# Convert from ODS to Excel XLS.
unoconv --format=xls --output=out.xls in.ods

# Show ascii keycodes/keystrokes/keypresses; press Ctrl-D to end.
showkey -a
showkey --ascii
# Similar to just running
cat
# and looking at output
# Show keycodes, including when key is released. Wait ten seconds for it to end.
# Must be run in a virtual tty, not a graphical terminal, otherwise it will say:
# "Couldn't get a file descriptor referring to the console"
showkey
# Can also do:
xev

# Shows all keys going to the X server.
screenkey
# Useful for e.g. screencasts or Vim demonstrations.


# Info about mouse and keyboards:
xinput --list

# Record all keystrokes.
xinput test-xi2 --root
# http://unix.stackexchange.com/questions/129159/record-every-keystroke-and-store-in-a-file/129171

# Record all keystrokes on device 13.
xinput --test-xi2 --root 13

# See listing of ascii characters,
# including caret notation if you look at Char in the corresponding last column.
man 7 ascii
# ^C = Ctrl-C to terminate a program, i.e. send SIGTERM
# ^D = Ctrl-D to end an interactive program, i.e. send SIGHUP. Also end of file (EOF)
# ^H = Ctrl-H (Backspace)
# ^I = Ctrl-I (Tab)
# ^L = Ctrl-L to repaint screen
# ^M = Ctrl-M
# ^Z = Ctrl-Z to suspend, i.e. send SIGTSTP
#      Oct   Dec   Hex   Char                        Oct   Dec   Hex   Char
#      ────────────────────────────────────────────────────────────────────────
#      003   3     03    ETX (end of text)           103   67    43    C
#      004   4     04    EOT (end of transmission)   104   68    44    D
#      010   8     08    BS  '\b' (backspace)        110   72    48    H
#      011   9     09    HT  '\t' (horizontal tab)   111   73    49    I
#      014   12    0C    FF  '\f' (form feed)        114   76    4C    L
#      015   13    0D    CR  '\r' (carriage ret)     115   77    4D    M
#      021   17    11    DC1 (device control 1)      121   81    51    Q
#      022   18    12    DC2 (device control 2)      122   82    52    R
#      023   19    13    DC3 (device control 3)      123   83    53    S
#      026   22    16    SYN (synchronous idle)      126   86    56    V
#      032   26    1A    SUB (substitute)            132   90    5A    Z
#      034   28    1C    FS  (file separator)        134   92    5C    \  '\\'
#      033   27    1B    ESC (escape)                133   91    5B    [
# http://en.wikipedia.org/wiki/Caret_notation
# See also:
man 3 termios
man 7 signal
man 1 xterm
# control/D (used as an end of file in many shells),
# control/H (backspace),
# control/I (tab-feed),
# control/J (line feed aka newline),
# control/K (vertical tab),
# control/L (form feed),
# control/M (carriage return),
# control/N (shift-out),
# control/O (shift-in),
# control/Q (XOFF),
# control/X (cancel)

# See information about filesystem hierarchy.
man 7 hier

# Disable IPv6
# http://superuser.com/questions/575684/how-to-disable-ipv6-on-a-specific-interface-in-linux
# https://wiki.debian.org/DebianIPv6
# http://mindref.blogspot.com/2010/12/debian-disable-ipv6_22.html
# First, comment out /etc/hosts ipv6 stuff
# Then do
use-ipv6=no
# in /etc/avahi/avahi-daemon.conf
# Next, in /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
net.ipv6.conf.eth0.disable_ipv6 = 1
# Restart stuff.
sudo sysctl -p
# To check what's using IPv6
sudo netstat -tunlp | grep 'udp6\|tcp6'
# More certain way that requires reboot.
echo 'blacklist ipv6' >> /etc/modprobe.d/blacklist
# Reboot and check
cat /proc/net/if_inet6
modprobe ipv6
lsmod | grep ipv6
# Run this also
# http://wiki.centos.org/FAQ/CentOS5#head-47912ebdae3b5ac10ff76053ef057c366b421dc4
touch /etc/modprobe.d/disable-ipv6.conf
echo "install ipv6 /bin/true" >> /etc/modprobe.d/disable-ipv6.conf
# Also
sudo vim /etc/netconfig
# comment out lines starting with:
udp6
tcp6
# also this
sudo vim /etc/default/grub

GRUB_CMDLINE_LINUX_DEFAULT="ipv6.disable=1 quiet"
# and this
# http://www.evsmisc.info/linux/mind-reference-how-to-disable-ipv6-in-debian.html
# another way to check
# http://ubuntu-tutorials.com/2008/01/12/disabling-ssh-connections-on-ipv6/

# to check it actually disabled
dmesg | grep -i ipv6
lsmod | grep -i ipv6

sudo sysctl -w net.ipv6.conf.eth0.autoconf=0

# Add google's public gpg keys for installing their software
wget -q -O - http://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

# Similar for the Tor browser.
sudo apt-key adv --recv-keys --keyserver keys.gnupg.net  74A941BA219EC810
# http://superuser.com/questions/513609/how-to-apt-update-when-apt-is-not-accepting-the-repository

# Same for Spotify.
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886

# Similar for InSync.
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 06BBDC2602DFE7E7
# For these kinds of errors:
# W: GPG error: http://apt.insynchq.com jessie InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 06BBDC2602DFE7E7

# Backup keys.
sudo apt-key exportall > Repo.key

# Show MAC address.
ethtool -P eth0
ethtool -P wlan0

# Change your MAC address (i.e. hardware address)
sudo macchanger --mac 12:34:56:78:91:01 eth0
# Note that this won't change your IP address until you disconnect and reconnect.
sudo macchanger --another wlan0

# TODO: learn how to recover deleted files on a Linux filesystem.
# TODO: running a script on startup, shutdown, wake from suspend, etc.
http://www.linuxquestions.org/questions/slackware-14/how-to-run-a-script-on-wake-up-from-sleep-state-940311/
    When the computer wakes up from hibernate or suspend all scripts in
    /etc/pm/sleep.d are called in reversed order with the argument "thaw" or "resume".

    Just put something like
    Code:
    #!/bin/sh
    case "$1" in
        thaw|resume)
            yourscript.sh
            ;;
    esac
    in /etc/pm/sleep.d and you should be fine.

For more information see man pm-action.


# open a file; desktop-independent command
xdg-open
gvfs-open
# equivalent desktop-specific commands:
gnome-open
kde-open
exo-open
gtk-launch
# https://bugzilla.gnome.org/show_bug.cgi?id=343896
# https://askubuntu.com/questions/5172/running-a-desktop-file-in-the-terminal

# Add debug output.
XDG_UTILS_DEBUG_LEVEL=4 xdg-open 'https://example.org'

# See what syscalls (system calls) a program makes, what files it reads, and so on.
strace echo "Hello."

# Attach strace to a running process. Useful for e.g. seeing if a process is respoding,
# and sending kill signals and seeing if it gets them.
strace -p 2792

# Put the strace log in a file.
strace -o /tmp/strace.log ls

# See what files a program tries to open.
strace -o /tmp/strace.log -e trace=open ls

# See profiling information (what is this process spending time doing?)
strace -c /bin/foo
# Also do it for child processes.
strace -f -c /bin/foo
# Also log output.
strace -o strace.log -f -c /bin/foo

# Pipe stderr to stdout so you can use less.
strace foo 2>&1 | less

strace -o strace.log -ffp 3713

# http://www.cyberciti.biz/tips/linux-strace-command-examples.html
# http://www.hokstad.com/5-simple-ways-to-troubleshoot-using-strace

# Get a line-by-line trace and summary at the end.
strace -o "strace.log" -rCw mycommand args
# Only the summary at the end.
strace -o "strace.log" -cw mycommand args

# Shows that sleep takes up very little CPU.
strace -o $(date +%s).log -rC sleep 2
# Shows that the actual time is spent in nanosleep syscall.
strace -o $(date +%s).log -rTC sleep 2
# https://stackoverflow.com/questions/16757475/the-meaning-of-strace-timestamp

strace -o $(date +%s).log -rC sleep 2
# Looks like this:
#     0.000000 execve("/bin/sleep", ["sleep", "2"], [/* 59 vars */]) = 0
strace -o $(date +%s).log -rTC sleep 2
# Looks like this:
#     0.000000 execve("/bin/sleep", ["sleep", "2"], [/* 59 vars */]) = 0 <0.000499>
# https://unix.stackexchange.com/questions/325622/difference-between-strace-r-and-strace-t-options

# Using wine.
wine program.exe
# Debugging wine.
winedbg program.exe
# Uninstalling wine software.
wine uninstaller

time sudo updatedb
# If you do
sudo time updatedb
# it will use /bin/sh, not /bin/bash,
# so it will run /usr/bin/time instead of the bash built-in.

# URL for tracking a UPS package:
# http://wwwapps.ups.com/WebTracking/track?track=yes&trackNums=1Z1234567910111213

# Edit piped data with your favorite text editor.
echo 'hi' | vipe

# Determine probable character encoding of a text document.
chardet myfile
# chardet /usr/share/dict/words
# /usr/share/dict/words: utf-8 with confidence 0.99

# Determine probable character encoding of a text document
# (faster than chardet and empirically better at guessing).
uchardet file.txt
# windows-1252
# ~/writings/looseleaf/posts/5b8783ac-8a41-4370-b89b-5bf431d0e8cd.rst

# Get the keyboard layout.
setxkbmap -query
# example output:
# rules:      evdev
# model:      pc105
# layout:     us

# List all files two levels deep.
tree -L 2 -a
# Pass to less, with color.
tree -L 2 -a -C | less -R

# Save as html.
tree -L 2 -a -C | aha > tree.html

# Spit out HTML tree.
tree -H "$PWD" > index.html
# If you don't want the full path as the root:
tree -H . > index.html

# See which users there are.
users
# See which groups you are in.
groups
# See which groups other people are in.
groups other_username
# Does same thing, but more thoroughly.
id $USER
# or just
id

# Finding which binary a command goes to, e.g. vim.
which vim
# Find all the vims.
which -a vim
# Note: it is important to find out if your shell actually uses the binary.
# For example,
which echo
# returns "/bin/echo", but
type echo
# returns "echo is a shell builtin".
# The echo(1) manpage mentions this:
#     NOTE:  your shell may have its own version of echo, which usually supersedes
#     the version described here.  Please refer to your shell's documentation for
#     details about the options it supports.
# http://askubuntu.com/questions/27355/how-do-i-get-help-for-echo-or-other-bash-commands

# Using python instead of which:
>>>> import distutils.spawn
>>>> distutils.spawn.find_executable('mkdir')


# Follow symbolic links recursively.
namei /usr/bin/vim
# Example output.
#   $ namei $(which vim)
#   f: /usr/bin/vim
#    d /
#    d usr
#    d bin
#    l vim -> /etc/alternatives/vim
#      d /
#      d etc
#      d alternatives
#      l vim -> /usr/bin/vim.gtk
#        d /
#        d usr
#        d bin
#        - vim.gtk

# Capture webcam image
streamer -c /dev/video0 -o out.jpeg
# Since it usually defaults to whatever webcam is attached, this usually works, too.
streamer -o out.jpeg

# Live edit reStructuredText and Markdown files.
retext file.rst

# TODO: figure out order of commands for:
sudo nohup time nice
# http://stackoverflow.com/questions/350381/sudo-nohup-nice-in-what-order

# Show a spinning icosahedron.
ico -faces -sleep 0.05

# TODO: find a command that lists installed packages that are available in debian unstable, but not debian stable.

# Debug SpiderOak.
# Takes a long time.
SpiderOak --destroy-shelved-x
SpiderOak --repair

# Get shareable link.
SpiderOakONE --share-single-file=temp.txt
# https://spideroak.com/storage/NZRGKYLWMVZA/shared/811021-5-55547/temp.txt?f9ce28081c95feece929334c41995cb9

# Use 'watch' with an alias or shell function.
watch -x bash -ic 'my-alias'
# https://unix.stackexchange.com/questions/614722/how-to-use-aliases-with-watch-command

# Convert hexadecimal to decimal
python:
int("78",16) # 120
float.fromhex('0x1.ffffp10') # -4.9406564584124654e-324
int("0x78",16) # 120
# Convert decimal to hexadecimal.
hex(120) # '0x78'
3.14159.hex() # '0x1.921f9f01b866ep+1'

# Convert octal to decimal.
int('0170', 8)
# Convert decimal to octal.
oct(120)

# Convert decimal to binary.
bin(120)
# '0b1111000'
# Convert binary to decimal.
int('0b1111000', 2)
int('1111000', 2)
int('1111000', base=2)

# Convert decimal to ternary (requires numpy).
import numpy
numpy.base_repr(73, 3)
# '2201'

# Convert integer to character.
chr(32)

# Convert character to integer.
ord(' ')

# Get partial ascii table.
[(chr(i), unicodedata.name(chr(i))) for i in range(32, 127)]

# See where code crashes.
import ipdb; ipdb.set_trace()

# Or use this:
from IPython import embed; embed()

# Capture screenshot.
scrot
# Capture a window.
scrot --focused
scrot -u
# Capture a window after a delay of two seconds.
scrot --focused --delay 2
scrot -u -d 2
# Select size of screenshot with mouse.
scrot --select
scrot -s
import out.png
xfce4-screenshooter --region

# A primitive screenlogger.
# Warning: don't leave this running accidentally.
watch scrot

# Diagnose inotify problems.
# If you can run
tail -f any-file.txt
# then your inotify is not exhausted.
# Look at these for the limits:
sysctl fs.inotify.max_user_watches
cat /proc/sys/fs/inotify/max_user_watches
cat /proc/sys/fs/inotify/max_user_instances
cat /proc/sys/fs/inotify/max_queued_events

# http://unix.stackexchange.com/questions/15509/whos-consuming-my-inotify-resources
# https://stackoverflow.com/questions/13758877/how-do-i-find-out-what-inotify-watches-have-been-registered/
# See what processes are doing it.
find /proc/*/fd/* -type l -lname 'anon_inode:inotify' -print | less
ps -p $(find /proc/*/fd/* -type l -lname 'anon_inode:inotify' -print 2> /dev/null | sed -e 's/^\/proc\/\([0-9]*\)\/.*/\1/') | less

# Check if a process is using inotify.
find /proc/13913 -type l -lname 'anon_inode:inotify' -print

# https://github.com/guard/listen/wiki/Increasing-the-amount-of-inotify-watchers
# Increase number of watches temporarily.
sudo sysctl fs.inotify.max_user_watches=524288
sudo sysctl -p
# Increase number of watches permanently.
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# TODO: figure out this gzip error
# gzip: MoO2 syn2 2014-11-14.elid: unknown suffix -- ignored

python3 /usr/share/doc/python-acoustid/examples/aidmatch.py myfile.ogg myfile.mp3
# Example:
# $ python3 /usr/share/doc/python-acoustid/examples/aidmatch.py 01.\ Dominium\ Maris\ Baltici.ogg
# Sabaton - Dominium maris Baltici
# http://musicbrainz.org/recording/1473c9e0-bf39-4c96-8c46-b692df220873
# Score: 92%

fpcalc myfile.ogg
# $ time fpcalc 01.\ Dominium\ Maris\ Baltici.ogg
# FILE=01. Dominium Maris Baltici.ogg
# DURATION=29
# FINGERPRINT=AQAA2FqiJUmmLAE--AWOwO_QO0EPy0R49IHPI0fPQ36M8IV_HD7-CL3RH_6R7Bnyo8cfAT6BP_gH-GFx_PA74MeR8DTS6_jxXUJ_tMd7pO-Q_LiOHz9--DgS5PjxCLWoEn0Nhyrh5AhP6HgPPQ8uBR-FM9AuEmGINyJO_LhoEc3FBE-m4x_SI-GJo-eD5klxHt-BhEdeHA_8w8eFQEaqH__wBz78Iz-Sa4XVA9_x4_CLAz4qiseNIw_0KC9yckH1wEll4dnxNERJ4seRXEmOXCtR3cFV4UXyI20UGbW-oMcZPMqMH8kTpD9uTrhyXMcLHzmSC__w4_mA-_BzfLqQ9wpUH7eAL4QuiMcb_MH1oTIRJzi-4zwe41KI7zgTKUL5TUPD5MfJDN_w45cQ6_gioi9EffiRnnhg1DfuGOGLhoxy6EM4hsd1-PhxC36NC-cFW0Qy_cgn_EtRMjrCjC1eQSdCi_iH48ePMFQKlRsAschSyloBvACCAQSWBEoJRYQUlhkhIDNAPKKcEcIAZowQiCEDFEJKQIaAFNYZooERDAHCmGNKMWIBQQI5JcAAhhEnBHXiGAEOkIAZAxRDiCGEtFhyOUi6UIoYi6AxgRojmRRCMSMoMkYYhZAV4kGBmDIKACYMIcogqbBDCsCikCDMCSYAIQghhSgSkjEhggGAA6SUMwA4JAwhCgkhmHEMIQU
#
# real	0m0.171s
# user	0m0.144
# sys	0m0.024s

VBoxManage list vms
# "win7" {89e8e167-7139-4f94-9394-ed1e61735065}
# "sid" {0354993f-42d6-4aab-a317-1562496224d4}
# "ubuntu" {b98242c0-6aea-4ed6-aec3-83b75763f0c0}
# "jessie" {c43eb485-a240-4569-bb24-93a909c2ab7c}

VBoxManage showvminfo b98242c0-6aea-4ed6-aec3-83b75763f0c0
VBoxManage showvminfo ubuntu

# Move a VirtualBox vm.
VBoxManage unregistervm ubuntu # Must do this one at a time.
mv ~/VirtualBox\ VMs/ubuntu/ ~/vm/virtualbox/
VBoxManage registervm ~/vm/virtualbox/ubuntu/ubuntu.vbox # Must use full path.

# When getting this error:
#    Cannot register the hard disk ... {uuid} because a hard disk ‘...’ with UUID {uuid} already exists.
# do this:
VBoxManage internalcommands sethduuid $PWD/win7.vdi

# Resize virtualbox hard drive to 50 GB = 50 * 1024 MB = 51200 MB.
VBoxManage modifyhd Win7.vdi --resize 51200
# http://jonmifsud.com/blog/increase-virtualbox-disk-size/
# http://stackoverflow.com/questions/1688690/how-can-i-easily-add-storage-to-a-virtualbox-machine-with-xp-installed

# Convert raw disk image to VMDK.
VBoxManage convertfromraw --format VDI openwrt.img openwrt.vmdk

wget http://download.virtualbox.org/virtualbox/4.3.32/Oracle_VM_VirtualBox_Extension_Pack-4.3.32-103443.vbox-extpack
sudo VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-4.3.28-100309.vbox-extpack

# Enable multiarch, specifically i386 packages.
sudo dpkg --add-architecture i386
# See which ones are enabled.
dpkg --print-foreign-architectures
# See the main one.
dpkg --print-architecture

# Show dependencies and other information of a .deb file.
dpkg -I ~/Downloads/skype-debian_4.3.0.37-1_i386.deb

# See which distros have a package, e.g. warsow.
whohas warsow

# Queue up packages to install offline.
sudo aptitude install --schedule-only wings3d wmctrl
# Now that the internet is back, install the packages.
sudo aptitude install

# How to use zssh.
# First, install it on both machines.
# Then, log into the remote machine from the local machine.
zssh nbeaver@chloride.phys.iit.edu
# Find the file and send it.
nbeaver@chloride:~$ sz cron.log
# Now press Ctrl-Space to get the zssh> prompt and type pwd to make sure you're in the right directory.
    �B00000000000000
    zssh > pwd
# Now type rz to receive the file.
    zssh > rz
    Receiving: cron.log
    Bytes received:   11752/  11752   BPS:891652

    Transfer complete


# Getting hardware information in /proc/acpi or /sys/class via the acpitool command.
# For exam
acpitool --battery
#  Battery #1     : present
#    Remaining capacity : 69830 mWh, 99.64%
#    Design capacity    : 71280 mWh
#    Last full capacity : 70080 mWh, 98.32% of design capacity
#    Capacity loss      : 1.684%
#    Present rate       : 0 mW
#    Charging state     : Unknown
#    Battery type       : Li-ion
#    Model number       : 42T4763
#    Serial number      : <snip>

# Alternative.
upower -i /org/freedesktop/UPower/devices/battery_BAT0

# To see everything.
upower -d
upower --dump

cat /sys/class/power_supply/BAT0/status
cat /sys/class/power_supply/BAT0/capacity

# Run the C++ interpreter, ROOT (cint)
root -l
# requires root-system package.

# Read from user, populating with "blah blah blah" as a start.
read -i "blah blah blah" -e
# Read from user, giving a prompt.
read -p '$ ' -i "blah blah blah" -e

# Only in xfce 4.10. :(
xfce4-mime-settings

# Shell script to enable kernel modules for sensors,
# e.g. hard drive temperature, cpu temperature, and fan speeds.
sudo sensors-detect
# First, install these packages, though:
sudo apt-get install lm-sensors hddtemp
# Then run this command
sensors
# acpitz-virtual-0
# Adapter: Virtual device
# temp1:        +78.0°C  (crit = +83.0°C)
#
# thinkpad-isa-0000
# Adapter: ISA adapter
# fan1:        3921 RPM
#
# coretemp-isa-0000
# Adapter: ISA adapter
# Physical id 0:  +78.0°C  (high = +80.0°C, crit = +85.0°C)
# Core 0:         +78.0°C  (high = +80.0°C, crit = +85.0°C)
# Core 1:         +74.0°C  (high = +80.0°C, crit = +85.0°C)
# Or this command
sudo hddtemp /dev/sda
# More info:
# http://www.lucidtips.com/2009/06/06/monitor-cpu-and-hard-drive-temperatures-on-ubuntu-linux/
# Hard drive temperature may not be associated with failure rates:
# https://www.backblaze.com/blog/hard-drive-temperature-does-it-matter/

# TODO: how to install --install-suggests packages after the package is already installed.
# http://askubuntu.com/questions/556753/how-to-install-suggests-on-an-already-installed-package

# Stream Google text-to-speech.
mplayer -really-quiet "http://translate.google.com/translate_tts?tl=en&q=Hello, world!"
# http://www.reddit.com/r/linux/comments/1xcdtk/the_generally_helpful_bashrc_alias_thread/cfa4p21

# Use md5 hash to verify integrity of a file.
md5sum debian-live-7.6.0-amd64-xfce-desktop.iso

# Download a file while running the checksum.
# http://unix.stackexchange.com/questions/19049/obtaining-md5-during-wget/19054#19054
wget -qO - 'http://commons.wikimedia.org/wiki/File:Ippolito1.jpg' | tee Ippolito1.jpg | md5sum
# 570f9617245979be3c5219c73b577230  -

# use `watch` on a bash function
watch -x bash -ic 'my-function'
# https://unix.stackexchange.com/questions/614722/how-to-use-aliases-with-watch-command

# Use the /usr/bin/dict system dictionary to look up some tricky words.
dict sinecure
dict factotum
dict synecdoche
dict scrofulous
dict 'sine qua non'
dict "bete noire"
# Surprisingly good for physics terminology.
dict 'ab initio'
dict adiabatic
dict astatine
dict fugacity
dict 'magnetic moment'
# A few missing, however.
dict virial
dict equipartition
dict commutator
dict permittivity

# Installing skype on Debian
# https://wiki.debian.org/skype
# ~/src/shell/utils/install-scripts/skype/install-skype.sh

# See how bash does tab completion for a command, e.g. vim:
complete -p vim
# Show a list of all possible completions.
complete -p
# Adjust completion for a command, in this case 'follow'
complete -c which follow
# https://www.debian-administration.org/article/316/An_introduction_to_bash_completion_part_1
# http://tldp.org/LDP/abs/html/tabexpansion.html
# https://unix.stackexchange.com/questions/108423/how-to-add-pattern-to-bash-completion-for-unzip
# The completion scripts are here:
# /usr/share/bash-completion/bash_completion
# /etc/bash_completion.d/

# Open bugpage for a package in the debian sensible-browser.
bts bugs horae

# Use gnome indexing software.
tracker-search

# Delete the tracker database.
tracker reset --hard
# https://askubuntu.com/questions/346211/tracker-store-and-tracker-miner-fs-eating-up-my-cpu-on-every-startup?noredirect=1

# See all the packages implemented in the Lisp programming language.
debtags search "implemented-in::lisp"
axi-cache search --all implemented-in::lisp

# See all terminal emulators.
axi-cache search --all x11::terminal


# TODO: how to search for multiple tags with axi-cache?
debtags search 'works-with-format::tex && interface::text-mode' | less

# TODO: search for homepages that include 'sourceforge.net'
# https://askubuntu.com/questions/650704/commands-to-search-by-project-homepage-tag

# Get useful debugging info from /proc/ pseudo-filesystem.
tail --lines=+1 /proc/27870/{status,syscall,sched,io,limits,maps} > proc-info.txt

# Time of last reboot.
who -b
who --boot
last reboot

# Find approximate matches to man pages.
man $(whichman whicman)

# Convert text encodings.
iconv --from-code=iso-8859-1 --to-code=utf-8 latin-1.txt > utf-8.txt
iconv --from-code=iso-8859-1 --to-code=utf-8 latin-1.txt --output utf-8.txt
iconv -f iso-8859-1 -t utf-8 latin-1.txt -o utf-8.txt

# Convert file from UTF-16LE to UTF-8.
iconv -f UTF-16LE -t UTF-8 infile.txt -o outfile.txt

# Alternative conversion method.
recode windows-1252..utf-8 < in.txt > out.txt

# See all available versions for a packages.
rmadison recoll
rmadison iceweasel
aptitude versions recoll
# https://unix.stackexchange.com/questions/39261/how-to-see-package-version-without-install

# https://superuser.com/questions/132346/find-packages-installed-from-a-certain-repository-with-aptitude
# List all origins for packages.
apt-cache policy | sed -n 's/.*o=\([^,]\+\).*/\1/p' | uniq

aptitude search -F %p '?name(^g\+\+$)'

# List packages from an origin other than Debian.
aptitude search -F "%p %m" "?installed?not(?origin(Debian))"
# e.g. /var/lib/apt/lists/linux.dropbox.com_debian_dists_jessie_Release

# List dummy or transitional packages.
aptitude search '~i ~d transitional'
dpkg -l | grep 'dummy\|transitional\|obsolete' | less

# List obsolete packages.
aptitude --disable-columns search '?obsolete'
# https://askubuntu.com/questions/98223/how-do-i-get-a-list-of-obsolete-packages
apt-show-versions | grep 'No available version'

# Remove obsolete packages.
apt-get --purge remove $(aptitude search ?obsolete -F %p)

# List installed backports to wheezy.
aptitude search '?narrow(?installed,?archive(wheezy-backports))'

# List installed backports to current version.
aptitude search '?narrow(?installed,?origin(Debian Backports))'
aptitude search '?narrow(?version(CURRENT),?origin(Debian Backports))' -F '%100p' | less
# http://forums.debian.net/viewtopic.php?f=10&t=120739
# http://backports.debian.org/FAQ/

# List installed packages not from stable branch.
aptitude search "?narrow(?installed,?not(?archive(stable)))"
# Show package name and candidate version.
aptitude search -F "%p %V" "?narrow(?installed,?not(?archive(stable)))"
# Show package name, candidate version, priority, section, and current state.
aptitude search -F "%p %V %P %s %C" "?narrow(?installed,?not(?archive(stable)))" | less
# http://algebraicthunk.net/~dburrows/projects/aptitude/doc/en/ch02s04s01.html

# List installed packages with wheezy backports available.
aptitude search '?and(~i, ~Awheezy-backports)'
# http://askubuntu.com/questions/313806/how-to-list-available-backport-upgrades
# http://algebraicthunk.net/~dburrows/projects/aptitude/doc/en/ch02s03s05.html

# TODO: list installed pacakges with available backports that have not yet been installed.
# https://askubuntu.com/questions/596175/list-uninstalled-backports

# List packages by section.
aptitude -F'|%p|%d|' search '?section(hamradio)'
# https://askubuntu.com/questions/469612/how-can-i-get-a-list-of-all-packages-in-a-repository-section-from-command-line

# Find upgradable packages.
aptitude search '~U'
apt list --upgradable
# http://askubuntu.com/questions/99834/how-do-you-see-what-packages-are-available-for-update

# Package names only.
aptitude search -F '%p' --disable-columns '~U'

# Get required packages.
aptitude search '?priority(required)'
# https://askubuntu.com/questions/110123/how-do-i-find-a-list-of-packages-with-priority-required

printf "$HOME/.bashrc\n$HOME/.profile\n" | while read -r; do file "$REPLY"; done
# http://stackoverflow.com/questions/448126/lambda-functions-in-bash

GOOS=windows GOARCH=386 go build -o hello.exe hello.go
wine hello.exe
# http://www.limitlessfx.com/cross-compile-golang-app-for-windows-from-linux.html
# https://github.com/golang/go/wiki/WindowsCrossCompiling
# https://stackoverflow.com/questions/25051623/golang-compile-for-all-platforms-in-windows-7-32-bit

# Unix Y2K bug (only works on 32-bit architectures):
date --date='January 19, 2038 03:14:07 UTC'
# Mon Jan 18 21:14:07 CST 2038
date --date='January 19, 2038 03:14:08 UTC'
# date: invalid date `January 19, 2038 03:14:08 UTC'
# on 64-bit systems, it just says:
# Mon Jan 18 21:14:08 CST 2038
# http://en.wikipedia.org/wiki/Year_2038_problem
# Origin is due to overflow of a signed 32-bit integer.
date -u --date=@"$((2**31-1))"
# Tue Jan 19 03:14:07 UTC 2038


# Display date of Easter (for Western Christian churches).
ncal -e
# Use a specific year.
ncal -e -y 2038

# Start week with Monday instead of Sunday.
ncal -M -b

# Show upcoming event information.
pal -r 30 | less
calendar


# Running cmd.exe on Linux.
wine cmd
# http://www.linux.org/threads/running-windows-batch-files-on-linux.7610/

# Check if linux crash dump is enabled.
grep CONFIG_CRASH /boot/config-$(uname -r)

# Check for obsolete packages.
aptitude search ?obsolete | less

# Looking up fonts.
fc-match Helvetica
# helvR12-ISO8859-1.pcf.gz: "Helvetica" "Regular"
dlocate helvR12-ISO8859-1.pcf.gz
# xfonts-75dpi: /usr/share/fonts/X11/75dpi/helvR12-ISO8859-1.pcf.gz
# xfonts-100dpi: /usr/share/fonts/X11/100dpi/helvR12-ISO8859-1.pcf.gz

FC_DEBUG=8 fc-match Helvetica | less
# https://www.freedesktop.org/software/fontconfig/fontconfig-user.html

FC_DEBUG=4 pango-view -q -t 'ᚠ' 2>&1 | grep -o 'family: "[^"]\+' | cut -c 10- | tail -n 1
# https://repolinux.wordpress.com/2013/03/10/find-out-fallback-font-used-by-fontconfig-for-a-certain-character/

# convert Windows/DOS format text files with \r\n newlines to Unix format.
tr -d '\r' < file.txt > out.txt
dos2unix file.txt
# https://stackoverflow.com/questions/82726/convert-dos-line-endings-to-linux-line-endings-in-vim

# Recursively find text files that contain the DOS carriage return / DOS line ending (octal 015, hexadecimal x0D).
grep -Url $'\015' --include='*.txt'
grep -Url $'\x0d' --include='*.txt'
grep -Url $'\r' --include='*.txt'
grep --binary --recursive --files-with-matches $'\r' --include='*.txt'
# Or just ignore binary files.
grep -IUrl $'\r'
# and exclude git repos
grep -IUrl $'\r' --exclude-dir='*.git'
# https://unix.stackexchange.com/questions/79702/how-to-test-whether-the-file-is-crlf-or-lf-without-modyfing-it
# http://unix.stackexchange.com/a/79713
# http://vsingleton.blogspot.com/2009/03/grep-using-octal-patterns-and-avoid.html
# https://superuser.com/questions/194668/grep-to-find-files-that-contain-m-windows-carriage-return
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/fd1ea283-a1ec-4997-9806-464a5a715624.json

# Grep only Makefiles.
grep --recursive --include=Makefile 'example-pattern'
grep -r --include=Makefile 'example-pattern'

# use ag (silver searcher) on just Makefiles.
ag --file-search-regex Makefile 'example-pattern'
ag -G Makefile 'example-pattern'

# Search for .c files with 'sprintf('.
ag -G '.*\.c$' 'sprintf('

# Sesarch for .sh files with '<<<' (here-doc).
ag -G '.*\.sh' '<<<' .

# Save a transcript of terminal session.
script
# Default output file is `typescript`.
# http://linuxers.org/article/script-command-line-tool-recordsave-your-terminal-activity
script --flush

# Works with util-linux-ng 2.17.2,
# SHA1 e1f228ff87afb63f4213b1a1e01264a54c4cf70b
script -f -t typescript.out 2> typescript.tm

# Works with util-linux 2.25.2,
# SHA1 5ce73e50ff00676cad8f477597a65c972af73f65
script --timing=typescript.tm --flush "$logfile"

# View the typescript.
more typescript
less -r typescript
# Alternative: use `screen`.
C-a H
# Begins/ends logging of the current window to the file screenlog.n
# in the window's default directory,
# where n is the number of the current window.
# https://www.gnu.org/software/screen/manual/screen.html#Hardcopy

gsettings list-schemas | less

gsettings list-keys  org.gnome.desktop.default-applications.terminal

gsettings get org.gnome.desktop.default-applications.terminal exec
# e.g. 'x-terminal-emulator'

gsettings set org.gnome.desktop.default-applications.terminal xfce4-terminal

column -s, -t file.csv
# https://www.reddit.com/r/bash/comments/37cb9v/favorite_shell_tricks/
column -s , -t current_calculations.csv | less

# For TSV files.
column -t -s $'\t' myfile.tsv
# https://unix.stackexchange.com/questions/7698/command-to-layout-tab-separated-list-nicely

# Install python packages the safe way (or at least safer).
pip install --user matplotlib
# https://pip.pypa.io/en/stable/installing/
# Not this:
sudo pip install matplotlib

# Remove packages with pip.
pip uninstall matplotlib
# https://pip.readthedocs.org/en/stable/reference/pip_uninstall/

# Install ruby packages locally.
gem install --user-install thyme

vlc http://traffic.libsyn.com/nightvale/1-Pilot.mp3

echo 'THIS IS ALL UPPERCASE' | tr '[:upper:]' '[:lower:]'
echo 'THIS IS ALL UPPERCASE' | tr 'A-Z' 'a-z'
# this is all uppercase
echo 'THIS IS PARTLY UPPERCASE, and partly lowercase.' | tr '[:upper:][:lower:]' '[:lower:][:upper:]'
# this is partly uppercase, AND PARTLY LOWERCASE.

# rot13 a file.
tr a-zA-Z n-za-mN-ZA-M < /usr/share/dict/words | less

# TODO: how to change the date modified to a given date, but keep the time of day unchanged.

# Do optical character recognition on an image.
gocr file.png > out.txt
gocr file.png -o out.txt
gocr -a 50 file.png -o gocr_50.txt
# gocr seems to be better at screenshots.
# http://jorgenmodin.net/index_html/archive/2010/06/15/linux-ocr-for-getting-text-from-a-screenshot

tesseract file.png stdout | less
# tesseract seems to be better at scanned books,
# or at any rate larger text.
tesseract -l eng file.jpg output # creates 'output.txt'

# https://askubuntu.com/questions/280475/how-can-instantaneously-extract-text-from-a-screen-area-using-ocr-tools

export NSPR_LOG_MODULES=imap:5; export NSPR_LOG_FILE=/tmp/imap.log; icedove & disown
export NSPR_LOG_MODULES=imap:5,timestamp; export NSPR_LOG_FILE=/tmp/imap.log; icedove & disown
# https://wiki.mozilla.org/MailNews:Logging#Linux.2Funix
# http://wiki2.dovecot.org/Debugging/Thunderbird

>C:\Python27\python.exe myscript.py first_argument.txt > outfile.txt

# Using ANSI color codes in the terminal.
black='\E[30;47m'
red='\E[31;47m'
RED='\033[0;31m'
green='\E[32;47m'
yellow='\E[33;47m'
blue='\E[34;47m'
magenta='\E[35;47m'
cyan='\E[36;47m'
white='\E[37;47m'
no_color='\033[0m'
# http://misc.flogisoft.com/bash/tip_colors_and_formatting
# http://www.tldp.org/LDP/abs/html/colorizing.html
# https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux
# https://stackoverflow.com/questions/30868750/xargs-echo-colored-output

# How many processors does this machine have?
getconf _NPROCESSORS_ONLN
# or
nproc

# How long can paths be?
getconf PATH_MAX /

# Hey, what operating system is this?
echo $OSTYPE
# Note: bash-only.
# linux-gnu
# darwin13
uname
# Darwin
# Linux
uname -s
# Same as uname.
uname -o
# GNU-only extension.
# GNU/Linux
#

# List all signals.
compgen -A signal

# http://zwischenzugs.tk/index.php/2015/07/01/bash-shortcuts-gem/
bind -P
# Example: shortcuts related to line editing.
bind -P | grep line
# accept-line can be found on "\C-j", "\C-m".
# alias-expand-line is not bound to any keys
# backward-kill-line can be found on "\C-x\C-?".
# beginning-of-line can be found on "\C-a", "\eOH", "\e[H".
# end-of-line can be found on "\C-e", "\eOF", "\e[F".
# history-and-alias-expand-line is not bound to any keys
# history-expand-line can be found on "\e^".
# kill-line can be found on "\C-k".
# kill-whole-line is not bound to any keys
# redraw-current-line is not bound to any keys
# revert-line can be found on "\e\C-r", "\er".
# shell-expand-line can be found on "\e\C-e".
# unix-line-discard can be found on "\C-u".

# See what the terminal interprets, e.g. Ctrl-S to pause terminal.
# https://www.gnu.org/software/coreutils/manual/html_node/Characters.html
# http://manpages.ubuntu.com/manpages/precise/en/man3/termios.3.html
# https://www.quora.com/What-are-all-of-the-keyboard-shortcuts-for-sending-signals-from-the-shell?share=1
# https://superuser.com/questions/343031/sigterm-with-a-keyboard-shortcut
stty --all
stty -a
# speed 38400 baud; rows 21; columns 159; line = 0;
# intr = ^C; quit = ^\; erase = ^?; kill = ^U; eof = ^D; eol = M-^?; eol2 = M-^?; swtch = M-^?; start = ^Q; stop = ^S; susp = ^Z; rprnt = ^R; werase = ^W;
# lnext = ^V; flush = ^O; min = 1; time = 0;
# -parenb -parodd -cmspar cs8 hupcl -cstopb cread -clocal -crtscts
# -ignbrk brkint -ignpar -parmrk -inpck -istrip -inlcr -igncr icrnl ixon -ixoff -iuclc ixany imaxbel iutf8
# opost -olcuc -ocrnl onlcr -onocr -onlret -ofill -ofdel nl0 cr0 tab0 bs0 vt0 ff0
# isig icanon iexten echo echoe echok -echonl -noflsh -xcase -tostop -echoprt echoctl echoke

# Keybindings for the terminal.
stty -a | awk 'BEGIN{RS="[;\n]+ ?"}; /= ..$/'
# https://news.ycombinator.com/item?id=9810823

# Get number of columns in current terminal.
echo $COLUMNS
# or
tput columns
# or
stty size | cut -d ' ' -f 2


# Information about a file or directory.
gvfs-info /etc/hosts
# display name: hosts
# edit name: hosts
# name: hosts
# type: regular
# size:  188
# uri: file:///etc/hosts
# attributes:
#   standard::type: 1
#   standard::name: hosts
#   standard::display-name: hosts
#   standard::edit-name: hosts
#   standard::copy-name: hosts
#   standard::icon: text-plain, text-x-generic
#   standard::content-type: text/plain
#   standard::fast-content-type: application/octet-stream
#   standard::size: 188
#   standard::allocated-size: 4096
#   standard::symbolic-icon: text-plain-symbolic, text-x-generic-symbolic, text-plain, text-x-generic
#   etag::value: 1418606230:639411
#   id::file: l2049:26216579
#   id::filesystem: l2049
#   access::can-read: TRUE
#   access::can-write: FALSE
#   access::can-execute: FALSE
#   access::can-delete: FALSE
#   access::can-trash: FALSE
#   access::can-rename: FALSE
#   time::modified: 1418606230
#   time::modified-usec: 639411
#   time::access: 1436849840
#   time::access-usec: 671999
#   time::changed: 1418606230
#   time::changed-usec: 639411
#   unix::device: 2049
#   unix::inode: 26216579
#   unix::mode: 33188
#   unix::nlink: 1
#   unix::uid: 0
#   unix::gid: 0
#   unix::rdev: 0
#   unix::block-size: 4096
#   unix::blocks: 8
#   owner::user: root
#   owner::user-real: root
#   owner::group: root

# Check if a mimetype is known.
gvfs-mime --query x-scheme-handler/thunderlink
gio mime x-scheme-handler/thunderlink
ktraderclient5 --mimetype 'x-scheme-handler/thunderlink'

# Check what mimetype a file is.
xdg-mime query filetype /tmp/foobar.png
gio info -a 'standard::content-type' /tmp/foobar.png
kmimetypefinder5 /tmp/foobar.png
mimetype /tmp/foobar.png

# List mimetypes of all files, sorted by mimetype.
mimetype * | sort -k 2 | less

# Follow symlinks and actually check every file in case the extension is wrong.
mimetype -LM * | sort -k 2 | less

# Set the default application for ftp:// urls to be Thunar.
xdg-mime default Thunar.desktop x-scheme-handler/ftp

# Get default PDF reader.
xdg-mime query default application/pdf

# Trace the file that gives the mimetype association.
XDG_UTILS_DEBUG_LEVEL=2 xdg-mime query default application/pdf

# See how KDE handles the 'appplication/pdf' mimetype.
ktraderclient5 --mimetype 'application/pdf'

# Securely access cups server on another machine by ssh tunneling the port to 3631 instead of 631.
ssh nbeaver@chloride.phys.iit.edu -L 1631:localhost:631
xdg-open http://localhost:1631/
sensible-browser http://localhost:1631/
# http://askubuntu.com/a/164971/182196
# https://askubuntu.com/questions/23936/how-do-you-administer-cups-remotely-using-the-web-interface

# When you're curious what `newspeak` from the `filters` package does.
diff --width 80 --side-by-side --suppress-common-lines /usr/share/dict/words <( newspeak < /usr/share/dict/words ) | less
# bawdily                               | bawdiwise

# Same for `censor`.
diff --width 80 --side-by-side --suppress-common-lines /usr/share/dict/words <( censor < /usr/share/dict/words ) | less
# Cockney                               | CENSOREDney

xfce4-power-manager --restart --debug |& ts | tee xfce4-power-manager.log & disown

virtualenv my-virtualenv
cd my-virtualenv
source bin/activate
deactivate

# Generate a random (type 4) UUID (a.k.a GUID).
uuidgen
# or
cat /proc/sys/kernel/random/uuid
# or
python  -c 'import uuid; print uuid.uuid4()'

# http://www.ossp.org/pkg/lib/uuid/
uuid -v3 ns:URL http://www.ossp.org/

# Get external ip address.
curl --proto https ifconfig.me
# Alternative method, using DNS:
dig +short myip.opendns.com @resolver1.opendns.com
# Similar command.
dig @resolver4.opendns.com myip.opendns.com +short

# Remove file by inode.
ls -i
# or
stat myfile | grep 'Inode'
# then use the find command.
find . -maxdepth 1 -type f -inum 21630370 -delete


# It's interesting which packages config files come from.
dlocate /etc/*.conf | sort | less
dlocate /etc/* | sort | vipe > /dev/null

# List graphical applications.
xlsclients | awk '{print $2}' | sort | uniq

# List all users.
cut -d: -f1 /etc/passwd
awk -F':' '{ print $1 }' /etc/passwd

# Example ssh command.
ssh new@sdf.org

# Example public sftp server.
sftp://itcsubmit.wustl.edu

# Get number of pages in a pdf.
pdfinfo file.pdf | grep 'Pages'
pdftk file.pdf dump_data | grep 'NumberOfPages'

# Use top in batch mode to get a report.
top -n 1 -b > top.txt
# For a single process.
top -n 1 -b -p 4469 > top1.txt
# For multiple processes
top -n 1 -b -p 4469,4530 > top2.txt

# Uses BSD top, not procps (Linux) top.
top -stats pid,command,cpu,idlew,power -o power -d
# compatible SHA1: 628e7d9dbf5d39de5e45cdd4613d4f16f34c991e  /usr/bin/top
# file /usr/bin/top
# /usr/bin/top: setuid Mach-O 64-bit executable x86_64
# $ top -v
# invalid option or syntax: -v
# (returns 1)

# incompatible SHA1: 6542f721ad7d0ef23378bd1e5b53b9e205513483  /usr/bin/top
# file /usr/bin/top
# /usr/bin/top: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 2.6.32, BuildID[sha1]=57ff969efeb84f3097ced51c23ceedcbfe78f03c, stripped
# $ top -v
#  procps-ng version 3.3.9
#Usage:
#  top -hv | -bcHiOSs -d secs -n max -u|U user -p pid(s) -o field -w [cols]

# TODO: find a command to determine how many watts a process is using.

# Get build-id (buildid) of a binary.
file `which ls` | tr , '\n' | grep BuildID
readelf -n `which ls` | grep 'Build ID'
# https://askubuntu.com/questions/139770/what-does-buildid-sha1-mean
# https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Developer_Guide/compiling-build-id.html
# https://stackoverflow.com/questions/7744795/python-get-build-id-from-an-elf-file

# Get all file information (keep going).
file -kr frankenplot_2.3.2-1_all.deb
file --keep-going --raw frankenplot_2.3.2-1_all.deb
# frankenplot_2.3.2-1_all.deb: Debian binary package (format 2.0)
# - current ar archive
# - archive file


# See the versions of all USB devices.
cat /sys/bus/usb/devices/*/version

# Change the permissions of a recently created partition on an external drive.
sudo chown -R nathaniel: /media/nathaniel/TB-backup/laptop-backup/

# Restore a duplicity file.
duplicity restore file:///path_to_folder_contains_backups/ path_where_to_extract_it/

# See the 'simplest' binaries,
# in the sense of having the fewest symbols.
for file in /bin/*; do nm --dynamic $file 2> /dev/null | wc -l | xargs echo -n; echo " $file "; done | sort -n | less

nm --dynamic /usr/bin/line
#                  w __gmon_start__
#                  U _IO_putc
#                  U __libc_start_main
#                  U read
#                  U __stack_chk_fail
# 0000000000601050 B stdout

nm --dynamic /usr/bin/clear
# 0000000000601060 B __bss_start
#                  U cur_term
# 0000000000601060 D _edata
# 0000000000601068 B _end
#                  U exit
# 0000000000400954 T _fini
#                  w __gmon_start__
# 00000000004006a0 T _init
#                  U _IO_putc
#                  w _ITM_deregisterTMCloneTable
#                  w _ITM_registerTMCloneTable
#                  w _Jv_RegisterClasses
#                  U __libc_start_main
#                  U setupterm
#                  U stdout
#                  U tigetstr
#                  U tputs

# Check if a binary was compiled with AddressSanitizer enabled.


ldd /usr/bin/line
# 	linux-vdso.so.1 (0x00007ffc919de000)
# 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fb4c7e06000)
# 	/lib64/ld-linux-x86-64.so.2 (0x00007fb4c81af000)

ldd /usr/bin/clear
# 	linux-vdso.so.1 (0x00007ffceca64000)
# 	libtinfo.so.5 => /lib/x86_64-linux-gnu/libtinfo.so.5 (0x00007f612bfae000)
# 	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007f612bc05000)
# 	/lib64/ld-linux-x86-64.so.2 (0x00007f612c1d8000)

# Get nth line (3rd in this case) of a text file using sed.
sed '3q;d' /usr/share/dict/words
sed -n '3p' /usr/share/dict/words
# Get it without running through the entire file.
sed -n '3{p;q;}' /usr/share/dict/words
# Get the 3rd and 10th words of a text file.
sed -n '3p;10p;d' /usr/share/dict/words
sed '3p;10q;d' /usr/share/dict/words
awk 'NR==3 || NR==10' /usr/share/dict/words
# https://stackoverflow.com/questions/2017034/how-do-i-extract-lines-from-a-file-using-their-line-number-on-unix
# Do it without running through the entire file.
sed -n '3p;10{p;q;}' /usr/share/dict/words

# Plot the system load every second.
xload -update 1 -jumpscroll 1

# Disable volume change notification pop-up bubbles.
sudo mv /usr/share/dbus-1/services/org.xfce.xfce4-notifyd.Notifications.service /usr/share/dbus-1/services/org.xfce.xfce4-notifyd.Notifications.service.disabled
# Reverse the change.
sudo mv /usr/share/dbus-1/services/org.xfce.xfce4-notifyd.Notifications.service.disabled /usr/share/dbus-1/services/org.xfce.xfce4-notifyd.Notifications.service
# https://askubuntu.com/questions/104273/how-do-i-disable-pop-up-notifications-in-xubuntu

# Debug a `mono` program.
locate -i banshee.exe
# /usr/lib/banshee/Banshee.exe
# /usr/lib/banshee/Banshee.exe.config
# /usr/lib/banshee/Banshee.exe.mdb
mono --debug /usr/lib/banshee/Banshee.exe |& tee mono.log
# Or just use this instead:
banshee --debug |& tee banshee.log

# Bash arithmetic.

# Addition.
echo $((2+2))

# Multiplication.
echo $((2*2))

# Exponentiation
echo $((2**10))

# Integer division.
echo $((1/2))
# 0
echo $((1/0))
# bash: 1/0: division by 0 (error token is "0")

# Doing arithmetic in other bases with bash.
# E.g. 1010011011 in binary.
echo $(( 2#1010011011 ))
# 667

# Arithmetic with `expr` command.
expr 2 + 2
expr 2 '*' 2
expr 2 \* 2
expr 1 / 2
# 0
expr 1 / 0
# expr: division by zero

# Browse GNU info pages in the KDE web browser.
konqueror info:bash

# The actual pages are stored here:
ls /usr/share/info/

# Show mouse clicks/events on a window.
xev
xinput --test-xi2

# Show list of input devices.
xinput

# If Mathematica freezes on startup with WolframKernel taking all the CPU.
mathematica  -cleanStart -nostderrWindow

# Try javascript in a repl.
rhino
# js> [] + []
#
# js> [] + {}
# [object Object]
# js> {} + []
# 0
# js> {} + {}
# NaN
# js> 'wat' - 1
# NaN
# https://www.destroyallsoftware.com/talks/wat
# Somewhat different type system in node.js:
nodejs
# > [] + []
# ''
# > [] + {}
# '[object Object]'
# > {} + []
# '[object Object]'
# > {} + {}
# '[object Object][object Object]'
# > 'wat' - 1
# NaN
js24 # from libmozjs-24-bin
# js> [] + []
# ""
# js> [] + {}
# "[object Object]"
# js> {} + []
# 0
# js> {} + {}
# NaN
# js> 'wat' - 1
# NaN

# Update X server settings.
xrdb -merge ~/.Xresources

# See ssh activity.
sudo tcpdump -i wlan1 port 22 -n -Q inout

# Play audio backwards with sox.
play file.mp3 reverse

# Play video backwards.
openshot myfile.mp4
# https://ffmpeg.org/pipermail/ffmpeg-user/2011-December/003564.html
# https://forums.gentoo.org/viewtopic-t-34771-start-0.html
# http://madcompscientist.blogspot.com/2009/03/sdrawkcab-oediv-gniyalp.html
# https://stackoverflow.com/questions/2553448/encode-video-in-reverse
# http://ubuntuforums.org/showthread.php?t=1353893
# https://softwarerecs.stackexchange.com/questions/25668/what-video-player-in-linux-allows-to-play-backwards

# Edit a pdf file with a text editor.
# First, generate the qdf text file (may be large).
qpdf in.pdf --qdf out.qdf
# Then, edit it in your favorite text editor.
vim out.qdf
# Finally generate the pdf.
qpdf out.qdf out.pdf
# Or
fix-qdf out.qdf > out.pdf
# Or
fix-qdf < out.qdf > out.pdf

# From this error:
# Could not find the database of available applications, run update-command-not-found as root to fix this
sudo update-command-not-found

# time of sunrise/sunset in Chicago, Illinois.
sunwait -p 41.836944N 87.684722W
# right at Madison and State street, the origin of Chicago's grid system.
sunwait -p 41.882N 87.628W
# roughly close to Chicago.
sunwait -p 41.8N 87.6W
# time of sunrise/sunset in Anchorage, Alaska.
sunwait -p  61.216667N 149.9W


# TODO: date of solstice and equinox
# http://www.mostlymaths.net/2010/04/gcal-ultra-powerful-command-line-gnu.html

mr register
# Registering git url: git://gitorious.org/frankenplot/frankenplot.git in /home/nathaniel/.mrconfig

# Check for unpushed git repos.
mr --directory ~/Dropbox/ run git status --porcelain --branch | grep 'ahead' -B 1

# If you keep your stow packages in ~/stow/,
# link them like this.
stow -t $HOME -d $HOME/stow -v qpdfview
stow --target $HOME --dir $HOME/stow --verbose qpdfview
# See what will happen without actually doing it.
stow -t $HOME -d $HOME/stow -n -v qpdfview
stow --target $HOME --dir $HOME/stow --simulate --verbose qpdfview

# Check the stow packages in the home directory.
chkstow -t $HOME -l
chkstow --target $HOME --list

# Show config directory for xchat.
xchat -u --configdir
# /home/nathaniel/.xchat2

# List of packages that are available on every standard Debian installation.
aptitude search ~pstandard ~prequired ~pimportant -F%p | less
# https://unix.stackexchange.com/questions/90523/what-packages-are-installed-by-default-in-debian-is-there-a-term-for-that-set

# Check if a variable is defined.
test -v PYTHONPATH; echo $?

# Example of using GNU parallel.
parallel -j 3 -- "sleep 2; echo '1st'" "sleep 1; echo '2nd'" "echo '3rd'"

# TODO: include these tricks.
# http://www.etalabs.net/sh_tricks.html

# Eye dropper app.
gpick

# Turn off swap file (if you have enough RAM).
sudo swapoff -a
# Run it without hogging the disk too much.
ionice -c 3 sudo swapoff -a

# Turn it back on.
sudo swapon -a

# Reduce swappiness to recommended levels.
sudo sysctl vm.swappiness=10
# https://scottlinux.com/2010/06/23/adjust-your-swappiness/
# http://askubuntu.com/questions/184217/why-most-people-recommend-to-reduce-swappiness-to-10-20
# http://askubuntu.com/questions/103915/how-do-i-configure-swappiness#103916

# Nicely-formatted list of XFCE4 keyboard shortcuts.
xfconf-query -c xfce4-keyboard-shortcuts -l -v | cut -d'/' -f4 | awk '{printf "%30s", $2; print "\t" $1}' | sort | uniq
# http://wiki.robotz.com/index.php/Xfce#Customize_the_keyboard_layout_and_shortcut_keys
# https://wiki.xfce.org/faq#keyboard

xfconf-query --channel xfwm4 --property /general/zoom_desktop
# boolean, so will be false or true
xfconf-query -c xfwm4 -p /general/zoom_desktop
# short version

# JSON formatting using jq.
printf "[1, 2, 3, 4]" | jq .

# JSON formatting using python.
printf "[1, 2, 3, 4]" | python -m 'json.tool'
# http://www.skorks.com/2013/04/the-best-way-to-pretty-print-json-on-the-command-line/
# http://stackoverflow.com/questions/352098/how-can-i-pretty-print-json
# http://stackoverflow.com/questions/20265439/how-can-i-pretty-print-json-from-the-command-line-from-a-file

# Escape text from stdin to json-escaped string.
printf 'α β γ δ' | python -c 'import sys; import json; json.dump(sys.stdin.read(), sys.stdout)'
# "\u03b1 \u03b2 \u03b3 \u03b4"

# Check that all UUIDs are version 4.
ls * | cut -c 15 | uniq | grep -v '4'

# Create a 10 megabyte file.
head -c 10MB /dev/zero > bigfile
# Random bytes instead of null bytes.
head -c 10MB /dev/urandom > bigfile

# Make a 10 MB file with just the letter 'a'.
yes 'a' | tr -d '\n' | head -c 10MB > bigfile

# Create a 10GB file.
dd if=/dev/zero of=./gentoo_root.img bs=4k iflag=fullblock,count_bytes count=10G
fallocate -l 10G gentoo_root.img
truncate -s 10G gentoo_root.img
# https://stackoverflow.com/questions/257844/quickly-create-a-large-file-on-a-linux-system
# https://stackoverflow.com/questions/139261/how-to-create-a-file-with-a-given-size-in-linux

SpiderOakONE --userinfo
# nbeaver @ thinkpad-april-2016 on posix/linux2 (encoding utf_8) (Device #5)
# Other devices:
# thinkpad-debian on posix/linux2 (encoding utf_8) (Device #4)
# thinkpad-reborn on posix/linux2 (encoding utf_8) (Device #3) (REMOVED)
# thinkpad-stable on posix/linux2 (encoding utf_8) (Device #2) (REMOVED)
# thinkpad on posix/linux2 (encoding utf_8) (Device #1) (REMOVED)

# Restore a directory to a an output directory at a particular point in time.
SpiderOakONE --restore ~/SpiderOak\ Hive/src/ --point-in-time 2016-04-08 --device 4 --output ~/spideroakone/ --verbose

# Using eqn preprocessor and groff/troff markup engine.
eqn -Tpdf example.ms | groff -Tpdf -dpaper=a4l -P-pa4 > example.pdf
# Using the man formatting of the groff/troff markup engine.
groff -Tpdf -man mxserver.8 > mxserver.8.pdf

# Read a local man file.
man ./my_file.man

# List all soundcards and digital audio devices
aplay -l

# Test sound output.
aplay /usr/share/sounds/alsa/Front_Center.wav
# https://help.ubuntu.com/community/SoundTroubleshooting

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
# powersave
# powersave
# powersave
# powersave
echo 'performance' | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor

wine error_calc.exe
# Could not load wine-gecko. HTML rendering will be disabled.
# Could not load wine-gecko. HTML rendering will be disabled.
# wine: configuration in '/home/nathaniel/.wine64' has been updated.
# err:module:import_dll Library MSVBVM60.DLL (which is needed by L"Z:\\home\\nathaniel\\exe\\error-calc\\error_calc.exe") not found
# err:module:LdrInitializeThunk Main exe initialization for L"Z:\\home\\nathaniel\\exe\\error-calc\\error_calc.exe" failed, status c0000135
# 53
winetricks vb6run

# /bin/tar: Removing leading `/' from member names
# http://hacktux.com/tar/removing/leading/from/member/names

# List 32-bit packages.
dpkg --get-selections | grep ':i386'
aptitude search ~i~ri386

# err:wincodecs:JpegDecoder_CreateInstance Failed reading JPEG because unable to find libjpeg.so.62
sudo apt-get install libjpeg62-turbo:i386
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=783812

# Allow core dump files to be of unlimited size.
ulimit -c unlimited
# Affects this shell and child shells only.

# See core dump settings for this shell.
ulimit -a

# Edit global core dump settings.
edit /etc/security/limits.conf

# http://www.akadia.com/services/ora_enable_core.html
# http://askubuntu.com/questions/642656/core-file-size-with-ulimit
# http://serverfault.com/questions/637212/increasing-ulimit-on-centos
# http://unix.stackexchange.com/questions/108603/do-changes-in-etc-security-limits-conf-require-a-reboot
# http://superuser.com/questions/328069/coredumps-dont-work-after-enabling-them-in-etc-security-limits-conf-on-debian

# Find words in vim dictionary additions that aren't in system dictionary.
diff --new-line-format="" --unchanged-line-format="" <(sort ~/.vim/spell/en.utf-8.add) <(sort /usr/share/dict/words)
comm -23 <(sort ~/.vim/spell/en.utf-8.add) <(sort /usr/share/dict/words)
grep -F -x -v -f <(sort /usr/share/dict/words) <(sort ~/.vim/spell/en.utf-8.add)
# http://stackoverflow.com/questions/18204904/fast-way-of-finding-lines-in-one-file-that-are-not-in-another
# http://unix.stackexchange.com/questions/28158/is-there-a-tool-to-get-the-lines-in-one-file-that-are-not-in-another

# Find words in vim dictionary additions that are in system dictionary.
diff --new-line-format="" --old-line-format="" <(sort ~/.vim/spell/en.utf-8.add) <(sort /usr/share/dict/words)
comm -12 <(sort ~/.vim/spell/en.utf-8.add) <(sort /usr/share/dict/words)
# http://stackoverflow.com/questions/18204904/fast-way-of-finding-lines-in-one-file-that-are-not-in-another

# Recursive search for a git repository that errors when running git status.
find . -type d -name .git -execdir sh -c 'if git status 2>&1 >/dev/null; then exit; else pwd; fi;' \;
# Redirects error to stdout so can be piped to less.

# Get status of git repositories.
find . -type d -name .git -print -execdir git status \; -print

# Loop over only files that are not symlinks,
# and count the number of lines in them.
for path in * ; do if ! test -L "$path"; then wc -l "$path"; fi; done | sort -rn | less

# Follow kernel error messages, like tail -f
dmesg -w

# Include timestamp, though not accurate for e.g. laptops that use sleep mode.
dmesg -wT

# Write to the dmesg ring buffer (as root).
echo $(date) > /dev/kmsg
# Or do this:
echo $(date) | sudo tee /dev/kmsg

# Look at OOM killer scores for various processes.
tail -n +1 /proc/*/oom_score | less
# http://unix.stackexchange.com/questions/153585/how-oom-killer-decides-which-process-to-kill-first
# http://serverfault.com/questions/571319/how-is-kernel-oom-score-calculated

# Get memory statistics.
vmstat -s
#      8059240 K total memory
#      7919284 K used memory
#      3651716 K active memory
#      3772776 K inactive memory
#       139956 K free memory
#        20340 K buffer memory
#      1354500 K swap cache
#     16536572 K total swap
#       540632 K used swap
#     15995940 K free swap
#     53046374 non-nice user cpu ticks
#     20451375 nice user cpu ticks
#     10516909 system cpu ticks
#     97472040 idle cpu ticks
#     10731834 IO-wait cpu ticks
#            0 IRQ cpu ticks
#        78696 softirq cpu ticks
#            0 stolen cpu ticks
#    361465874 pages paged in
#   1286946655 pages paged out
#      5683933 pages swapped in
#      7691695 pages swapped out
#   1187933550 interrupts
#    155010074 CPU context switches
#   1474985461 boot time
#      2039260 forks

# Get disk statistics.
vmstat -D
#            2 disks
#            3 partitions
#     21425856 total reads
#      6174959 merged reads
#    673559356 read sectors
#    361735468 milli reading
#     12964415 writes
#     77668609 merged writes
#   2574192130 written sectors
#   2291626508 milli writing
#            0 inprogress IO
#       207803 milli spent IO

# View eps files.
evince example.eps
gv example.eps
display example.eps

# In case of MemoryError.
pip --no-cache-dir install matplotlib
# http://stackoverflow.com/questions/29466663/memory-error-while-using-pip-install-matplotlib

sysctl kernel.dmesg_restrict=0

./configure --prefix /my/install/dir
make
make install

update-desktop-database ~/.local/share/applications/

# Get size of log files.
locate '*.log' --null | du --files0-from=- | less

# Get a nice table, like column -t, but
# properly parsing and pretty-printing CSV files.
csvtool readable myfile.csv | less
# Use on a TSV file.
csvtool -t TAB readable mydata.tsv | less
# https://stackoverflow.com/questions/1875305/view-tabular-file-such-as-csv-from-command-line

# Use grace plotting program.
xmgrace -hdevice EPS -hardcopy -printfile out.eps myfile.agr
# Pipe it to eps2eps (note that this will lose text):
xmgrace -hdevice EPS -hardcopy -printfile - myfile.agr | eps2eps - out.eps

# http://stackoverflow.com/questions/8141412/fit-to-page-size-in-ghostscript-with-a-possibly-corrupt-input
gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -dEmbedAllFonts=true -dDEVICEWIDTHPOINTS=792  -dDEVICEHEIGHTPOINTS=612 -dPDFFitPage -sOutputFile=reciprocal.pdf reciprocal.eps

# Slow dpkg.
sudo dpkg --clear-avail && sudo dpkg --forget-old-unavail && sudo sync-available
# http://antti-juhani.kaijanaho.fi/newblog/archives/521

ctags -R .
# Create ctags file 'tags' in current directory, working recursively.

# Get e.g. MemTotal, MemFree
cat /proc/meminfo
man proc

# Limit charging.
sudo apt-get install tp-smapi-dkms
sudo modprobe tp_smapi
echo 40 | sudo tee /sys/devices/platform/smapi/BAT0/start_charge_thresh
echo 80 | sudo tee /sys/devices/platform/smapi/BAT0/stop_charge_thresh
# https://askubuntu.com/questions/34452/how-can-i-limit-battery-charging-to-80-capacity
# https://unix.stackexchange.com/questions/48534/how-to-adjust-charging-thresholds-of-laptop-battery

# Find python filenames with dashes in them.
locate -b '*.py' | grep -- '/[^/]*-[^/]*\.py$' | less
# http://stackoverflow.com/questions/761519/is-it-ok-to-use-dashes-in-python-files-when-trying-to-import-them
# http://stackoverflow.com/questions/2740026/why-are-filename-underscores-better-than-hyphens
# http://stackoverflow.com/questions/7583652/python-module-with-a-dash-or-hyphen-in-its-name
# http://stackoverflow.com/questions/8350853/how-to-import-module-when-module-name-has-a-dash-or-hyphen-in-it


# Show PID, memory usage (RSS), and command executable.
ps -o pid,cmd,rss -p 29161

# Show time and date started and elapsed time.
ps -o pid,cmd,lstart,etime -p 29443
# Omit the header.
ps -o pid=,cmd=,lstart=,etime= -p 24684

# Wait 300 seconds (5 minutes) to run an apt command.
apt-get -o DPkg::Lock::Timeout=300 dist-upgrade
# https://blog.sinjakli.co.uk/2021/10/25/waiting-for-apt-locks-without-the-hacky-bash-scripts/

# Get process ID of program running apt-get or dpkg.
sudo fuser /var/lib/dpkg/lock

sudo fuser /var/lib/dpkg/lock-frontend

# Pad image to certain size.
convert in.jpg -gravity center -background black -extent 400x400 out.jpg
# http://www.imagemagick.org/discourse-server/viewtopic.php?t=15123
# http://www.imagemagick.org/Usage/crop/#extent

# Convert QR code.
import - | zbarimg :-
# TODO: why does zbarimg need `:-` instead of `-`?
# https://www.reddit.com/r/Bitcoin/comments/1rsujs/scan_qr_codes_on_your_screen_with_imagemagick_and/

# Browse samba shares.
smbtree

# Get files modified in the last day.
find -mtime -1
# Only in current directory.
find -maxdepth 1 -mtime -1

# Sort and show sum of memory usage.
atop -apM
# -a : all processes, not just active ones
# -p : add up by process name, e.g. combine multiple chromium threads
# -M : sort by memory usage
# https://unix.stackexchange.com/questions/209689/sum-the-memory-usages-of-all-the-processes-of-a-program/209915

# Measure disk seek rate.
sudo ioping -R /dev/sda
# --- /dev/sda (block device 931.5 GiB) ioping statistics ---
# 117 requests completed in 3.01 s, 468 KiB read, 38 iops, 155.6 KiB/s
# generated 118 requests in 3.05 s, 472 KiB, 38 iops, 154.9 KiB/s
# min/avg/max/mdev = 6.66 ms / 25.7 ms / 98.6 ms / 18.4 ms

# Run in current directory as well as saving a log.
ioping . | tee ioping.log

# Run in batch mode, printing statistics at the end.
ioping -B .
# 7 113003542 62 253727 121023 16143363 40439352 14882082 8 7818494244

# Get disk sequential speed in bytes per second.
sudo ioping -RLB . | awk '{print $4}'
# 94805395

# Run on /tmp/ directory.
$ ioping -c 10 -s 1M /tmp/
# 1 MiB <<< /tmp/ (ext4 /dev/sda1): request=1 time=5.11 ms (warmup)
# 1 MiB <<< /tmp/ (ext4 /dev/sda1): request=2 time=18.6 ms
# 1 MiB <<< /tmp/ (ext4 /dev/sda1): request=3 time=3.92 ms
# 1 MiB <<< /tmp/ (ext4 /dev/sda1): request=4 time=3.63 ms
# 1 MiB <<< /tmp/ (ext4 /dev/sda1): request=5 time=3.87 ms
# ^C
# --- /tmp/ (ext4 /dev/sda1) ioping statistics ---
# 4 requests completed in 30.1 ms, 4 MiB read, 133 iops, 133.1 MiB/s
# generated 5 requests in 4.90 s, 5 MiB, 1 iops, 1.02 MiB/s
# min/avg/max/mdev = 3.63 ms / 7.51 ms / 18.6 ms / 6.42 ms

sudo modprobe -r psmouse && modprobe psmouse proto=imps
# https://bugs.launchpad.net/ubuntu/+source/gnome-settings-daemon/+bug/868400

dconf read /org/gnome/desktop/peripherals/touchpad/tap-to-click

echo fs.inotify.max_user_watches=100000 | sudo tee -a /etc/sysctl.conf; sudo sysctl -p

# Generate a core dump of the init process.
gcore $(pgrep -o init)

# Convert Roman numerals to Arabic numerals.
echo 'MDCCL' | numconv -f roman
# 1750
echo 'MCMLXXXIV' | numconv -f roman
# 1984

# Check wifi quality.
watch cat /proc/net/wireless

# Show type of source file for each one.
sloccount --details .


# See paths of all the applicable man pages.
man -wa core
# /usr/share/man/man3/core.3tcl.gz
# /usr/share/man/man5/core.5.gz
# /usr/share/man/man3/Core.3.gz
# /usr/share/man/man3/CORE.3perl.gz

# http://superuser.com/questions/318555/ddg#318559

# Long flags version.
man --where --all core

# Alternately:
whereis core
# core: /home/nathaniel/local/plan9port/plan9port-20140306/bin/core /usr/share/man/man3/core.3tcl.gz /usr/share/man/man5/core.5.gz

# Read the man page directly from the file.
man /usr/share/man/man5/core.5.gz

# Make a new /dev/null
sudo mknod -m 666 /dev/null c 1 3
chown root: /dev/null
# https://askubuntu.com/questions/435887/i-can-read-from-dev-null-how-to-fix-it
# https://www.gnu.org/software/coreutils/manual/html_node/mknod-invocation.html#mknod-invocation

# View fonts.
gnome-font-viewer /usr/share/fonts/opentype/freefont/FreeSans.otf
fontforge /usr/share/fonts/opentype/freefont/FreeSans.otf
display /usr/share/fonts/opentype/freefont/FreeSans.otf

# Display format of core dump filename.
sysctl kernel.core_pattern
cat /proc/sys/kernel/core_pattern

# Display security setting for performance events.
sysctl kernel.perf_event_paranoid
# Set it to something different.
sudo sysctl kernel.perf_event_paranoid=-1
sudo sysctl kernel.nmi_watchdog=0

# Send a notification at a later time.
printf 'DISPLAY=:0.0 zenity --info --text "check your email"' | at now + 1 minutes
at now +1 minutes <<< 'DISPLAY=:0.0 zenity --info --text "check your email"'

# Test it before doing it.
at now <<< 'DISPLAY=:0.0 zenity --info --text "check your email"'

# Get a view of a truetype glyph as a PNG image
# https://stackoverflow.com/questions/17142331/convert-truetype-glyphs-to-png-image#24754489
# https://stackoverflow.com/questions/2672144/dump-characters-glyphs-from-truetype-font-ttf-into-bitmaps

# Man pages with the --dry-run flag.
man -wK -- '--dry-run'

# List locallly installed packages.
apt list --installed | grep '\[installed,local\]'

# Get UID in a non-bash shell that doesn't have it as an automatic variable.
id -u $USER

# Quick move into a subdirectory call 'needle'.
cd */needle

# Find files not owned by the current user in the current directory.
find . \! -user $USER

# Fix files owned by root.
find . \! -user $USER -exec sudo chown $USER: '{}' \+

# The part that changes who owns it.
chown $USER: myfile.txt

# Grepping red text.
shatag -l | grep '\[31;1m'

# Show attached storage systems.
lsblk -f
# Example output:
# NAME   FSTYPE LABEL          UUID                                 MOUNTPOINT
# sda
# ├─sda1 ext4                  0f650fbc-1ff4-4f24-8fa9-63dbcc1269fc /
# ├─sda2
# └─sda5 swap                  acc8416d-4167-43d9-8b8e-0e28182fbf3f
# sdb
# └─sdb1 ext4   hgst-tb-backup 47bf6ced-03fe-4086-90c7-5d71c57979dd
# sr0

# Look at repo status, but only recurse one level down.
mr -q -n 1 status
mr --quiet --no-recurse 1 status

# Show list of virtual machines.
virsh list --all

# Get list of exec keys.
grep -h '^Exec=' /etc/xdg/autostart/*.desktop

# debug login scripts.
echo exit | strace -o strace.log bash -li
# https://unix.stackexchange.com/questions/334382/find-out-what-scripts-are-being-run-by-bash-on-startup

# Show size of all windows.
wmctrl -lG
# https://askubuntu.com/questions/27894/get-window-size-in-shell

# Log out of gnome session.
gnome-session-quit --logout --no-prompt

# Run `desktop-file-validate` on all desktop files.
find . -name '*.desktop' | xargs -d '\n' desktop-file-validate 2>&1 | less
# Use null delimiters instead.
find . -name '*.desktop' -print0 | xargs --null desktop-file-validate 2>&1 | less

locate '*.desktop' | xargs -d '\n' grep 'URL=file://' | less
locate '*.desktop' | xargs -d '\n' grep -h 'Icon=' | sort | uniq | vim -

locate '*.desktop' | xargs -L 1 -d '\n' basename | sort -u | less -c


locate -0 '*.tex' | xargs -0 grep -l 'newdimens' | less -c
locate '*.tex' | grep nathaniel  | xargs -d '\n' grep -l 'newdimens' | less -c

# Does not work with spaces in filenames:
grep -l 'newdimens' "$(locate *.tex)"
for file in "$(locate *.tex)" ; do grep -l 'newdimens' "$file" ; done

# Generate 10 pronounceable passwords (lowercase letters and a number).
apg -n 10 -M Ln
# Use only lowercase letters.
apg -n 10 -M L

# 10 pronounceable passwords, minimum of 8 letters, maximum of 16.
apg -n 10 -m 8 -x 16 -M L

# Find which process is holding a lock file.
sudo lslocks | grep /var/lib/tor/lock
# tor              1322  FLOCK     0B WRITE 0          0          0 /var/lib/tor/lock
sudo lsof /var/lib/tor/lock
# COMMAND  PID       USER   FD   TYPE DEVICE SIZE/OFF     NODE NAME
# tor     1322 debian-tor    8uW  REG    8,2        0 28836693 /var/lib/tor/lock
sudo lsof /var/cache/apt/archives/lock

# TODO: find out how to send a notification when /var/cache/apt/archives/lock is released.

# Prevent watch from being overflowed and wrapping lines.
cut -c 1-$COLUMNS
# specifically, use it like this:
watch "head -c $(($COLUMNS+9)) /dev/zero | tr '\0' '+' | cut -c 1-$COLUMNS"
# https://stackoverflow.com/questions/1616404/cat-file-with-no-line-wrap

# Show at the top of the screen right away with less.
for i in $(seq 1 10); do printf '%s\n' "$i"; sleep 1; done | less -c
for i in $(seq 1 10); do printf '%s\n' "$i"; sleep 1; done | less --clear-screen
# /home/nathaniel/archive/2018/personal/src/shell/less-clear-screen-example/

# Show task list every 2 seconds.
watch 'task list | cut -c 1-80'

# Indent a file by 4 spaces.
sed 's/^/    /' example.py > example_indented.py

# Indent every non-blank line by 4 spaces.
sed 's/^.\+$/    &/' example.py > example_nonblank_indented.py
# Explanation:
# s     substitute
# ^.\+$ non-blaink line
#     & four spaces followed by matching line
# https://www.gnu.org/software/sed/manual/html_node/The-_0022s_0022-Command.html

# This will not work, because it puts a newline after the four spaces
sed '/./i\    ' example.py
# https://www.gnu.org/software/sed/manual/html_node/Other-Commands.html#index-i-_0028insert-text-lines_0029-command

# See distribution of OOM killer scores.
cat /proc/*/oom_score | maphimbu -g 1

# Show structure of timezone data file.
zdump -v /etc/localtime
# https://askubuntu.com/questions/31842/how-to-read-time-zone-information

# Example of showing where a symlink terminates.
realpath /etc/mtab
# /proc/8289/mounts

# Do a long search without disrupting other applications.
nice -n 19 ionice -c 3 ag -l mysearchstring ~/path/to/file/ | less -c
nice -n 19 ionice -c 3 ag -G '.*\.py$' -l 'import nltk' ~/src/ | less -c

# Check terminal color scheme.
msgcat --color=test
# https://www.gnu.org/software/gettext/manual/html_node/The-TERM-variable.html

DISPLAY=:0 kwin --replace & disown
# https://askubuntu.com/questions/213680/how-to-restart-kwin-when-it-is-hung

DISPLAY=:0 plasmashell & disown
# https://askubuntu.com/questions/213680/how-to-restart-kwin-when-it-is-hung

# Log out of KDE plasma 5 desktop from the command line.
qdbus org.kde.ksmserver /KSMServer logout 0 0 0
# https://forum.kde.org/viewtopic.php?t=88022
# https://askubuntu.com/questions/1871/how-can-i-safely-shutdown-reboot-logout-kde-from-the-command-line

# Show extended attributes of a file.
getfattr -d -m ".*" /path/to/file
# https://superuser.com/questions/858210/can-you-show-list-all-extended-attributes-and-how
# https://unix.stackexchange.com/questions/300168/how-do-i-get-a-dump-of-all-extended-attributes-for-a-file

# Add .gitignore files to empty directories so git can track them.
find . -name .git -prune -o -type d -empty -exec touch {}/.gitignore \;
# https://stackoverflow.com/questions/115983/how-can-i-add-an-empty-directory-to-a-git-repository/29884569#29884569

xapian-delve ~/.recoll/xapiandb/
# UUID = 60c1ac4d-7d69-498f-b06b-2917ab6d8184
# number of documents = 84333
# average document length = 7304.52
# document length lower bound = 17
# document length upper bound = 2062714
# highest document id ever used = 89057
# has positional information = true
# currently open for writing = false
# https://xapian.org/docs/admin_notes.html#inspecting-a-database
# https://getting-started-with-xapian.readthedocs.io/en/latest/practical_example/indexing/verifying_the_index.html
xapian-delve -1 -A Q/home/nathaniel/path/to/file/ ~/.recoll/xapiandb/

# See record information.
xapian-delve -r 1 -d ~/.recoll/xapiandb/
# Data for record #1:
# url=file:///home/nathaniel/.zotero/zotero/vt5s686l.default/zotero/storage/CGQQTDFV/Ianculescu-2007-BF-BT-ferromagnetism.pdf
# mtype=application/pdf
# fmtime=01350055089
# origcharset=CP1252
# fbytes=417170
# pcbytes=417170
# dbytes=20415
# sig=4171701580528861
# caption=Microsoft Word - BiFeO3-BaTiO3_corr.doc
# abstract=?!#@  Preparation and Properties of (1-x)BiFeO3 – xBaTiO3 Solid Solutions with Multiferroic Character A. Ianculescu1, L. Mitoşeriu2*, H. Chiriac3, M. M. Carnasciali4, A. Brăileanu5 and R. Truşcă6 1 Polytechnics University of Bucharest, 1-7 Gh.
# author=LMitoseriu - PScript5.dll Version 5.2
# filename=Ianculescu-2007-BF-BT-ferromagnetism.pdf

Term List for record #1:

# Check if /tmp/ is tmpfs or not.
df -T /tmp
# Filesystem     Type 1K-blocks      Used Available Use% Mounted on
# /dev/sda2      ext4 959863856 569432724 341602924  63% /
# https://unix.stackexchange.com/questions/118471/how-can-i-check-to-see-if-the-tmp-directory-on-my-centos-5-x-system-is-mounted

# Contrast with something that is mounted as tmpfs:
df -T /run/user/$UID/systemd/
# Filesystem     Type  1K-blocks  Used Available Use% Mounted on
# tmpfs          tmpfs   1630560   120   1630440   1% /run/user/1000

# Check if /tmp/ is tmpfs or not.
stat -f /tmp
#  File: "/tmp"
#    ID: f4fafbe673c2d070 Namelen: 255     Type: ext2/ext3
#Block size: 4096       Fundamental block size: 4096
#Blocks: Total: 239965964  Free: 97607780   Available: 85400728
#Inodes: Total: 61022208   Free: 58655435

stat -f /run/user/$UID/systemd/
#  File: "/run/user/1000/systemd/"
#    ID: 0        Namelen: 255     Type: tmpfs
#Block size: 4096       Fundamental block size: 4096
#Blocks: Total: 407640     Free: 407626     Available: 407626
#Inodes: Total: 2038203    Free: 2038147
#/run/user/$UID/systemd/

# Another way to check if /tmp/ is tmpfs or not.
findmnt -T /tmp
#TARGET SOURCE    FSTYPE OPTIONS
#/      /dev/sda2 ext4   rw,relatime,errors=remount-ro,data=ordered

# https://unix.stackexchange.com/questions/149660/mount-info-for-current-directory
findmnt -T /run/user/$UID/systemd/
#TARGET         SOURCE FSTYPE OPTIONS
#/run/user/1000 tmpfs  tmpfs  rw,nosuid,nodev,relatime,size=1630560k,mode=700,uid=1000,gid=1000


# Dereference a symlink and turn it into a copy of the target.
cp --remove-destination source-file.txt copy-of-file.txt
# https://stackoverflow.com/questions/9371222/cp-command-to-overwrite-the-destination-file-which-is-a-symbolic-link

# Make a copy of a symbolic link.
cp -P mylink mylink-copy

# Find the process running on localhost:8384
lsof -iTCP:8384 -sTCP:LISTEN

# List all .desktop files with a line containing the string 'URL=http',
# skipping directories that match the pattern '*.git'
grep -r -l --include='*.desktop' --exclude-dir='*.git' 'URL=http'

# Look at some recent errors without repeats.
journalctl -o cat | grep -i error | uniq | less +G

# Setting environment variables in pipelines:
DEBUG=1 printenv DEBUG # works
true | DEBUG=1 printenv DEBUG # works
DEBUG=1 true | printenv DEBUG # doesn't work

# Concatenate a bunch of files and include the filename as a header.
tail -n +1 * | tee ../combined.txt | less
head -n -0 * | tee ../combined.txt | less
# https://stackoverflow.com/questions/5917413/concatenate-multiple-files-but-include-filename-as-section-headers

# Look at systemd journal longs from the last hour.
journalctl --since '1 hour ago' --until 'now'
journalctl --since '-1 hour' --until 'now'

# Since last reboot.
journalctl --boot --lines=all | less

# Get screenshot on an android device.
adb shell screencap -p /sdcard/screen.png
# Copy the screenshot to current directory.
adb pull /sdcard/screen.png
# https://blog.shvetsov.com/2013/02/grab-android-screenshot-to-computer-via.html

snap info plexmediaserver
sudo snap install plexmediaserver
sudo snap install --beta plexmediaserver
sudo snap refresh plexmediaserver

# Install skype.
sudo snap install --classic skype

# Update all snap packages,
# like apt-get upgrade.
sudo snap refresh

# Generate PostScript output from a text file.
enscript -f Helvetica-Narrow12 example.txt -p example.ps
# Modify from the default header.
enscript -b '$N page $% of $=' -B Helvetica-Narrow12 -f Helvetica-Narrow12 example.txt -p example.ps
# ~/archive/2019/personal/src/make/enscript-example/Makefile
# Get list of font options.
cut -f 1 /usr/share/enscript/afm/font.map

# Find JSON that hasn't been formatted.
find . -name '*.json' -exec wc -l '{}' \+ | sort -n | less

# See XDG setting for default web browser.
xdg-settings get default-web-browser
# Equivalent command for KDE desktop:
kreadconfig5 --file kdeglobals --group General --key BrowserApplication

# Set the default browser to firefox.
xdg-settings set default-web-browser firefox.desktop

# Look up printer info.
/usr/lib/cups/backend/snmp 192.168.0.11
# network lpd://BRWB05216CD7EC3/BINARY_P1 "Brother HL-L2340D series" "Brother HL-L2340D series" "MFG:Brother;CMD:PJL,HBP,URF;MDL:HL-L2340D series;CLS:PRINTER;CID:Brother Laser Type1;URF:W8,CP1,IS4-1,MT1-3-4-5-8,OB10,PQ4,RS300-600,V1.3,DM1;" "Home"

# Infer / guess a file encoding.
file -bi mystery-file.txt
# https://superuser.com/questions/301552/how-to-auto-detect-text-file-encoding
# https://stackoverflow.com/questions/48729215/how-to-check-character-encoding-of-a-file-in-linux

# Look at image information of a remote file.
curl -s 'https://matplotlib.org/_images/stinkbug.png' | file -
# /dev/stdin: PNG image data, 500 x 375, 8-bit grayscale, non-interlaced
# https://github.com/matplotlib/matplotlib/issues/11296

sudo chvt 2
# Change to virtual terminal 2, like Ctrl-Alt-F2.

file /usr/bin/plasmashell
# /usr/bin/plasmashell: ELF 64-bit LSB shared object, x86-64, version 1 (GNU/Linux), dynamically linked, interpreter /lib64/l, for GNU/Linux 3.2.0, BuildID[sha1]=5ea1f3f7b9124a0174abd8be8eb1a4a4c1a1ad55, stripped
file /usr/lib/debug/.build-id/5e/a1f3f7b9124a0174abd8be8eb1a4a4c1a1ad55.debug
# /usr/lib/debug/.build-id/5e/a1f3f7b9124a0174abd8be8eb1a4a4c1a1ad55.debug: ELF 64-bit LSB shared object, x86-64, version 1 (GNU/Linux), dynamically linked, interpreter *empty*, for GNU/Linux 3.2.0, BuildID[sha1]=5ea1f3f7b9124a0174abd8be8eb1a4a4c1a1ad55, with debug_info, not stripped

# Show whether the OS is 32-bit or 64-bit.
getconf LONG_BIT
# https://askubuntu.com/questions/41332/how-do-i-check-if-i-have-a-32-bit-or-a-64-bit-os/41334#41334

# Print graphics driver information.
glxinfo
# "The glxinfo program shows information about the OpenGL and GLX implementations running on a given X display."

# Update the timestamps on all tex files.
find . -name '*.tex' -exec touch '{}' \+

# Run cron daemon / cron jobs at lower CPU priority.
sudo systemctl edit cron.service
# edits go to /etc/systemd/system/cron.service.d/override.conf
# I use this:
# [Service]
# Nice=19
# CPUSchedulingPolicy=idle
# IOSchedulingClass=idle

# Stop cron jobs from running.
sudo systemctl stop cron.service

# Start cron jobs running again.
sudo systemctl start cron.service

# Suppress fully blank lines.
sed '/^$/d'
# another method using grep:
grep .
# https://serverfault.com/questions/252921/how-to-remove-empty-blank-lines-from-a-file-in-unix-including-spaces

# List sound outputs.
pactl list short sinks

# Print an error message to stderr.
printf 'Error: something has gone wrong.\n' >&2
# Or put it out front to make it more obvious.
>&2 printf 'Error: something has gone wrong.\n'

# Get page 13 of a DJVU file and convert it to TIFF.
ddjvu -format=tiff -pages=13 input_file.djvu output_file.tiff
# https://askubuntu.com/questions/46233/converting-djvu-to-pdf

# Convert a DJVU file to PDF.
ddjvu -format=pdf -quality=85 input_file.djvu out.pdf
# https://askubuntu.com/questions/46233/converting-djvu-to-pdf

# Convert a DJVU file to PostScript, then to PDF.
djvups input.djvu | ps2pdf - output.pdf

# Test the X server is working.
xlogo
xclock
xload
xeyes
ico -sleep .05

# Run GDB on existing Firefox.
gdb /usr/lib/firefox/firefox -p $(pgrep firefox)

# Run and sort command output in tandem using a command group.
{ echo $RANDOM; echo $RANDOM; echo $RANDOM; } | sort -n
# 7647
# 9659
# 28126
{ printf '7\n5\n3\n' ; printf '10\n8\n6\n' ; printf '4\n3\n2\n1\n' ; } | sort -n
# https://www.gnu.org/software/bash/manual/html_node/Command-Grouping.html
# https://stackoverflow.com/questions/11917708/pipe-multiple-commands-into-a-single-command
# https://stackoverflow.com/questions/17983777/shell-pipe-to-multiple-commands-in-a-file

# Alternately, use a subshell:
( echo $RANDOM; echo $RANDOM; echo $RANDOM ) | sort -n
( printf '7\n5\n3\n' ; printf '10\n8\n6\n' ; printf '4\n3\n2\n1\n' ) | sort -n

# Alternately, use process substitution:
sort -n <( echo $RANDOM ) <( echo $RANDOM ) <( echo $RANDOM)
sort -n <( printf '7\n5\n3\n' ) <( printf '10\n8\n6\n' ) <( printf '4\n3\n2\n1\n' )
# Equivalent to:
sort -n /dev/fd/61 /dev/fd/62 /dev/fd/63

# List available scanners.
scanimage -L

# Show if a sudo session is active.
if sudo -vn 2>/dev/null; then printf 'active sudo session\n'; fi
if sudo -n true 2>/dev/null; then printf 'active sudo session\n'; fi
# https://superuser.com/questions/195781/sudo-is-there-a-command-to-check-if-i-have-sudo-and-or-how-much-time-is-left
# https://stackoverflow.com/questions/122276/quickly-check-whether-sudo-permissions-are-available
# https://stackoverflow.com/questions/3858208/sudo-is-there-a-command-to-check-if-i-have-sudo-and-or-how-much-time-is-left
# error message when it isn't active: "sudo: a password is required"

# Create a blank letter-size pdf.
convert xc:none -page Letter blank-letter-size.pdf
# '-page Letter' is short for '-page 612x792'.
convert xc:none -page 612x792 blank-letter-size.pdf
# https://imagemagick.org/script/command-line-options.php#page
# Units are PostScript typographic points (1 inch / 72 ≈ 0.3528 mm).
# https://en.wikipedia.org/wiki/Point_(typography)

# Intentionally use up 4 CPU cores.
stress --cpu 4

# Example from the man page:
stress --cpu 8 --io 4 --vm 2 --vm-bytes 128M --timeout 10s

# Run octave in the terminal.
octave --no-gui

# Get PNG file metadata
identify -verbose example.png
# https://stackoverflow.com/questions/8113314/does-png-support-metadata-fields-like-author-camera-model-etc
# https://superuser.com/questions/219642/what-software-can-i-use-to-read-png-metadata

# Extract text from a PDF file.
pdftotext myfile.pdf outfile.txt

jupyter kernelspec list

find . -name '*.png' | feh --file -

# Show where `man' looks for manpages, including MANPATH.
man -w

# Interactive audio signal / tone / sound generator with various waveforms (stereo mode).
siggen -2
# https://unix.stackexchange.com/questions/82112/stereo-tone-generator-for-linux
# https://unix.stackexchange.com/questions/245897/audio-tone-sine-generator-with-frequency-gauge
# with alsa-oss compatibility library:
aoss siggen -2
# with PulseAudio OSS Wrapper (pulseaudio-utils):
padsp siggen -2

# Convert PDF to PNG without imagemagick.
pdftocairo -png -rx 300 -ry 300 input.pdf out
# creates out-1.png, out-2.png, etc.
pdftoppm -png -rx 300 -ry 300 input.pdf out
# creates out-1.png, out-2.png, etc.

# Get font metadata, also works on TrueType Fonts (TTF) files.
otfinfo --info /usr/share/fonts/truetype/liberation/LiberationSans-Regular.ttf
# Family:              Liberation Sans
# Subfamily:           Regular
# Full name:           Liberation Sans
# PostScript name:     LiberationSans
# Version:             Version 1.07.4
# Unique ID:           Ascender - Liberation Sans
# Designer:            Steve Matteson
# Designer URL:        http://www.ascendercorp.com/typedesigners.html
# Manufacturer:        Ascender Corporation
# Vendor URL:          http://www.ascendercorp.com/
# Trademark:           Liberation is a trademark of Red Hat, Inc. registered in U.S. Patent and Trademark Office and certain other jurisdictions.
# Copyright:           Copyright (c) 2007 Red Hat, Inc. All rights reserved. LIBERATION is a trademark of Red Hat, Inc.
# License URL:         https://fedoraproject.org/wiki/Licensing/LiberationFontLicense
# License Description: Licensed under the Liberation Fonts license, see https://fedoraproject.org/wiki/Licensing/LiberationFontLicense
# Vendor ID:           1ASC

# Using magic-wormhole.
# On sending machine:
wormhole send myfile.txt
# > Sending ... file name 'myfile.txt'
# > One the other computers, please run: wormhole receive
# > Wormhole code is: 5-october-stockman
# On receiving machine:
wormhole receive

# List all the package names starting with "libstdc++".
apt-cache pkgnames "libstdc++"
# Just get the debug packages.
apt-cache pkgnames "libstdc++" | grep dbg | less

# See what environment variables the `date` command uses.
ltrace -f -e getenv -o my-ltrace-01.log date

journalctl --list-boots

journalctl _PID=28097

# Verbose debug info for a makefile.
make -qp

# Get default display manager.
cat /etc/X11/default-display-manager
# e.g. /usr/bin/sddm
# https://askubuntu.com/questions/584373/how-to-check-using-the-command-line-which-display-manager-is-running

# See Dropbox syncing progress.
cd ~/Dropbox/
dropbox filestatus
# Example output:
# .dropbox:          unwatched
# .dropbox.cache:    unwatched
# .icons:            up to date
# 2020-06-11:        up to date
# Apps:              up to date
# archive:           syncing
# calibre-libraries: up to date
# Camera Uploads:    up to date
# import:            up to date
# keepass:           up to date
# Public:            up to date
# Screenshots:       up to date
# Shared_Folders:    up to date
# temp:              up to date
# writings:          up to date
# zim-wiki:          up to date

# Get a random process ID (PID).
ps -eo pid | tail -n +2 | shuf -n 1

# Get all but the first line.
tail -n +2
# https://stackoverflow.com/questions/7318497/omitting-the-first-line-from-any-linux-command-output

# Test a process looking at PIDs.
watch --errexit -n 1 'ps -fp $(ps -eo pid | tail -n +2 | shuf -n 1)'

# Visit the realpaths of all symbolic links.
find . -type l | xargs realpath | visit_paths.py

# End a sudo session early.
sudo -k

# Streaming a YouTube video to VLC media player.
youtube-dl -o - 'https://www.youtube.com/watch?v=BaW_jenozKcj' | vlc -

# Debug Nautilus.
nautilus --gdk-debug=events,misc,dnd,color-context,xim --gtk-debug=objects,misc,signals,dnd,plugsocket

# See texlive documentation files for the siunitx package.
texdoc -l -s siunitx
# Example output:
#  1 /usr/share/texlive/texmf-dist/doc/latex/siunitx/siunitx.pdf
#    = Package documentation
#  2 /usr/share/texlive/texmf-dist/doc/latex/siunitx/README.md
#    = Readme
# Enter number of file to view, RET to view 1, anything else to skip:
# ~/archive/2015/not-iit-or-research-2015/src/python/cmd_oysters/cmdoysters/6f1c574e-9500-4656-88e0-77755721a1d7.json

# Show package names starting with "libstdc++".
apt-cache --no-generate pkgnames "libstdc++" | less

# Show mr custom subcommand (uploadcandidate)
mr -q uploadcandidate

# Get GNOME version.
cat /usr/share/gnome/gnome-version.xml

# Increase / decrease volume on KDE plasma.
qdbus org.kde.kglobalaccel /component/kmix org.kde.kglobalaccel.Component.invokeShortcut 'increase_volume'
qdbus org.kde.kglobalaccel /component/kmix org.kde.kglobalaccel.Component.invokeShortcut 'decrease_volume'

# Get e.g. PostScript name of a TrueType font.
otfinfo -i /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf | less
otfinfo -i /usr/share/fonts/truetype/dejavu/DejaVuSans.ttf | grep 'PostScript name:'

# Interactive disk usage explorer that runs in the terminal.
ncdu

# Force insync to sync current directory.
insync force_sync $(pwd -P)

# Notify when insync's syncing status changes.
watch -g 'insync get_status'; espeak 'insync is done syncing'

# Debug a Qt-based application and save the logged output.
QT_LOGGING_RULES="*.info=true;*.debug=true" keepassxc 2>&1 | tee keepassxc_debug_log_$(date +%F_%H_%M_%S_%s_%N).txt | less
# Alternative: ~/.config/QtProject/qtlogging.ini
# https://www.qt.io/blog/2014/03/11/qt-weekly-1-categorized-logging

# Format a JSON file in place.
python3 -m json.tool < my-json-data.json | sponge my-json-data.json

# View WEBP image.
vwebp example.webp

# Run older version of Thunderbird on a newer profile.
thunderbird --allow-downgrade --ProfileManager
# https://askubuntu.com/questions/1201870/thunderbird-68-3-1-profile-how-to-install-in-ubuntu-18-04
# https://askubuntu.com/questions/1226247/you-have-launched-an-older-version-of-thunderbird

# Ping Google's DNS servers and show timestamp.
ping -D 8.8.8.8

# Refresh all executables in $PATH (for bash shell).
hash -r

# Refresh a single command.
hash -d my-script.sh

# Find glob patterns corresponding to two or mimetypes.
sed '/^#/d' /usr/share/mime/globs ~/.local/share/mime/globs | sort -u | cut -d: -f 2 | sort | uniq -d | less

# Convert an RIS file to BibTeX and copy to clipboard.
ris2xml example.ris | xml2bib | xsel -b

# Dump a tzdata file.
zdump /etc/localtime
zdump -v /etc/localtime
# https://unix.stackexchange.com/questions/85925/how-can-i-examine-the-contents-of-etc-localtime

# Find setuid executables.
find /bin -perm -4000
# https://linux-audit.com/finding-setuid-binaries-on-linux-and-bsd/

ffprobe -loglevel error -select_streams v:0 -show_entries packet=pts_time,flags -of csv=print_section=0 myvideo.mp4

ffprobe -select_streams v -show_frames -show_entries frame=pict_type -of csv myvideo.mp4

ffprobe -select_streams v -show_frames myvideo.mp4

# Find paths at least 260 characters long.
find . -regextype 'posix-extended' -regex '.{260,}' | less

# Stamp PostScript onto PDF.
ps2pdf overlay.ps | pdftk input.pdf stamp - output output.pdf
# https://gitlab.com/pdftk-java/pdftk/-/issues/57
ps2pdf overlay.ps | pdftk input.pdf stamp /dev/stdin output output.pdf

# Get bash history without line numbers.
history | cut -c 8- # works as long as history is not too long.
history | awk '{$1="";print substr($0,2)}'
history -w /dev/stdout # requires access to /dev/stdout
# https://stackoverflow.com/questions/7110119/bash-history-without-line-numbers

# Get just the systemctl commands.
history -w /dev/stdout | grep '^systemctl' | sort -u | less

# Copy a symbolic link.
cp -P /path/to/my-symlink /the/path/to/new-symlink
# https://unix.stackexchange.com/questions/56084/how-do-i-copy-a-symbolic-link

# Alternative method to copy symbolic links.
cp -a --preserve=links /path/to/my-symlink /the/path/to/new-symlink
# https://superuser.com/questions/138587/how-to-copy-symbolic-links

# Get MP3 metadata.
ffprobe my_file.mp3 2>&1 | less
ffprobe -loglevel error -show_entries format_tags=title,artist,album,date my_file.mp3 2>&1 | less
# [FORMAT]
# TAG:album=Good Luck
# TAG:title=Good Luck
# TAG:artist=Broken Bells
# TAG:date=2019
# [/FORMAT]
ffprobe -loglevel error -show_entries format_tags=title,artist,album,date -of default=noprint_wrappers=1:nokey=1 my_file.mp3 2>&1 | less
# Good Luck
# Good Luck
# Broken Bells
# 2019

# Create a core dump of a running process.
gcore 4413 -o my-process-id.core

# This doesn't work:
dpkg -L 'apt-*' | less
# This does work:
dpkg -L $(apt-cache pkgnames 'vlc-' | apt_is_installed.py) | less

# Show what bash options are enabled.
echo $-
# himBHs

# Add a white boarder around an image.
convert example.png -bordercolor "#FFFFFF" -border 1 example_border_1px.png


# Useful in Firefox developer toolbar.
# https://stackoverflow.com/questions/32743509/can-i-create-high-resolution-screenshots-in-firefox
:screenshot --dpr 4
:screenshot filename.png --dpr 4

# Show message of the day without needing to log in all over again.
cat /run/motd.dynamic

# Update message of the day.
sudo run-parts /etc/update-motd.d/

# Show if packages are pending.
/usr/lib/update-notifier/apt-check --human-readable
# https://askubuntu.com/questions/1001114/run-tty-script-every-time-i-open-a-gui-terminal

# Use pathchk command on all files under current directory.
find . -exec 'pathchk' --portability -- '{}' \; 2>&1 | less
# Faster version.
find . -exec 'pathchk' --portability -- '{}' \+ 2>&1 | less
# Don't complain about every filename over 14 characters.
find . -exec 'pathchk' -P -- '{}' \+ 2>&1 | less
# Also print every filename.
find . -print -exec 'pathchk' --portability -- '{}' \; 2>&1 | less

# Use xargs (faster).
find . -print0 | xargs --null pathchk --portability -- 2>&1 | less

# Eject an unmounted flash drive at /dev/sdc.
udisksctl power-off -b /dev/sdc

# Install package to run `perf' with current kernel.
sudo apt install linux-tools-`uname -r`

# Get performance statistics for a command, in this case `stress --cpu 1'
perf stat -dd stress --cpu 1

# Show performance info by process.
perf top

# Show what udisks is doing.
sudo udisksctl monitor

dir /b
# Windows command to just show files without extra information.
# /b  Displays a bare list of directories and files, with no additional information. The /b parameter overrides /w.
# https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/dir

systeminfo > systeminfo.txt
# Save Windows version information to a text file.

# Show files installed by a pip package.
pip show -f requests

# Example of bup ls on a drive.
bup -d /media/nathaniel/hgst-tb-backup/nathaniel/bup/ ls -a
# Outputs this:
# nathaniel-home

# Example of bup ls for the branch.
bup -d /media/nathaniel/hgst-tb-backup/nathaniel/bup/ ls -a /nathaniel-home
# Outputs e.g.
# 2017-06-17-005509
# ....
# 2020-06-01-094637
# latest

bup -d /media/nathaniel/hgst-tb-backup/nathaniel/bup/ ls -a /nathaniel-home/latest

# Example of restoring:
bup -d /media/nathaniel/hgst-tb-backup/nathaniel/bup/ restore -C test1 /nathaniel-home/latest/home/nathaniel

# run movemail manually
movemail /var/mail/nathaniel ~/.thunderbird/knqzw79a.beta/Mail/pop3.localhost/Inbox

# Convert from UTF-16 to UTF-8.
iconv --from-code UTF-16LE --to-code UTF-8 utf16.txt > utf8.txt
dos2unix -f -ul -n utf16.txt utf8.txt

# Take screenshot of a tty (i.e. framebuffer).
fbcat > screenshot_01.ppm
fbcat | pngtopng > screenshot_01.png

# Show process CPU status for process ID 3909 every 2 second.
pidstat -u -p 3909 2

# Rip a CD into the current directory as MP3 files.
abcde -a tag,move,playlist,clean -d /dev/cdrom -o mp3 -V -x
# tag: add tags to generated MP3s.
# move: move them into the current directory labeled with the artist and album.
# playlist: generate an M3U playlist.
# clean: remove the temporary WAV files generated.
# -V: show verbose output
# -x: eject CD when finished
abcde -a tag,move,playlist,clean -d /dev/cdrom -o mp3 -V -x

# Debug a bash script
bash -x my-script.sh 2>&1 | less
# send to output file
bash -x my-script.sh > debug.txt 2>&1

# Display frames per second as measured by OpenGL.
glxgears -info

# Dump a SQLite database.
sqlite3 metadata.db '.dump' > metadata.sql

# Compare two SQLite databases.
diffoscope metadata-old.db metadata-new.db

# Virtual environment.
sudo apt install python3.8-venv
python3.8 -m venv env
source env/bin/activate
python3 -m pip install yt-dlp
env/bin/yt-dlp -h
deactivate
# https://stackoverflow.com/questions/1534210/use-different-python-version-with-virtualenv

# Read out Windows shortcut files.
lnkinfo 'example - Shortcut.lnk'

# List probable graphical programs.
dpkg --search '*.desktop' | awk '{print $1}' | sed "s/://" | sort --unique
# https://askubuntu.com/questions/1091235/how-to-get-the-list-of-all-application-installed-which-has-gui

# Test SSH connection.
ssh -T git@github.com
# Save to log file.
ssh -v -E my-ssh-log.txt -T git@github.com
# Get SSH version.
ssh -V

# Attach to the most recent session.
tmux attach
# List sessions.
tmux ls
# Attach to session '1'
tmux attach -t 1
# Create new session named 'mysession'.
tmux new -s mysession
# https://arcolinux.com/everthing-you-need-to-know-about-tmux-panes/
# https://gist.github.com/andreyvit/2921703
# Detach from session: C-b d

# Windows Subsystem for Linux commands:

# Get Windows path corresponding to this path:
wslpath -w .
# Open Windows Explorer to current directory.
wslview .

# Terminator quad pane commands.
atop -pM
journalctl -xf
tail -f ~/.xsession-errors
dmesg -wT

# Ubuntu pro :-(
# https://ubuntu.com/pro/dashboard?
sudo pro attach $MY_PRO_TOKEN
