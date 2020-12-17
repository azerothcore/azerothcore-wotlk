# ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##########################################
## workaround to fix macos-10.15 configure os from failing
brew reinstall openssl@1.1
##########################################

brew update

# brew install openssl readline cmake ace coreutils bash bash-completion md5sha1sum curl unzip
brew install openssl readline cmake ace bash-completion curl unzip mysql ccache
