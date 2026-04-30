@echo off
rem This file is generated from build6.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\Git\cmd;C:\mingw13\mingw64\bin;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\pgsql\bin;C:\Qt\6.11.0\mingw_64\bin;C:\icu\bin;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\Windows
if exist C:\mingw13\mingw64\bin\gcc.exe goto mingw_end
if not exist winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z (
    echo downloading winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
    curl -L -o winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.5-11.0.0-ucrt-r5/winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
)
if not exist C:\mingw13\mingw64\bin\gcc.exe 7z x -y -oC:\mingw13 winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
:mingw_end
if exist C:\mysql-8.2.0-winx64\bin\mysql.exe goto mysql_end
if not exist mysql-8.2.0-winx64.zip (
    echo downloading mysql-8.2.0-winx64.zip
    curl -L -o mysql-8.2.0-winx64.zip https://cdn.mysql.com/Downloads/MySQL-8.2/mysql-8.2.0-winx64.zip
)
7z x -y -oC:\ mysql-8.2.0-winx64.zip
:mysql_end
if exist C:\pgsql\bin\psql.exe goto postgresql_end
if not exist postgresql-14.12-2-windows-x64-binaries.zip (
    echo downloading postgresql-14.12-2-windows-x64-binaries.zip
    curl -L -o postgresql-14.12-2-windows-x64-binaries.zip https://get.enterprisedb.com/postgresql/postgresql-14.12-2-windows-x64-binaries.zip
)
7z x -y -oC:\ postgresql-14.12-2-windows-x64-binaries.zip
:postgresql_end
if exist qt-everywhere-src-6.11.0 goto source_end
if not exist qt-everywhere-src-6.11.0.zip (
    echo downloading qt-everywhere-src-6.11.0.zip
    curl -L -o qt-everywhere-src-6.11.0.zip https://download.qt.io/official_releases/qt/6.11/6.11.0/single/qt-everywhere-src-6.11.0.zip
)
7z x -y qt-everywhere-src-6.11.0.zip
:source_end
if not exist build mkdir build
pushd build
    call ..\qt-everywhere-src-6.11.0\configure -prefix C:\Qt\6.11.0\mingw_64 -opensource -confirm-license -shared -platform win32-g++ -opengl desktop -release -icu -submodules qtbase,qtimageformats,qtactiveqt,qtserialport,qtsvg -nomake tests -nomake examples -- -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/pgsql -DMySQL_ROOT=C:/mysql-8.2.0-winx64 -DICU_ROOT=C:/icu -DCMAKE_DISABLE_PRECOMPILE_HEADERS=ON
    cmake --build . || exit /b
popd
pushd build
    cmake --install .
popd
python -c "import mugideploy" || python -m pip install "mugideploy"
mugideploy copy-dep --bin C:\Qt\6.11.0\mingw_64\bin\qmake.exe --dst C:\Qt\6.11.0\mingw_64\bin
mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.11.0\mingw_64\bin
mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.11.0\mingw_64\bin
copy /y src\config.summary C:\Qt\6.11.0\mingw_64
7z a -y Qt-6.11.0-mingw_64.7z C:\Qt\6.11.0\mingw_64
7z a -y libclang-mingw_64.7z C:\llvm19\bin\libclang.dll