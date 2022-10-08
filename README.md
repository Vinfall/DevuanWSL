# DevuanWSL
Devuan Linux on WSL2 based on [DevuanWSL](https://github.com/VPraharsha03/DevuanWSL), powered by [wsldl](https://github.com/yuk7/wsldl).

This fork is based on Chimaera (current stable) in favor of the original Beowulf (oldstable).

![screenshot](https://github.com/Vinfall/DevuanWSL/blob/chimaera/img/screenshot.webp)

[![Github All Releases](http://img.shields.io/github/downloads/Vinfall/DevuanWSL/total.svg?style=flat-square)](https://github.com/Vinfall/DevuanWSL/releases/latest)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)
![License](https://img.shields.io/github/license/yuk7/AlpineWSL.svg?style=flat-square)


## Requirements
* Windows 10 1803 April 2018 Update x64 or later.
* Windows Subsystem for Linux feature is enabled.

## Install

1. Download installer zip from [release](https://github.com/Vinfall/DevuanWSL/releases/latest) or [actions](https://github.com/Vinfall/DevuanWSL/actions/workflows/action.yml?query=is%3Asuccess) (recommended)
2. Extract all files in zip file to same directory (e.g. `C:\WSL\Devuan`)
3. Run `Devuan.exe` to Extract rootfs and Register to WSL

Exe filename is using to the instance name to register.
If you rename it, you can register with a different name and have multiple installs.


## How-to-Use (for Installed Instance)
#### exe Usage
```dos
Usage :
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


#### How to uninstall instance
```powershell
.\Devuan.exe clean
```

## How-to-Build
DevuanWSL can build on GNU/Linux or WSL.

`curl`,`bsdtar`, `jq`, `sudo`, `tar`(gnu),`unzip` and `wget` is required for build.
```bash
# Install build tools
sudo apt install -y curl libarchive-tools jq tar unzip wget
# Make release
# Use of `sudo` recommended to avoid weird file permission in rootfs
sudo make
# Clean-up using `sudo` as some files are owned by root
sudo make clean
```
## Todo

- [x] Add CI (GitHub Actions)
- [ ] Write a WebHook to automatically fetch [Atom feed](https://jenkins.linuxcontainers.org/view/Images/job/image-devuan/architecture=amd64,release=chimaera,variant=default/rssAll) of the upstream build & trigger CI (not interested as we have nightly actions)
