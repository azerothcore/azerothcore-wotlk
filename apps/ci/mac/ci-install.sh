#!/usr/bin/env bash

##########################################
## workaround to fix macos-10.15 configure os from failing
time brew reinstall openssl@1.1
##########################################

time brew update
time brew install openssl readline ace coreutils bash bash-completion mysql ccache

