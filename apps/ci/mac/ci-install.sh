#!/usr/bin/env bash

# workaround to fix mac build from failing
time brew uninstall openssl@1.0.2t
time brew uninstall python@2.7.17
#time brew untap local/openssl
#time brew untap local/python2

time brew update
time brew upgrade
time brew install openssl readline ace coreutils bash bash-completion mysql ccache
