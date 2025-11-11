# DevuanWSL

Devuan Linux on WSL2 based on [DevuanWSL](https://github.com/VPraharsha03/DevuanWSL), powered by [wsldl](https://github.com/yuk7/wsldl).

This fork is based on Daedalus (current stable) in favor of the original Beowulf.

## Requirements

- Windows 10 1803 April 2018 Update x64 or later.
- Windows Subsystem for Linux feature is enabled.
- Latest WSL recommended.

## Install

1. Download installer zip from [release](https://github.com/Vinfall/DevuanWSL/releases/latest) or [monthly action build](https://github.com/Vinfall/DevuanWSL/releases/tag/action-build) (recommended)
2. Extract all files in zip file to same directory (e.g. `D:\WSL\Devuan`)
3. Run `Devuan.exe` to extract rootfs and Register to WSL

`Devuan.exe` is used as WSL distro label.
It's possible to have multiple installs by renaming it to something like `Dedede.exe`.

## Uninstall

```powershell
.\Devuan.exe clean
```

## Usage

<details><summary>Click to expand</summary>
<p>

```powershell
Usage:
  <no args>
    - Open a new shell with your default settings.

  run <command line>
    - Run the given command line in that distro. Inherit current directory.

  runp <command line (includes windows path)>
    - Run the path translated command line in that distro.

  config [setting [value]]
    - `--default-user <user>`: Set the default user for this distro to <user>
    - `--default-uid <uid>`: Set the default user uid for this distro to <uid>
    - `--append-path <on|off>`: Switch of Append Windows PATH to $PATH
    - `--mount-drive <on|off>`: Switch of Mount drives
    - `--default-term <default|wt|flute>`: Set default terminal window

  get [setting]
    - `--default-uid`: Get the default user uid in this distro
    - `--append-path`: Get on/off status of Append Windows PATH to $PATH
    - `--mount-drive`: Get on/off status of Mount drives
    - `--wsl-version`: Get WSL Version 1/2 for this distro
    - `--default-term`: Get Default Terminal for this distro launcher
    - `--lxguid`: Get WSL GUID key for this distro

  backup [contents]
    - `--tgz`: Output backup.tar.gz to the current directory using tar command
    - `--reg`: Output settings registry file to the current directory

  clean
    - Uninstall the distro.

  help
    - Print this usage message.
```

</p>
</details>

## Build

DevuanWSL can be built on GNU/Linux or WSL.

`curl`, `bsdtar`, `jq` and `unzip` is required for build.

```bash
# Install build tools
sudo apt install -y curl libarchive-tools jq unzip
# Make release
# Use `sudo` here as partitions mounted via WSL are owned by current user
# (e.g. UID 1000) but rootfs requires root aka. UID 0
sudo make
# Clean-up using `sudo` as some files are owned by root
sudo make clean
```

## Backup

Personally I prefer using native `wsl --export` + zstd over `wsldl backup` mentioned in [#Usage](#usage), but you can choose whichever you like.

```powershell
wsl --shutdown

# wsl --export + zstd, impressive compression
# you need to install ZSTD on Windows (NOT inside WSL!)
cmd /c "wsl --export Devuan - | zstd -T0 -o Devuan-$(Get-Date -UFormat "%Y%m%d").tar.zst"
```
