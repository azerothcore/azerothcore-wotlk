##########################################
## workaround for python upgrade issue https://github.com/actions/runner-images/issues/6817
rm /usr/local/bin/2to3 || true
rm /usr/local/bin/2to3-3.10 || true
rm /usr/local/bin/2to3-3.11 || true
rm /usr/local/bin/2to3-3.12 || true
rm /usr/local/bin/idle3 || true
rm /usr/local/bin/idle3.10 || true
rm /usr/local/bin/idle3.11 || true
rm /usr/local/bin/idle3.12 || true
rm /usr/local/bin/pydoc3 || true
rm /usr/local/bin/pydoc3.10 || true
rm /usr/local/bin/pydoc3.11 || true
rm /usr/local/bin/pydoc3.12 || true
rm /usr/local/bin/python3 || true
rm /usr/local/bin/python3.10 || true
rm /usr/local/bin/python3.11 || true
rm /usr/local/bin/python3.12 || true
rm /usr/local/bin/python3-config || true
rm /usr/local/bin/python3.10-config || true
rm /usr/local/bin/python3.11-config || true
rm /usr/local/bin/python3.12-config || true
##########################################

brew update

##########################################
## workaround for cmake already being installed in the github runners
if ! command -v cmake &>/dev/null ; then
       brew install cmake
fi
##########################################

brew install openssl@3 readline boost bash-completion curl unzip mysql ccache
