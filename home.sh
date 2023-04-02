#!/usr/bin/env bash
set -xe
shopt -s dotglob

cp -vr ./.config "$HOME/"
home-manager -f "$HOME/.config/home-manager/home.nix" switch
