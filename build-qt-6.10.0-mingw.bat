@echo off
rem This file is generated from build-qt-6.10.0-mingw.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\mingw1310_64\bin;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\6.10.0\mingw_64\bin;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Program Files\CMake\bin;C:\llvm19\bin;C:\protoc\bin;%PATH%
if exist C:\llvm19\bin\clang.exe goto llvm_end
if not exist llvm19-mingw.7z (
    echo downloading llvm19-mingw.7z
    curl -L -o llvm19-mingw.7z https://github.com/mugiseyebrows/build-clang/releases/download/19.1.7/llvm19-mingw.7z
)
7z x -y -oC:\ llvm19-mingw.7z
:llvm_end
if exist C:\mingw1310_64\bin\gcc.exe goto mingw_end
if not exist winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z (
    echo downloading winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
    curl -L -o winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.5-11.0.0-ucrt-r5/winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
)
7z rn winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z mingw64 mingw1310_64
if not exist C:\mingw1310_64\bin\gcc.exe 7z x -y -oC:\ winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
:mingw_end
if exist C:\mysql-8.2.0-winx64\bin\mysql.exe goto mysql_end
if not exist mysql-8.2.0-winx64.zip (
    echo downloading mysql-8.2.0-winx64.zip
    curl -L -o mysql-8.2.0-winx64.zip https://cdn.mysql.com/Downloads/MySQL-8.2/mysql-8.2.0-winx64.zip
)
7z x -y -oC:\ mysql-8.2.0-winx64.zip
:mysql_end
if exist C:\postgresql-14\bin\psql.exe goto postgresql_end
if not exist postgresql-14.12-2-windows-x64-binaries.zip (
    echo downloading postgresql-14.12-2-windows-x64-binaries.zip
    curl -L -o postgresql-14.12-2-windows-x64-binaries.zip https://get.enterprisedb.com/postgresql/postgresql-14.12-2-windows-x64-binaries.zip
)
7z rn postgresql-14.12-2-windows-x64-binaries.zip pgsql postgresql-14
7z x -y -oC:\ postgresql-14.12-2-windows-x64-binaries.zip
:postgresql_end
if exist C:\protoc\bin\protoc.exe goto protobuf_end
if not exist protobuf-mingw13.7z (
    echo downloading protobuf-mingw13.7z
    curl -L -o protobuf-mingw13.7z https://github.com/mugiseyebrows/build-protobuf/releases/download/v32.1/protobuf-mingw13.7z
)
7z rn protobuf-mingw13.7z protobuf-mingw13 protobuf
7z x -y -oC:\ protobuf-mingw13.7z
:protobuf_end
if exist C:\mingw64 move /y C:\mingw64 C:\mingw64_
if exist "C:\Program Files\PostgreSQL" move /y "C:\Program Files\PostgreSQL" "C:\Program Files\PostgreSQL_"
if exist "C:\Program Files\MySQL" move /y "C:\Program Files\MySQL" "C:\Program Files\MySQL_"
if exist "C:\Program Files\OpenSSL" move /y "C:\Program Files\OpenSSL" "C:\Program Files\OpenSSL_"
if exist C:\Strawberry move /y C:\Strawberry C:\Strawberry_
if exist C:\tools\php move /y C:\tools\php C:\tools\php_
if exist "C:\Program Files\LLVM" move /y "C:\Program Files\LLVM" "C:\Program Files\LLVM_"
if exist qt-everywhere-src-6.10.0 goto get_source_end
if not exist qt-everywhere-src-6.10.0.zip (
    echo downloading qt-everywhere-src-6.10.0.zip
    curl -L -o qt-everywhere-src-6.10.0.zip https://qt.mirror.constant.com/official_releases/qt/6.10/6.10.0/single/qt-everywhere-src-6.10.0.zip
)
if not exist qt-everywhere-src-6.10.0 7z x -y qt-everywhere-src-6.10.0.zip
:get_source_end
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0
    if not exist build mkdir build
    pushd build
        call ..\configure -prefix C:\Qt\6.10.0\mingw_64 -platform win32-g++ -release -skip qtwebengine -nomake examples -nomake tests -- -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/postgresql-14 -DMySQL_ROOT=C:/mysql-8.2.0-winx64 -DCMAKE_DISABLE_PRECOMPILE_HEADERS=ON
        type config.summary
    popd
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtshadertools/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtimageformats/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtlanguageserver/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtsvg/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtserialport/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtactiveqt/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtdeclarative/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtwebsockets/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtsensors/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qttools/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtpositioning/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtlocation/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtquicktimeline/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qthttpserver/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtquick3d/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtmultimedia/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtquick3dphysics/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtgraphs/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja qtdoc/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja install
popd
mugideploy copy-dep --bin C:\Qt\6.10.0\mingw_64\bin\qmake.exe --dst C:\Qt\6.10.0\mingw_64\bin
mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.10.0\mingw_64\bin
mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.10.0\mingw_64\bin
rem libclang.dll is huge
rem mugideploy copy-dep --bin C:\Qt\6.10.0\mingw_64\bin\qdoc.exe --dst C:\Qt\6.10.0\mingw_64\bin
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.10.0\build
    ninja docs
    ninja install_docs
popd
copy /y qt-everywhere-src-6.10.0\build\config.summary C:\Qt\6.10.0\mingw_64
7z a -y Qt-6.10.0-mingw13.7z C:\Qt\6.10.0\mingw_64