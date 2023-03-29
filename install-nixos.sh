#!/usr/bin/env bash
set -xe
shopt -s dotglob

sudo cp -vr ./etc/* /etc
sudo nixos-rebuild boot