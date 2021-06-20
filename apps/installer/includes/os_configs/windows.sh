echo "WARNING: Installer Script for Windows is not fully supported yet. Work in progress.."
echo "!!README!!: Please install openssl and mysql libraries manually following our wiki"

# install chocolatey before

@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# install automatically following packages:
# cmake
# git
# microsoft-build-tools
# mysql 5.6

choco install -y --skip-checksums cmake git git.install microsoft-build-tools
choco install -y --skip-checksums  mysql --version 5.6.12

echo "!!README!!: Please remember to install openssl and mysql libraries manually following our wiki"
