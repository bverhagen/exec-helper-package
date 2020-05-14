# exec-helper-package
[![pipeline status](https://gitlab.com/bverhagen/exec-helper-package/badges/master/pipeline.svg)](https://gitlab.com/bverhagen/exec-helper-package/commits/master)

Packaging repository builder for the [exec-helper](https://github.com/bverhagen/exec-helper) project.

## Supported systems
### Package systems
The following packaging systems are currently supported:
- [PKGBUILD](https://wiki.archlinux.org/index.php/PKGBUILD)
- [dpkg](https://wiki.debian.org/dpkg) (APT)
- [NSIS](https://nsis.sourceforge.io/Main_Page)

### Supported operating systems
The following operating systems are currently automatically detected when building:
- Arch linux
- Debian
- Ubuntu
- Windows

If your OS is not in the above list, but is based on one of the mentioned packaging systems and your OS complies to the dependencies, the package build will most likely work out of the box.

### Containers
Containers with exec-helper pre-installed can be found for the following container technologies:
- Docker: On [Docker Hub](https://hub.docker.com/r/bverhagen/exec-helper-package/). _note:_ Different operating systems use different tags, so make sure to check these out in order to verify whether your system is currently supported.

## Pre-built packages
We offer pre-built packages for most of the supported systems. If your system is one of these, using one of the pre-built packages is the most convenient way for installing exec-helper.

- Arch linux: Install the [exec-helper](https://aur.archlinux.org/packages/exec-helper/) AUR package for installing the binary and man-pages. The [exec-helper-docs](https://aur.archlinux.org/packages/exec-helper-docs/) AUR package installs additional documentation in HTML format.
- Ubuntu: Use our [Launchpad PPA](https://launchpad.net/~bverhagen/+archive/ubuntu/exec-helper) to install the _exec-helper_ (binary + man-pages) and _exec-helper-docs_ (additional HTML documentation) package(s). Checkout the PPA status page for more detailed instructions on how to install these package from it. The PPA contains the latest supported version for each Ubuntu version.
- Debian: There are pre-built binary packages attached to each [release on Github](https://github.com/bverhagen/exec-helper/releases). Download the relevant _.deb_ file for your system and do the following from a shell:
```bash
sudo dpkg -i <downloaded file>.deb || sudo apt-get --yes install --fix-broken && sudo dpkg -i <downloaded file>.deb
```

- Windows: Download the installer from the associated [release on Github](https://github.com/bverhagen/exec-helper/releases).

## Build from source
### Building a source package
Use:
```bash
make source
```

_Note_: The _lsb-release_ binary is required in order to automatically detect the operating system. If this is not installed, use:
```bash
make <os> TARGET=source
```

to pass it explicitly.

### Building a binary, installable package
Use:
```bash
make binary
make install PREFIX=<installation prefix>
```

where the _\<installation prefix\>_ is the path where you want to install the binary package. By default this is in a _package_ subdirectory in the root of this repository.


_Note_: The _lsb-release_ binary is required in order to automatically detect the operating system. If this is not installed, use:
```bash
make <os> TARGET=source
make <os> TARGET=binary
make <os> TARGET=install PREFIX=<installation prefix>
```

to pass it explicitly.

Build dependencies can be found in the expected files of your package manager or resolved by your package manager.
