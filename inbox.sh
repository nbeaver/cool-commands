# Bash
attr -s com.dropbox.ignored -V 1 '/home/yourname/Dropbox (Personal)/YourFileName.pdf'
# https://help.dropbox.com/sync/ignored-files

# Powershell
Set-Content -Path 'C:\Users\yourname\Dropbox (Personal)\YourFileName.pdf' -Stream com.dropbox.ignored -Value 1
# https://help.dropbox.com/sync/ignored-files
