ARG FEDORA_VERSION=45
ARG KERNEL_VERSION=7.3.4-ogc9.1.fc${FEDORA_VERSION}.x86_64
#ARG BASE_IMAGE=ghcr.io/ublue-os/aurora:testing
ARG BASE_IMAGE=ghcr.io/ublue-os/aurora:testing-kde-nightly

FROM ghcr.io/ublue-os/akmods:ogc-${FEDORA_VERSION}-${KERNEL_VERSION} AS akmods
FROM ghcr.io/ublue-os/akmods-extra:ogc-${FEDORA_VERSION}-${KERNEL_VERSION} AS akmods-extra

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

# Base Image
#FROM ghcr.io/ublue-os/aurora:testing
FROM ${BASE_IMAGE} AS base

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=bind,from=akmods,source=/kernel-rpms,target=/tmp/kernel-rpms \
    --mount=type=bind,from=akmods,source=/rpms,target=/tmp/akmods-rpms \
    --mount=type=bind,from=akmods-extra,source=/rpms,target=/tmp/akmods-extra-rpms \
    /ctx/build.sh

RUN bootc container lint

FROM base AS nvidia
FROM ghcr.io/ublue-os/akmods-nvidia-open:ogc-${FEDORA_VERSION}-${KERNEL_VERSION} AS akmods-nvidia

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=bind,from=akmods,source=/kernel-rpms,target=/tmp/kernel-rpms \
    --mount=type=bind,from=akmods,source=/rpms,target=/tmp/akmods-rpms \
    --mount=type=bind,from=akmods-extra,source=/rpms,target=/tmp/akmods-extra-rpms \
    --mount=type=bind,from=akmods-nvidia-open,src=/rpms,dst=/tmp/rpms/nvidia \
    /ctx/build.sh

RUN bootc container lint
