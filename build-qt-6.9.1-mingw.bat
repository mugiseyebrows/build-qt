@echo off
rem This file is generated from build-qt-6.9.1-mingw.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\6.9.1\mingw_64\bin;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Program Files\CMake\bin;C:\mingw1310_64\bin;C:\llvm19\bin;%PATH%
call pull-mysql
call pull-postgresql
call pull-clang-mingw
call pull-mingw
echo dir C:\llvm19\bin\libclang.dll
dir C:\llvm19\bin\libclang.dll
move /y C:\mingw64 C:\mingw64_
move /y "C:\Program Files\PostgreSQL" "C:\Program Files\PostgreSQL_"
move /y "C:\Program Files\MySQL" "C:\Program Files\MySQL_"
move /y "C:\Program Files\OpenSSL" "C:\Program Files\OpenSSL_"
move /y C:\Strawberry C:\Strawberry_
move /y C:\tools\php C:\tools\php_
move /y "C:\Program Files\LLVM" "C:\Program Files\LLVM_"
if exist qt-everywhere-src-6.9.1 goto get_source_end
if not exist qt-everywhere-src-6.9.1.zip (
    echo downloading qt-everywhere-src-6.9.1.zip
    curl -L -o qt-everywhere-src-6.9.1.zip https://qt.mirror.constant.com/official_releases/qt/6.9/6.9.1/single/qt-everywhere-src-6.9.1.zip
)
if not exist qt-everywhere-src-6.9.1 7z x -y qt-everywhere-src-6.9.1.zip
:get_source_end
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.9.1
    if not exist build mkdir build
    pushd build
        call ..\configure -prefix C:\Qt\6.9.1\mingw_64 -platform win32-g++ -submodules qtbase -release -skip qtwebengine -nomake examples -nomake tests -- -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/postgresql-14 -DMySQL_ROOT=C:/mysql-8.2.0-winx64
        type config.summary
    popd
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.9.1\build
    ninja qtbase/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd qt-everywhere-src-6.9.1\build
    ninja install
popd
mugideploy copy-dep --bin C:\Qt\6.9.1\mingw_64\bin\qmake.exe --dst C:\Qt\6.9.1\mingw_64\bin
mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.9.1\mingw_64\bin
mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.9.1\mingw_64\bin
7z a -y Qt-6.9.1-mingw13.7z C:\Qt\6.9.1\mingw_64