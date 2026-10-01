#!/usr/bin/env bash

set -eoux pipefail

# some bullshit to get nbfc working past 44
dnf install -y --allowerasing \
    lua5.4-libs \
    openssl3-devel \
    openssl3-libs

#dependencies for inputactions
dnf install -y git cmake extra-cmake-modules gcc-g++ qt6-qtbase-devel kwin-devel kf6-ki18n-devel kf6-kguiaddons-devel kf6-kcmutils-devel kf6-kconfigwidgets-devel qt6-qtbase qt6-qtdeclarative-devel kf6-kguiaddons kf6-ki18n wayland-devel yaml-cpp yaml-cpp-devel libepoxy-devel libevdev libevdev-devel libdrm-devel cli11-devel layer-shell-qt-devel

#inputactions
curl -o inputactions-installer.sh https://raw.githubusercontent.com/InputActions/installer/refs/heads/main/install.sh
chmod +x inputactions-installer.sh
./inputactions-installer.sh --ctl --kwin --overlay --latest

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
