#!/usr/bin/env bash

set -eoux pipefail

# some bullshit to get nbfc working past 44
dnf install -y --allowerasing \
    lua5.4-libs \
    openssl3-devel \
    openssl3-libs

dnf install -y \
    android-tools \
    mangohud \
    testdisk \
    qphotorec \
    https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.3/fedora-44-nbfc-linux-0.5.3-1.x86_64.rpm

# copr
dnf copr enable -y bieszczaders/kernel-cachyos-addons
dnf copr enable -y crono/system76-scheduler

dnf install -y \
    system76-scheduler-git

# Adds required package for the scheduler
dnf install -y \
    --enablerepo="copr:copr.fedorainfracloud.org:bieszczaders:kernel-cachyos-addons" \
    --allowerasing \
    scx-scheds-git scx-tools-git scx-manager

dnf copr disable -y crono/system76-scheduler
dnf -y copr disable bieszczaders/kernel-cachyos-addons
