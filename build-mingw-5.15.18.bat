@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\mingw1520_64\bin;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\5.15.18\mingw_64\bin;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Windows\System32\WindowsPowerShell\v1.0;C:\llvm19\bin;%PATH%
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
        if exist C:\mingw1520_64\bin\gcc.exe goto mingw_end
        if not exist winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z (
            echo downloading winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z
            curl -L -o winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/15.2.0posix-13.0.0-msvcrt-r4/winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z
        )
        7z rn winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z mingw64 mingw1520_64
        7z x -y -oC:\ winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z
:mingw_end
    echo 1
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
if not exist qt-everywhere-opensource-src-5.15.18.zip (
    echo downloading qt-everywhere-opensource-src-5.15.18.zip
    curl -L -o qt-everywhere-opensource-src-5.15.18.zip https://download.qt.io/archive/qt/5.15/5.15.18/single/qt-everywhere-opensource-src-5.15.18.zip
)
if not exist src 7z x -y qt-everywhere-opensource-src-5.15.18.zip
move /y qt-everywhere-src-5.15.18 src
:source_end
set LLVM_INSTALL_DIR=C:\llvm19
pushd src\qtmultimedia
    "%PATCH%" -N -p1 -i ../../0001-fix-wmf-plugin.patch
popd
pushd src\qttools
    "%PATCH%" -N -p1 -i ../../004-fix-build-with-gcc-14.patch
popd
pushd src
    call configure -prefix C:\Qt\5.15.18\mingw_64 -platform win32-g++ -release -skip qtwebengine -nomake examples -nomake tests -opensource -confirm-license -shared -opengl desktop -plugin-sql-odbc -plugin-sql-mysql -no-feature-d3d12 -LC:/mysql-8.2.0-winx64/lib -IC:/mysql-8.2.0-winx64/include
    type config.summary
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtbase || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qttools || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtmultimedia || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtactiveqt || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtimageformats || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtnetworkauth || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtserialport || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtserialbus || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtsvg || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtdeclarative || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtconnectivity || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtlottie || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtquicktimeline || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtquick3d || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qt3d || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtcharts || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtdatavis3d || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtremoteobjects || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtscxml || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtsensors || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtspeech || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qttranslations || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtvirtualkeyboard || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwayland || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwebsockets || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwebchannel || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtdoc || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwebview || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make install
popd
python -c "import mugideploy" || python -m pip install "mugideploy"
mugideploy copy-dep --bin C:\Qt\5.15.18\mingw_64\bin\qmake.exe --dst C:\Qt\5.15.18\mingw_64\bin
mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\5.15.18\mingw_64\bin
mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\5.15.18\mingw_64\bin
copy /y src\config.summary C:\Qt\5.15.18\mingw_64
7z a -y Qt-5.15.18-mingw13.7z C:\Qt\5.15.18\mingw_64
7z a -y libclang-mingw13.7z C:\llvm19\bin\libclang.dll