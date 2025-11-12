# DevuanWSL

Devuan Linux on WSL2 based on [VPraharsha03/DevuanWSL](https://github.com/VPraharsha03/DevuanWSL),
powered by [wsldl](https://github.com/yuk7/wsldl).

This fork is based on Excalibur released on 2025-11-02,
whose Debian cousin is Trixie aka. Debian 13.

## Disclaimer

THIS REPO IS NOT AFFILIATE TO THE OFFICIAL "DEVUAN LINUX" DISTRIBUTION IN ANY WAY!

## Install

1. Download installer zip from [releases](https://github.com/Vinfall/DevuanWSL/releases/tag/action-build)
2. (Optinally) verify hash to avoid file corruption
3. Extract all files in zip file to same directory (e.g. `D:\WSL\Devuan`)
4. Run `Devuan.exe` to extract rootfs and Register to WSL

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

It's suggested to compact the volume first as WSL does not free the space automatically:

```powershell
wsl --shutdown
cd "path\to\WSL\Devuan"
# requires Hyper-V feature
Optimize-VHD -Path .\ext4.vhdx -Mode Retrim -Confirm -Whatif # dry run
Optimize-VHD -Path .\ext4.vhdx -Mode Retrim -Confirm
```

`wsldl backup` mentioned in [#Usage](#usage) is recommended
as it does not require extra tools,
but you can use whatever method you like.

You can use native `wsl --export` + zstd to compress much faster:

```powershell
wsl --shutdown
# you need to install ZSTD on Windows (NOT inside WSL!)
cmd /c "wsl --export Devuan - | zstd -T0 -o Devuan-$(Get-Date -UFormat "%Y%m%d").tar.zst"
```

It's even possible to use bash+zstd via [cosmoscc][cosmoscc]
to avoid ZSTD on Windows or PowerlessShell:

```sh
bash-5.2$ wsl.exe --export Devuan - | zstd -T0 -o ./Devuan-$(date +'%Y%m%d').tar.zst
```

[cosmoscc]: https://github.com/jart/cosmopolitan#getting-started
