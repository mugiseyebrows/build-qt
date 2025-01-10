@echo off
rem This file is generated from pull-qt6.pbat, all edits will be lost
set PATH=C:\mingw1310_64\bin;C:\Windows\System32;C:\Program Files\7-Zip;%PATH%
if exist C:\mingw1310_64\bin\gcc.exe goto mingw_end
if not exist winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z (
    echo downloading winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
    curl -L -o winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.5-11.0.0-ucrt-r5/winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
)
if not exist C:\mingw1310_64\bin\gcc.exe 7z x -y -oC:\ winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
move /y C:\mingw64 C:\mingw1310_64
:mingw_end
if not exist Qwt-6.3.0-Qt-6.8.1.zip (
    echo downloading Qwt-6.3.0-Qt-6.8.1.zip
    curl -L -o Qwt-6.3.0-Qt-6.8.1.zip http://dev.hec.to/assets/Qwt-6.3.0-Qt-6.8.1.zip
)
if not exist Qt-6.8.1.zip (
    echo downloading Qt-6.8.1.zip
    curl -L -o Qt-6.8.1.zip http://dev.hec.to/assets/Qt-6.8.1.zip
)
7z x -y -oC:\Qwt-6.3.0-Qt-6.8.1 Qwt-6.3.0-Qt-6.8.1.zip
7z x -y -oC:\Qt\6.8.1\mingw_64 Qt-6.8.1.zip