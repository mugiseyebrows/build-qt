@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\5.15.18\mingw_64\bin;C:\mingw1520_64\bin;C:\llvm19\bin;C:\protoc\bin;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Windows\System32\WindowsPowerShell\v1.0;%PATH%
        if exist C:\mingw1520_64\bin\gcc.exe goto mingw_end
        if not exist winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z (
            echo downloading winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z
            curl -L -o winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/15.2.0posix-13.0.0-msvcrt-r4/winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z
        )
        7z rn winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z mingw64 mingw1520_64
        7z x -y -oC:\ winlibs-x86_64-posix-seh-gcc-15.2.0-mingw-w64msvcrt-13.0.0-r4.7z
:mingw_end
if exist C:\llvm19\bin\clang.exe goto llvm_end
if not exist llvm19-mingw.7z (
    echo downloading llvm19-mingw.7z
    curl -L -o llvm19-mingw.7z https://github.com/mugiseyebrows/build-clang/releases/download/19.1.7/llvm19-mingw.7z
)
7z x -y -oC:\ llvm19-mingw.7z
:llvm_end
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
pushd src
    call configure -prefix C:\Qt\5.15.18\mingw_64 -platform win32-g++ -release -skip qtwebengine -nomake examples -nomake tests -opensource -confirm-license -shared -opengl desktop -plugin-sql-odbc
    type config.summary
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtbase
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtactiveqt
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtimageformats
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtnetworkauth
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtserialport
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtserialbus
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtsvg
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtdeclarative
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtconnectivity
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtlottie
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtlocation
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtquicktimeline
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtquick3d
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtmultimedia
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qt3d
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtcharts
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtdatavis3d
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtremoteobjects
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtscxml
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtsensors
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtspeech
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qttools
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qttranslations
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtvirtualkeyboard
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwayland
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwebsockets
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwebchannel
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtdoc
popd
exit /b
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
            mingw32-make module-qtwebview
popd
exit /b
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