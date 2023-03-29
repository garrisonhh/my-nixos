#!/usr/bin/env bash
set -xe
shopt -s dotglob

cp -vr ./home/* /home/$USER
home-manager switch --impure