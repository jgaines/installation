# Installs

The purpose of this repo is to document what tools I've installed and how I've
done it.  This is important for tools that I forget about for months/years and
then come back to having forgotten how I installed the tool.  This will also be
useful when I upgrade to a new machine or try to move my setup to some other
environment.

## Installation Tools

### Apt

Most of my machines have been Debian-based, so I use `apt` to install
packages.

#### Custom PPAs and Package Sources

This system uses the following custom PPAs and package sources in
`/etc/apt/sources.list.d/`:

- **Adoptium (Eclipse Temurin JDK)** - [installation](https://adoptium.net/installation/linux/)
  - Provides OpenJDK builds from Eclipse Foundation
- **Mesa RC** - [installation](https://launchpad.net/~ernstp/+archive/ubuntu/mesarc)
  - Release candidate builds of Mesa graphics drivers
- **Fish Shell** - [installation](https://launchpad.net/~fish-shell/+archive/ubuntu/release-4)
  - Modern shell with syntax highlighting and autosuggestions
- **Fury.io (NuShell & Carapace)** - [installation](https://www.nushell.sh/book/installation.html)
  - NuShell and rsteube's Carapace shell completion
- **GitHub CLI** - [installation](https://github.com/cli/cli/blob/trunk/docs/install_linux.md)
  - Official GitHub command line interface
- **Google Chrome** - [installation](https://www.ubuntuupdates.org/ppa/google_chrome)
  - Google Chrome web browser
- **vtrefny Tools** - [installation](https://software.opensuse.org/download/package?package=blivet-gui&project=home%3Avtrefny)
  - blivet-gui, some sort of disk management tool, OpenSUSE Build Service packages
- **Microsoft Products** - [installation](https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu)
  - Microsoft development tools and runtimes, might not need this now
- **Minetest** - [installation](https://launchpad.net/~minetestdevs/+archive/ubuntu/stable)
  - Open source voxel game engine
- **Modular** - [installation](https://docs.modular.com/mojo/manual/get-started/)
  - No longer need PPA for Modular(Mojo) as it is now installed via pixi, which is in turn installed via mise.
- **Mono** - [installation](https://www.mono-project.com/download/stable/#download-lin)
  - .NET framework implementation for Linux
- **Oracle VirtualBox** - [installation](https://www.virtualbox.org/wiki/Linux_Downloads)
  - Virtualization software
- **CKB Next** - [installation](https://launchpad.net/~tatokis/+archive/ubuntu/ckb-next-git)
  - Corsair keyboard/mouse driver and configuration tool
- **VS Code** - [installation](https://code.visualstudio.com/docs/setup/linux)
  - Microsoft Visual Studio Code editor
- **Warp Terminal** - [installation](https://www.warp.dev/linux)
  - Modern terminal with AI features
- **WineHQ** - [installation](https://wiki.winehq.org/Ubuntu)
  - Windows compatibility layer
- **FastFetch** - [installation](https://launchpad.net/~zhangsongcui3371/+archive/ubuntu/fastfetch)
  - System information tool (neofetch alternative)

### Mise

Mise is my preferred tool for installing bleeding-edge development and
productivity tools.

```bash
# Install mise
./install_mise.sh
```

For new Python versions, I like to run `mise use python@latest` to update
Python, that way it keeps the old versions. It will delete the latest version if
you include it in a normal upgrade, which will break and virtual environment
built on it.

The best way to backup the mise config is to copy the mise.toml file from
~/allmise.  As the way I use it, I `mise use` all tools in that folder, then use
~/bin/make-local-latest.sh to symlink all installed tools to my ~/.local/latest
directory.

```bash
# should reinstall most of the tools, some like Python have more than one version
cat ~/allmise/mise.toml | grep -vE '^[\[#]' | sed 's/ = "/@/g' | tr -d '"' | xargs -n1 echo
```

### uv tool

For python tools, I use the `uv` tool. I install uv through mise:

```bash
mise install uv
```

```bash
# to list all tools installed by uv
uv tool list | grep -vE '^-' | cut -d' ' -f1
```

### Homebrew

My fallback for installing tools is Homebrew.  I've run into some tools that
are easier to install with Homebrew, the downside is that it often installs a
lot of dependencies that are redundant with what I already have installed
through apt.

```bash
# Install dependencies for Homebrew on Debian/Ubuntu
sudo apt install build-essential procps curl file git
```

``` bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

```bash
# Update Homebrew and its list of packages
brew update
```

```bash
# Upgrade all installed packages
brew upgrade
```

```bash
# generate a Brewfile that can restore all installed packages
brew bundle dump --force --file=~/brewfile
```
