rem echo Syncing msys2 packages...
rem C:\msys64\usr\bin\pacman -Sq --noconfirm --needed --noprogressbar --ask=20 unzip p7zip mingw-w64-x86_64-ninja mingw-w64-i686-ninja

echo Building and packaging 64-bit version...
set MSYSTEM=MINGW64
call C:\msys64\usr\bin\bash -lc "cd \"$APPVEYOR_BUILD_FOLDER\" && exec ./build.sh"
call C:\msys64\usr\bin\bash -lc "cd \"$APPVEYOR_BUILD_FOLDER\" && exec ./package.sh"
mkdir mingw64
move /Y build_x86_64-w64-mingw32\version.dll  mingw64\version.dll

echo Building and packaging 32-bit version...
set MSYSTEM=MINGW32
call C:\msys64\usr\bin\bash -lc "cd \"$APPVEYOR_BUILD_FOLDER\" && exec ./build.sh"
call C:\msys64\usr\bin\bash -lc "cd \"$APPVEYOR_BUILD_FOLDER\" && exec ./package.sh"
mkdir mingw32
move /Y build_i686-w64-mingw32\version.dll  mingw32\version.dll

echo Packaging...
7z a -mx9 -r vscode-portable.7z *.dll
move /Y mingw32\version.dll .\32bit_version.dll
move /Y mingw64\version.dll .\64bit_version.dll
echo Done.
