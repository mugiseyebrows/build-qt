@echo off
rem This file is generated from pull-clang-mingw.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;%PATH%
if not exist llvm19-mingw.7z (
echo downloading llvm19-mingw.7z
curl -L -o llvm19-mingw.7z https://github.com/mugiseyebrows/build-clang/releases/download/19.1.7/llvm19-mingw.7z
)
7z x -y -oC:\llvm19-mingw llvm19-mingw.7z