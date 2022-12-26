##########################################
## workaround for python upgrade issue https://github.com/actions/runner-images/issues/6817
rm /usr/local/bin/2to3 || true
rm /usr/local/bin/2to3-3.10 || true
rm /usr/local/bin/2to3-3.11 || true
rm /usr/local/bin/idle3 || true
rm /usr/local/bin/pydoc3 || true
rm /usr/local/bin/python3 || true
rm /usr/local/bin/python3-config || true
##########################################

brew update

##########################################
## workaround for cmake already being installed in the github runners
if ! command -v cmake &>/dev/null ; then
       brew install cmake
fi
##########################################

brew install openssl@1.1 readline boost bash-completion curl unzip mysql ccache

##########################################
## workaround to fix openssl in ci until https://github.com/actions/virtual-environments/pull/4206 is merged
# ln -sf $(brew --cellar openssl@1.1)/1.1.1* /usr/local/opt/openssl
##########################################
