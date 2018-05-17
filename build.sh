#!/bin/bash
MACHINE="$(gcc -dumpmachine)"
echo Building...
mkdir -p "build_${MACHINE}"
cd "build_${MACHINE}"
cmake -GNinja ..
ninja
cd ..
