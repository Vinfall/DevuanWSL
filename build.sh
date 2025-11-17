#!/bin/bash
set -euo pipefail
IFS=$'\n\t'
# shellcheck disable=SC2035

download(){
    echo "Downloading wsldl..."
    curl -Lo icons.zip "https://github.com/yuk7/wsldl/releases/latest/download/icons.zip"
    echo "Downloading tarball..."
    curl -Lo rootfs.tar.xz "https://jenkins.linuxcontainers.org/view/Images/job/image-devuan/architecture=amd64,release=excalibur,variant=default/lastSuccessfulBuild/artifact/rootfs.tar.xz"
}

build(){
    echo "Extracting..."
    unzip -u icons.zip Devuan.exe

    echo "Packing wsl..."
    mkdir ziproot
    mkdir -p ziproot/usr/lib/wsl
    cp rootfs.tar.xz ziproot/rootfs.tar.xz

    tar -C ziproot -xf rootfs.tar.xz
    install -pm644 fs/etc/wsl-distribution.conf ziproot/etc/wsl-distribution.conf
    install -pm755 fs/usr/lib/wsl/oobe ziproot/usr/lib/wsl/oobe
    install -pm644 fs/usr/lib/wsl/devuan.ico ziproot/usr/lib/wsl/devuan.ico
    install -pm644 fs/usr/lib/wsl/terminal-profile.json ziproot/usr/lib/wsl/terminal-profile.json
    tar -C ziproot --numeric-owner --absolute-names --create . | pigz > Devuan.wsl
    # tar -C ziproot --numeric-owner --absolute-names --create . | gzip --best Devuan.wsl

    rm -rf ziproot
    sha512sum Devuan.wsl > Devuan.wsl.sha512

    echo "Packing zip..."
    cp rootfs.tar.xz ziproot/rootfs.tar.xz
    cp Devuan.exe ziproot/Devuan.exe
    zip -j Devuan.zip ziproot/*
    # sudo chown "$(whoami):$(whoami)" Devuan.zip
    sha512sum Devuan.zip > Devuan.zip.sha512
}

clean(){
    echo "Cleaning..."
    rm -rf ziproot Devuan.exe
    # rm -r icons.zip rootfs.tar.xz
}

download
build
clean
