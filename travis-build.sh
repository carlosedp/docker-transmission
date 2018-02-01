#!/bin/bash
set -e

# Prepare qemu
docker run --rm --privileged multiarch/qemu-user-static:register --reset

# Get qemu package
echo "Getting qemu package for $QEMU_ARCH"
mkdir tmp
pushd tmp
# Fake qemu for amd64 builds to avoid breaking COPY in Dockerfile
if [ $QEMU_ARCH == 'amd64' ]; then
    touch qemu-"$QEMU_ARCH"-static
else
    curl -L -o qemu-"$QEMU_ARCH"-static.tar.gz https://github.com/multiarch/qemu-user-static/releases/download/"$QEMU_VERSION"/qemu-"$QEMU_ARCH"-static.tar.gz
    tar xzf qemu-"$QEMU_ARCH"-static.tar.gz
fi
popd

# Build image
docker build -t $IMAGE:$TAG --build-arg target=$TARGET --build-arg QEMU_ARCH=$QEMU_ARCH .

# Test image
docker run --rm $IMAGE:$TAG uname -a
