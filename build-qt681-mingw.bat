@echo off
rem This file is generated from build-qt681-mingw.pbat, all edits will be lost
set PATH=C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\6.8.1\mingw_64\bin;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Program Files\CMake\bin;C:\mingw1310_64\bin;C:\llvm19-mingw\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\Git\cmd;%PATH%
call pull-mysql
call pull-postgresql
call pull-clang-mingw
move /y C:\mingw64 C:\mingw64_
move /y "C:\Program Files\PostgreSQL" "C:\Program Files\PostgreSQL_"
move /y "C:\Program Files\MySQL" "C:\Program Files\MySQL_"
move /y "C:\Program Files\OpenSSL" "C:\Program Files\OpenSSL_"
move /y C:\Strawberry C:\Strawberry_
move /y C:\tools\php C:\tools\php_
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qtbase-everywhere-src-6.8.1.zip (
    echo downloading qtbase-everywhere-src-6.8.1.zip
    curl -L -o qtbase-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtbase-everywhere-src-6.8.1.zip
)
if not exist qtbase-everywhere-src-6.8.1 7z x -y qtbase-everywhere-src-6.8.1.zip
pushd qtbase-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=C:\Qt\6.8.1\mingw_64 -DQT_QMAKE_TARGET_MKSPEC=win32-g++ -DQT_BUILD_TESTS=FALSE -DQT_BUILD_EXAMPLES=FALSE -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/postgresql-14 -DMySQL_ROOT=C:/mysql-8.2.0-winx64 ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
        mugideploy copy-dep --bin C:\Qt\6.8.1\mingw_64\bin\qmake.exe --dst C:\Qt\6.8.1\mingw_64\bin
        mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.8.1\mingw_64\bin
        mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.8.1\mingw_64\bin
    popd
popd
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qtsvg-everywhere-src-6.8.1.zip (
    echo downloading qtsvg-everywhere-src-6.8.1.zip
    curl -L -o qtsvg-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtsvg-everywhere-src-6.8.1.zip
)
if not exist qtsvg-everywhere-src-6.8.1 7z x -y qtsvg-everywhere-src-6.8.1.zip
pushd qtsvg-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        call qt-configure-module ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qtactiveqt-everywhere-src-6.8.1.zip (
    echo downloading qtactiveqt-everywhere-src-6.8.1.zip
    curl -L -o qtactiveqt-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtactiveqt-everywhere-src-6.8.1.zip
)
if not exist qtactiveqt-everywhere-src-6.8.1 7z x -y qtactiveqt-everywhere-src-6.8.1.zip
pushd qtactiveqt-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        call qt-configure-module ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qserialport-everywhere-src-6.8.1.zip (
    echo downloading qserialport-everywhere-src-6.8.1.zip
    curl -L -o qserialport-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qserialport-everywhere-src-6.8.1.zip
)
if not exist qserialport-everywhere-src-6.8.1 7z x -y qserialport-everywhere-src-6.8.1.zip
pushd qserialport-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        call qt-configure-module ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qtimageformats-everywhere-src-6.8.1.zip (
    echo downloading qtimageformats-everywhere-src-6.8.1.zip
    curl -L -o qtimageformats-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtimageformats-everywhere-src-6.8.1.zip
)
if not exist qtimageformats-everywhere-src-6.8.1 7z x -y qtimageformats-everywhere-src-6.8.1.zip
pushd qtimageformats-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        call qt-configure-module ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qtshadertools-everywhere-src-6.8.1.zip (
    echo downloading qtshadertools-everywhere-src-6.8.1.zip
    curl -L -o qtshadertools-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtshadertools-everywhere-src-6.8.1.zip
)
if not exist qtshadertools-everywhere-src-6.8.1 7z x -y qtshadertools-everywhere-src-6.8.1.zip
pushd qtshadertools-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        call qt-configure-module ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qtdeclarative-everywhere-src-6.8.1.zip (
    echo downloading qtdeclarative-everywhere-src-6.8.1.zip
    curl -L -o qtdeclarative-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtdeclarative-everywhere-src-6.8.1.zip
)
if not exist qtdeclarative-everywhere-src-6.8.1 7z x -y qtdeclarative-everywhere-src-6.8.1.zip
pushd qtdeclarative-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        call qt-configure-module ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
set LLVM_INSTALL_DIR=C:\llvm19-mingw
if not exist qttools-everywhere-src-6.8.1.zip (
    echo downloading qttools-everywhere-src-6.8.1.zip
    curl -L -o qttools-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qttools-everywhere-src-6.8.1.zip
)
if not exist qttools-everywhere-src-6.8.1 7z x -y qttools-everywhere-src-6.8.1.zip
pushd qttools-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        call qt-configure-module ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
        mugideploy copy-dep --bin C:\Qt\6.8.1\mingw_64\bin\qdoc.exe --dst C:\Qt\6.8.1\mingw_64\bin
    popd
popd
pushd qtbase-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
pushd qtsvg-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
pushd qtactiveqt-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
pushd qserialport-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
pushd qtimageformats-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
pushd qtshadertools-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
pushd qtdeclarative-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
pushd qttools-everywhere-src-6.8.1\build
    ninja docs
    ninja install_docs
popd
if not exist qwt (
    git clone https://git.code.sf.net/p/qwt/git qwt
    pushd qwt
        git checkout v6.3.0
    popd
)
pushd qwt
    "C:\Program Files\Git\usr\bin\patch.exe" -N -p1 -i ../0001-release-no-examples-no-tests-install-prefix.patch
    qmake
    mingw32-make -j4
    mingw32-make install
popd
7z a -y Qt-6.8.1-mingw.zip C:\Qt\6.8.1\mingw_64
7z a -y Qwt-6.3.0-Qt-6.8.1-mingw.zip C:\Qwt-6.3.0-Qt-6.8.1