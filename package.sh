#!/bin/bash
MACHINE="$(gcc -dumpmachine)"
mkdir -p "build_${MACHINE}"
cd "build_${MACHINE}"
echo Packaging...
url_64='https://vscode-update.azurewebsites.net/latest/win32-x64-archive/stable'
url_32='https://vscode-update.azurewebsites.net/latest/win32-archive/stable'
version_vscodium=$(curl -ks https://github.com/VSCodium/vscodium/releases/latest | grep -ioP '[0-9.]{4,}')
name_vscodium_64="VSCodium-win32-x64-${version_vscodium}"
name_vscodium_32="VSCodium-win32-ia32-${version_vscodium}"
url_vscodium_64="https://github.com/VSCodium/vscodium/releases/download/${version_vscodium}/${name_vscodium_64}.zip"
url_vscodium_32="https://github.com/VSCodium/vscodium/releases/download/${version_vscodium}/${name_vscodium_32}.zip"

if echo "${MACHINE}" | grep -io x86_64; then
    url="${url_64}"
    name_vscodium="${name_vscodium_64}"
    url_vscodium="${url_vscodium_64}"
else
    url="${url_32}"
    name_vscodium="${name_vscodium_32}"
    url_vscodium="${url_vscodium_32}"
fi

wget -nv --trust-server-names "${url}"
zip_file="$(ls | grep -i 'vscode' | sort -uVr | head -1)"
zip_name="$(echo "${zip_file}" | sed 's/\.zip$//')"
mkdir -p "${zip_name}"
cd "${zip_name}"
7z x "../${zip_file}" && rm -f "../${zip_file}"
cp ../version.dll  ./version.dll
7z a -mx9 -slp "../../${zip_name}.7z" .
cd ..
rm -rf "${zip_name}"
cd ..
which appveyor.exe && appveyor.exe PushArtifact "${zip_name}.7z"

rm -rf "${zip_name}.7z"

# begin vscodium
cd "build_${MACHINE}"
wget -nv "${url_vscodium}"
mkdir -p "${name_vscodium}"
cd "${name_vscodium}"
7z x "../${name_vscodium}.zip" && rm -f "../${name_vscodium}.zip"
cp ../version.dll  ./version.dll
7z a -mx9 -slp "../../${name_vscodium}.7z" .
cd ..
rm -rf "${name_vscodium}"
cd ..
which appveyor.exe && appveyor.exe PushArtifact "${name_vscodium}.7z"
# end vscodium
