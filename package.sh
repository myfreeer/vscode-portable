#!/bin/bash
MACHINE="$(gcc -dumpmachine)"
mkdir -p "build_${MACHINE}"
cd "build_${MACHINE}"
echo Packaging...
url_64='https://vscode-update.azurewebsites.net/latest/win32-x64-archive/stable'
url_32='https://vscode-update.azurewebsites.net/latest/win32-archive/stable'

if echo "${MACHINE}" | grep -io x86_64; then
    url="${url_64}"
else
    url="${url_32}"
fi

wget -nv --trust-server-names "${url}"
zip_file="$(ls | grep -i 'vscode' | sort -uVr | head -1)"
zip_name="$(echo "${zip_file}" | sed 's/\.zip$//')"
mkdir -p "${zip_name}"
cd "${zip_name}"
/usr/bin/unzip -q "../${zip_file}" && rm -f "../${zip_file}"
cp ../version.dll  ./version.dll
7z a -mx9 -slp "../../${zip_name}.7z" .
rm -rf "${zip_name}"
cd ../..
which appveyor.exe && appveyor.exe PushArtifact "${zip_name}.7z"