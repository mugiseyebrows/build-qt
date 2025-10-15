@echo off
rem This file is generated from build-qt-6.10.0-mingw.pbat, all edits will be lost
set PATH=C:\mingw1310_64\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\6.10.0\mingw_64\bin;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Program Files\CMake\bin;C:\llvm19\bin;C:\protoc\bin;%PATH%
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
if exist C:\mingw64 move /y C:\mingw64 C:\mingw64_
if exist "C:\Program Files\PostgreSQL" move /y "C:\Program Files\PostgreSQL" "C:\Program Files\PostgreSQL_"
if exist "C:\Program Files\MySQL" move /y "C:\Program Files\MySQL" "C:\Program Files\MySQL_"
if exist "C:\Program Files\OpenSSL" move /y "C:\Program Files\OpenSSL" "C:\Program Files\OpenSSL_"
if exist C:\Strawberry move /y C:\Strawberry C:\Strawberry_
if exist C:\tools\php move /y C:\tools\php C:\tools\php_
if exist "C:\Program Files\LLVM" move /y "C:\Program Files\LLVM" "C:\Program Files\LLVM_"
if exist src goto source_end
if not exist qt-everywhere-src-6.10.0.zip (
    echo downloading qt-everywhere-src-6.10.0.zip
    curl -L -o qt-everywhere-src-6.10.0.zip https://download.qt.io/official_releases/qt/6.10/6.10.0/single/qt-everywhere-src-6.10.0.zip
)
7z rn qt-everywhere-src-6.10.0.zip qt-everywhere-src-6.10.0 src
if not exist src 7z x -y qt-everywhere-src-6.10.0.zip
:source_end
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd src
    call configure -prefix C:\Qt\6.10.0\mingw_64 -platform win32-g++ -release -skip qtwebengine -nomake examples -nomake tests -- -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/postgresql-14 -DMySQL_ROOT=C:/mysql-8.2.0-winx64
    type config.summary
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd src
    ninja qtbase/all || exit /b
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
set CC=C:\mingw1310_64\bin\gcc
set CXX=C:\mingw1310_64\bin\g++
pushd src
    ninja qtdeclarative/all || exit /b
popd
7z a -y Qt-6.10.0-mingw13.7z C:\Qt\6.10.0\mingw_64