##########################################
## workaround to fix macos-10.15 configure os from failing
brew reinstall openssl@1.1
rm '/usr/local/bin/2to3'
##########################################

brew update

##########################################
## workaround for cmake already being installed in the github runners
if ! command -v cmake &>/dev/null ; then
       brew install cmake
fi
##########################################

brew install openssl readline boost bash-completion curl unzip mysql ccache
