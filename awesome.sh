#!/usr/bin/env bash

# run this and then ctrl+super+r to reconfigure awesome wm

set -xe
shopt -s dotglob

cp -vr ./.config/awesome/ "$HOME/.config/"