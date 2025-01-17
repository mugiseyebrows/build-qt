@echo off
rem This file is generated from build-qt681-msvc.pbat, all edits will be lost
set PATH=C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\6.8.1\msvc2020_64\bin;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Program Files\CMake\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build;C:\llvm19\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\Git\cmd;%PATH%
call pull-mysql
call pull-postgresql
call pull-clang-msvc
move /y C:\mingw64 C:\mingw64_
move /y "C:\Program Files\PostgreSQL" "C:\Program Files\PostgreSQL_"
move /y "C:\Program Files\MySQL" "C:\Program Files\MySQL_"
move /y "C:\Program Files\OpenSSL" "C:\Program Files\OpenSSL_"
move /y C:\Strawberry C:\Strawberry_
move /y C:\tools\php C:\tools\php_
move /y "C:\Program Files\LLVM" "C:\Program Files\LLVM_"
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
if not exist qt-everywhere-src-6.8.1.zip (
    echo downloading qt-everywhere-src-6.8.1.zip
    curl -L -o qt-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/single/qt-everywhere-src-6.8.1.zip
)
if not exist qt-everywhere-src-6.8.1 7z x -y qt-everywhere-src-6.8.1.zip
pushd qt-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DQT_BUILD_SUBMODULES="qtbase;qtsvg;qtactiveqt;qtserialport;qtimageformats;qtshadertools;qtdeclarative;qttools;qtdoc" -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=C:\Qt\6.8.1\msvc2020_64 -DQT_QMAKE_TARGET_MKSPEC=win32-msvc -DQT_BUILD_TESTS=FALSE -DQT_BUILD_EXAMPLES=FALSE -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/postgresql-14 -DMySQL_ROOT=C:/mysql-8.2.0-winx64 -Wno-dev ..
        type config.summary
    popd
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtbase
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtsvg
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtactiveqt
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtserialport
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtimageformats
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtshadertools
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtdeclarative
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qttools
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja qtdoc
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja
    ninja install
popd
mugideploy copy-dep --bin C:\Qt\6.8.1\msvc2020_64\bin\qmake.exe --dst C:\Qt\6.8.1\msvc2020_64\bin
mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.8.1\msvc2020_64\bin
mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.8.1\msvc2020_64\bin
mugideploy copy-dep --bin C:\Qt\6.8.1\msvc2020_64\bin\qdoc.exe --dst C:\Qt\6.8.1\msvc2020_64\bin
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd qt-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
where mugideploy > NUL 2>&1 || pip install mugideploy
where ninja > NUL 2>&1 || pip install ninja
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
if not exist qwt (
    git clone https://git.code.sf.net/p/qwt/git qwt
    pushd qwt
        git checkout v6.3.0
    popd
)
pushd qwt
    "C:\Program Files\Git\usr\bin\patch.exe" -N -p1 -i ../0001-release-no-examples-no-tests-install-prefix.patch
    qmake
    nmake
    nmake install
popd
7z a -y Qt-6.8.1-msvc2020.7z C:\Qt\6.8.1\msvc2020_64
7z a -y Qwt-6.3.0-Qt-6.8.1-msvc2020.7z C:\Qwt-6.3.0-Qt-6.8.1