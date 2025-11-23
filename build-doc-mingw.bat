@echo off
rem This file is generated from build-doc.pbat, all edits will be lost
set PATH=C:\mingw1310_64\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\llvm19\bin;C:\Qt\6.10.0\mingw_64\bin;%PATH%
if exist C:\mingw1310_64\bin\gcc.exe goto mingw_end
if not exist winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z (
    echo downloading winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
    curl -L -o winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.5-11.0.0-ucrt-r5/winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
)
7z rn winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z mingw64 mingw1310_64
7z x -y -oC:\ winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
:mingw_end
if exist C:\llvm19\bin\clang.exe goto llvm_end
if not exist llvm19-mingw.7z (
    echo downloading llvm19-mingw.7z
    curl -L -o llvm19-mingw.7z https://github.com/mugiseyebrows/build-clang/releases/download/19.1.7/llvm19-mingw.7z
)
7z x -y -oC:\ llvm19-mingw.7z
:llvm_end
if exist src goto source_end
if not exist qt-everywhere-src-6.10.0.zip (
    echo downloading qt-everywhere-src-6.10.0.zip
    curl -L -o qt-everywhere-src-6.10.0.zip https://download.qt.io/official_releases/qt/6.10/6.10.0/single/qt-everywhere-src-6.10.0.zip
)
7z rn qt-everywhere-src-6.10.0.zip qt-everywhere-src-6.10.0 src
if not exist src 7z x -y qt-everywhere-src-6.10.0.zip
:source_end
if exist C:\qt\6.10.0\mingw_64\bin\qmake.exe goto host_end
if not exist Qt-6.10.0-mingw13.7z (
    echo downloading Qt-6.10.0-mingw13.7z
    curl -L -o Qt-6.10.0-mingw13.7z https://github.com/mugiseyebrows/build-qt/releases/download/6.10.0/Qt-6.10.0-mingw13.7z
)
7z x -y -oC:\Qt\6.10.0 Qt-6.10.0-mingw13.7z
:host_end
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
    cmake -G Ninja -DQT_HOST_PATH=C:\qt\6.10.0\mingw_64 -DQT_NO_PACKAGE_VERSION_CHECK=ON -DQT_NO_PACKAGE_VERSION_INCOMPATIBLE_WARNING=ON -DBUILD_qtwebengine=OFF -DCMAKE_INSTALL_PREFIX=C:/Qt/6.10.0/mingw_64 .
    ninja docs
    ninja install_docs
popd
7z a -y qt-6.10.0-doc.7z C:\qt\6.10.0\mingw_64\doc