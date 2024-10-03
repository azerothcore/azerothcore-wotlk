#!/usr/bin/env sh

nixos-rebuild build-vm --flake .#test $@
