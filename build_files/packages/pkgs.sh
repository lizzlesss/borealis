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
    fedora-multimedia

dnf install -y \
    https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.4/fedora-44-nbfc-linux-0.5.4-1.x86_64.rpm \
    mangohud \
    steam \
    waydroid

dnf copr enable -y sirlucjan/scx-scheds-cargo

dnf install -y \
    scx-scheds-git

dnf copr disable -y sirlucjan/scx-scheds-cargo
