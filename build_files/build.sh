#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

#/ctx/packges/kernel.sh
/ctx/packages/pkgs.sh

systemctl enable podman.socket
