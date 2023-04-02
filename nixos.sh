#!/usr/bin/env bash
set -e
shopt -s dotglob

if [[ $# < 1 ]]; then
    >&2 echo "usage: $0 <arg1> <arg2> (args are forwarded to nixos-rebuild)"
    exit 1
fi

sudo cp -r ./configuration.nix /etc/nixos/
sudo nixos-rebuild $@
