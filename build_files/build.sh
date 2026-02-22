#!/bin/bash

set -ouex pipefail

/ctx/packages/kernel.sh
/ctx/packages/pkgs.sh 

systemctl enable podman.socket
