ARG FEDORA_VERSION=45
ARG KERNEL_VERSION=7.3.4-ogc3.1.fc${FEDORA_VERSION}.x86_64

FROM ghcr.io/ublue-os/akmods:ogc-${FEDORA_VERSION}-${KERNEL_VERSION} AS akmods
FROM ghcr.io/ublue-os/akmods-extra:ogc-${FEDORA_VERSION}-${KERNEL_VERSION} AS akmods-extra

# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx
COPY build_files /
COPY system_files /system_files

# Base Image
FROM ghcr.io/ublue-os/aurora-dx:testing

# RUN rm /opt && mkdir /opt

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=bind,from=akmods,source=/kernel-rpms,target=/tmp/kernel-rpms \
    --mount=type=bind,from=akmods,source=/rpms,target=/tmp/akmods-rpms \
    --mount=type=bind,from=akmods-extra,source=/rpms,target=/tmp/akmods-extra-rpms \
    /ctx/packages/kernel.sh && \
    rm -rf /ctx /tmp/* /var/tmp/* && \
    /ctx/build.sh

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
