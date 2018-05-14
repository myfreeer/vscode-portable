# vscode-portable
[![Build status](https://ci.appveyor.com/api/projects/status/a8b07bv6eu6kxpw0?svg=true)](https://ci.appveyor.com/project/myfreeer/vscode-portable)
[![Download](https://img.shields.io/github/downloads/myfreeer/vscode-portable/total.svg)](https://github.com/myfreeer/vscode-portable/releases)
[![Latest Release](https://img.shields.io/github/release/myfreeer/vscode-portable.svg)](https://github.com/myfreeer/vscode-portable/releases/latest)
[![GitHub license](https://img.shields.io/github/license/myfreeer/vscode-portable.svg)](LICENSE)

make `visual studio code` portable with [dll-hijack](https://github.com/myfreeer/dll-hijack).

## Usage
Put `version.dll` in the same folder of `Code.exe`.

## Compile
Requirements: git, cmake, mingw gcc, ninja.
Run `build.sh` or follow steps below:
```bash
git clone https://github.com/myfreeer/vscode-portable.git
cd vscode-portable
mkdir build
cd build
cmake -GNinja ..
ninja
```

## Credits
* https://github.com/shuax/GreenChrome
* https://github.com/TsudaKageyu/minhook
* https://github.com/myfreeer/dll-hijack
* https://github.com/myfreeer/qbittorrent-portable