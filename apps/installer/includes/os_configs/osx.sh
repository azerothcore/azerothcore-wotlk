brew update

##########################################
## workaround for cmake already being installed in the github runners
if ! command -v cmake &>/dev/null ; then
       brew install cmake
fi
##########################################

brew install openssl@1.1 readline boost bash-completion curl unzip mysql ccache

##########################################
## workaround to fix openssl in ci
#brew link --force openssl@1.1
cp /usr/local/opt/openssl@1.1/lib/pkgconfig/*.pc /usr/local/lib/pkgconfig/
#rm '/usr/local/bin/2to3'
##########################################
