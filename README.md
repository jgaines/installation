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

- **Adoptium (Eclipse Temurin JDK)** - `adoptium.list`
  - Provides OpenJDK builds from Eclipse Foundation
- **Back In Time** - `bit-team-stable-jammy.list`
  - Backup tool for Linux
- **Mesa RC** - `ernstp-mesarc-jammy.list`
  - Release candidate builds of Mesa graphics drivers
- **Fish Shell** - `fish-shell-release-4-jammy.list`
  - Modern shell with syntax highlighting and autosuggestions
- **Fury.io (NuShell & Carapace)** - `fury.list`
  - NuShell and rsteube's Carapace shell completion
- **GitHub CLI** - `github-cli.list`
  - Official GitHub command line interface
- **Google Chrome** - `google-chrome.list`
  - Google Chrome web browser
- **vtrefny Tools** - `home:vtrefny.list`
  - OpenSUSE Build Service packages
- **Microsoft Products** - `microsoft-prod.list`
  - Microsoft development tools and runtimes
- **Minetest** - `minetestdevs-stable-jammy.list`
  - Open source voxel game engine
- **Modular** - `modular-installer.list`
  - Modular AI development platform and Mojo language
- **Mono** - `mono-official-stable.list`
  - .NET framework implementation for Linux
- **Oracle VirtualBox** - `oracle-virtualbox.list`
  - Virtualization software
- **CKB Next** - `tatokis-ckb-next-git-jammy.list`
  - Corsair keyboard/mouse driver and configuration tool
- **VS Code** - `vscode.list`
  - Microsoft Visual Studio Code editor
- **Warp Terminal** - `warpdotdev.list`
  - Modern terminal with AI features
- **WineHQ** - `winehq-jammy.sources`
  - Windows compatibility layer
- **FastFetch** - `zhangsongcui3371-fastfetch-jammy.list`
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
