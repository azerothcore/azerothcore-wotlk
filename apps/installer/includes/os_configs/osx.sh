# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##########################################
## workaround to fix macos-10.15 configure os from failing
brew reinstall openssl@1.1
##########################################

brew update

# brew install openssl readline cmake ace coreutils bash bash-completion md5sha1sum curl unzip mysql ccache

# workaround for cmake already being installed in the github runners
if ! command -v cmake &>/dev/null ; then
       brew install cmake
   fi
brew install openssl readline ace bash-completion curl unzip mysql ccache
