@echo off
rem This file is generated from pull-clang-msvc.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;%PATH%
if exist C:\llvm19-msvc2020\bin\clang.exe goto main_end
if not exist llvm19-msvc2020.7z (
echo downloading llvm19-msvc2020.7z
curl -L -o llvm19-msvc2020.7z https://github.com/mugiseyebrows/build-clang/releases/download/19.1.7/llvm19-msvc2020.7z
)
7z x -y -oC:\ llvm19-msvc2020.7z
:main_end