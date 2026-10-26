#!/usr/bin/env bash

set -eoux pipefail

dnf remove -y \
    fish \
    zsh

# some bullshit to get nbfc working past 44
dnf install -y --allowerasing \
    lua5.4-libs \
    openssl3-devel \
    openssl3-libs

dnf config-manager enable \
    terra

dnf install -y \
    android-tools \
    https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.4/fedora-44-nbfc-linux-0.5.4-1.x86_64.rpm \
    mangohud \
    scx-scheds \
    scx-tools \
    testdisk \
    qphotorec \
    waydroid
