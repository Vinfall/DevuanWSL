#!/bin/bash
set -euo pipefail
# shellcheck disable=SC2035

# download
# echo "Downloading wsldl..."
# curl --silent --location "https://github.com/yuk7/wsldl/releases/download/$(curl https://api.github.com/repos/yuk7/wsldl/releases/latest -s | jq .name -r)/icons.zip"
# echo "Downloading tarball..."
# curl --silent --localtion "https://jenkins.linuxcontainers.org/view/Images/job/image-devuan/architecture=amd64,release=excalibur,variant=default/lastSuccessfulBuild/artifact/rootfs.tar.xz"

# build
echo "Extracting..."
unzip -u icons.zip Devuan.exe

mkdir -p ziproot/usr/lib/wsl # mkdir ziproot
cp rootfs.tar.xz ziproot/

tar -C ziproot -xf rootfs.tar.xz
install -pm644 fs/etc/wsl-distribution.conf ziproot/etc/wsl-distribution.conf
install -pm755 fs/usr/lib/wsl/oobe ziproot/usr/lib/wsl/oobe
install -pm644 fs/usr/lib/wsl/devuan.ico ziproot/usr/lib/wsl/devuan.ico
install -pm644 fs/usr/lib/wsl/terminal-profile.json ziproot/usr/lib/wsl/terminal-profile.json
tar -C ziproot --numeric-owner --absolute-names --create . | pigz > ziproot/Devuan.wsl
# tar -C ziproot --numeric-owner --absolute-names --create . | gzip --best > ziproot/Devuan.wsl
shopt -s extglob
rm -r -- ziproot/!(Devuan.wsl)

cp Devuan.exe ziproot/Devuan.exe

zip -j Devuan.zip ziproot/*
sha512sum Devuan.zip > Devuan.zip.sha512

# clean
rm -rf ziproot Devuan.exe
# rm -r icons.zip rootfs.tar.xz
