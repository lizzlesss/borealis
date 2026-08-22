#!/usr/bin/env bash

set -eoux pipefail

pacman -R --noconfirm power-profiles-daemon
pacman -Sy --noconfirm intel-lpmd tuned tuned-ppd curl wget alsa-firmware sof-firmware

wget https://github.com/nbfc-linux/nbfc-linux/releases/download/0.5.3/arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
pacman -U --noconfirm ./arch-linux-nbfc-linux-git-0.5.3-1-x86_64.pkg.tar.zst
