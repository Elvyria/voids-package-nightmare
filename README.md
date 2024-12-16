# Void's Package Nightmare
<img src="https://img.shields.io/badge/libc-glibc-CCBBCC?style=flat-square"/> <img src="https://img.shields.io/badge/arch-x86__64-AABBAA?style=flat-square"/>  

## Void Linux is not a good distribution for the desktop environment
- Stalling on a flickering and problematic driver version for half a year for the sake of not using "beta" drivers: https://github.com/void-linux/void-packages/pull/50458  
- Always outdated GCC: https://github.com/void-linux/void-packages/pull/50825
- Refusal to communicate properly with the community: https://github.com/void-linux/void-packages/issues/50824; [reddit thread](https://www.reddit.com/r/voidlinux/comments/1eaeqie/comment/lekyofp/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button)
- [Musl](https://musl.libc.org/) blocks a lot of packages and requires an untrivial amount of patching, while not bringing anything of value in a non static form for the end users.
- Niche distro problems are always low priority and take a while to resolve: https://github.com/void-linux/void-packages/issues/41388
- Security holes are looked upon as a joke: https://github.com/void-linux/void-mklive/issues/69
- Pretty important packages are not being added fast enough (1 year +): https://github.com/void-linux/void-packages/issues/43810

### All these problems completely negate the advantage of using the best package manager XBPS
Thank you Void team, using Void Linux did a great bit of education for me, but i just can't anymore.  

*For the people that might feel adventurous after reading this - XBPS provides a package for [pacman](https://wiki.archlinux.org/title/Pacman) wink wink https://artixlinux.org*

---


Template collection for Void Linux / XBPS

## How To Use

* Set-up **[void-packages](https://github.com/void-linux/void-packages)**
```bash
git clone --depth 1 https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap
```

* Clone this repository and copy templates
```bash
git clone --depth 1 https://github.com/Elvyria/voids-package-nightmare
cp voids-package-nightmare/srcpkgs/* srcpkgs/
cat voids-package-nightmare/common/shlibs >> common/shlibs
rm -rf voids-package-nightmare
```

* Build package
```bash
./xbps-src pkg `package`
```

* Install package
```bash
xbps-install --repository hostdir/binpkgs `package`
# or
xi `package`
```

## Notes
* `SONAME: lib.so.0 <-> UNKNOWN PKG PLEASE FIX!`  
This error indicates that package requires library which have no package associated with it.  
To fix - [source](https://www.gnu.org/software/bash/manual/html_node/Bourne-Shell-Builtins.html#index-_002e) library package template and append `lib.so.0 ${pkgname}-${version}_${revision}` to [common/shlibs](https://github.com/void-linux/void-packages/blob/master/common/shlibs)  
...
