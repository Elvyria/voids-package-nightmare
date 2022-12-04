# Void's Package Nightmare
<img src="https://img.shields.io/badge/libc-glibc-CCBBCC?style=flat-square"/> <img src="https://img.shields.io/badge/arch-x86__64-AABBAA?style=flat-square"/>  

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
...
