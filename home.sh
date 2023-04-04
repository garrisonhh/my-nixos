#!/usr/bin/env bash
set -xe
shopt -s dotglob

cp -vr ./.config "$HOME/"
home-manager switch --impure --flake "$HOME/.config/home-manager#garrison"
