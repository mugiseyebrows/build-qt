@echo off
rem This file is generated from qt681.pbat, all edits will be lost
set PATH=C:\postgresql-14\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Program Files\CMake\bin;C:\Program Files\Meson;C:\Qt\6.8.1\mingw_64\bin;C:\Program Files\Git\cmd;%PATH%
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
if exist C:\postgresql-14\bin\psql.exe goto psql_end
if exist C:\Qt\6.8.1\mingw_64\plugins\sqldrivers\qsqlpsql.dll goto psql_end
pushd %~dp0
    if not exist postgresql-14.12-2-windows-x64-binaries.zip (
        echo downloading postgresql-14.12-2-windows-x64-binaries.zip
        curl -L -o postgresql-14.12-2-windows-x64-binaries.zip https://get.enterprisedb.com/postgresql/postgresql-14.12-2-windows-x64-binaries.zip
    )
    7z x -y -oC:\ postgresql-14.12-2-windows-x64-binaries.zip
    move /y C:\pgsql C:\postgresql-14
popd
:psql_end
if exist C:\Qt\6.8.1\mingw_64\plugins\sqldrivers\qsqlmysql.dll goto mysql_end
if exist C:\mysql-8.2.0-winx64\bin\mysql.exe goto mysql_end
pushd %~dp0
    if not exist mysql-8.2.0-winx64.zip (
        echo downloading mysql-8.2.0-winx64.zip
        curl -L -o mysql-8.2.0-winx64.zip https://cdn.mysql.com/Downloads/MySQL-8.2/mysql-8.2.0-winx64.zip
    )
    7z x -y -oC:\ mysql-8.2.0-winx64.zip
popd
:mysql_end
where ninja > NUL 2>&1 || pip install ninja
where mugideploy > NUL 2>&1 || pip install mugideploy
if exist C:\Qt\6.8.1\mingw_64\bin\qmake.exe goto qtbase_end
where gcc 2> NUL || (
    echo gcc not found
    exit /b 1
)
where cmake 2> NUL || (
    echo cmake not found
    exit /b 1
)
where ninja 2> NUL || (
    echo ninja not found
    exit /b 1
)
where libpq.dll 2> NUL || (
    echo libpq.dll not found
    exit /b 1
)
where libmysql.dll 2> NUL || (
    echo libmysql.dll not found
    exit /b 1
)
where mugideploy 2> NUL || (
    echo mugideploy not found
    exit /b 1
)
pushd %~dp0
    if not exist qtbase-everywhere-src-6.8.1.zip (
        echo downloading qtbase-everywhere-src-6.8.1.zip
        curl -L -o qtbase-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtbase-everywhere-src-6.8.1.zip
    )
    if not exist qtbase-everywhere-src-6.8.1 7z x -y qtbase-everywhere-src-6.8.1.zip
    pushd qtbase-everywhere-src-6.8.1
        cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=C:/Qt/6.8.1/mingw_64 -DQT_QMAKE_TARGET_MKSPEC=win32-g++ -DQT_BUILD_TESTS=FALSE -DQT_BUILD_EXAMPLES=FALSE -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/postgresql-14 -DMySQL_ROOT=C:/mysql-8.2.0-winx64 .
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
        mugideploy copy-dep --bin C:\Qt\6.8.1\mingw_64\bin\qmake.exe --dst C:\Qt\6.8.1\mingw_64\bin
        mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.8.1\mingw_64\bin
        mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.8.1\mingw_64\bin
    popd
popd
where qmake 2> NUL || (
    echo qmake not found
    exit /b 1
)
:qtbase_end
if exist C:\Qt\6.8.1\mingw_64\bin\Qt6Svg.dll goto qtsvg_end
where gcc 2> NUL || (
    echo gcc not found
    exit /b 1
)
where cmake 2> NUL || (
    echo cmake not found
    exit /b 1
)
where ninja 2> NUL || (
    echo ninja not found
    exit /b 1
)
if not exist qtsvg-everywhere-src-6.8.1.zip (
    echo downloading qtsvg-everywhere-src-6.8.1.zip
    curl -L -o qtsvg-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtsvg-everywhere-src-6.8.1.zip
)
if not exist qtsvg-everywhere-src-6.8.1 7z x -y qtsvg-everywhere-src-6.8.1.zip
pushd qtsvg-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="C:\Qt\6.8.1\mingw_64" -DCMAKE_TOOLCHAIN_FILE=C:\Qt\6.8.1\mingw_64\lib\cmake\Qt6\qt.toolchain.cmake ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
:qtsvg_end
if exist C:\Qt\6.8.1\mingw_64\lib\libQt6AxContainer.a goto qtactiveqt_end
where gcc 2> NUL || (
    echo gcc not found
    exit /b 1
)
where cmake 2> NUL || (
    echo cmake not found
    exit /b 1
)
where ninja 2> NUL || (
    echo ninja not found
    exit /b 1
)
if not exist qtactiveqt-everywhere-src-6.8.1.zip (
    echo downloading qtactiveqt-everywhere-src-6.8.1.zip
    curl -L -o qtactiveqt-everywhere-src-6.8.1.zip https://qt.mirror.constant.com/official_releases/qt/6.8/6.8.1/submodules/qtactiveqt-everywhere-src-6.8.1.zip
)
if not exist qtactiveqt-everywhere-src-6.8.1 7z x -y qtactiveqt-everywhere-src-6.8.1.zip
pushd qtactiveqt-everywhere-src-6.8.1
    if not exist build mkdir build
    pushd build
        cmake -G Ninja -DCMAKE_INSTALL_PREFIX="C:\Qt\6.8.1\mingw_64" -DCMAKE_TOOLCHAIN_FILE=C:\Qt\6.8.1\mingw_64\lib\cmake\Qt6\qt.toolchain.cmake ..
        cmake --build . --parallel || exit /b 1
        cmake --install . || exit /b 1
    popd
popd
:qtactiveqt_end
if not exist qwt (
    git clone https://git.code.sf.net/p/qwt/git qwt
    pushd qwt
        git checkout v6.3.0
    popd
)
where gcc 2> NUL || (
    echo gcc not found
    exit /b 1
)
where qmake 2> NUL || (
    echo qmake not found
    exit /b 1
)
where mingw32-make 2> NUL || (
    echo mingw32-make not found
    exit /b 1
)
if exist C:\Qwt-6.3.0-Qt-6.8.1\lib\qwt.dll goto qwt_end
pushd qwt
    "%PATCH%" -N -p1 -i ../0001-release-no-examples-no-tests-install-prefix.patch
    qmake
    mingw32-make -j4
    mingw32-make install
popd
:qwt_end
7z a -y Qt-6.8.1.zip C:\Qt\6.8.1\mingw_64
7z a -y Qwt-6.3.0-Qt-6.8.1.zip C:\Qwt-6.3.0-Qt-6.8.1