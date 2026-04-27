@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\Git\cmd;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\6.10.0\msvc2020_64\bin;C:\icu\bin;C:\llvm19\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Windows
if exist "C:\Program Files\Git\usr\bin\patch.exe" set PATCH=C:\Program Files\Git\usr\bin\patch.exe
if not defined PATCH (
echo PATCH not found
exit /b
)
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
if not exist qt-everywhere-src-6.10.0.zip (
    echo downloading qt-everywhere-src-6.10.0.zip
    curl -L -o qt-everywhere-src-6.10.0.zip https://download.qt.io/official_releases/qt/6.10/6.10.0/single/qt-everywhere-src-6.10.0.zip
)
7z rn qt-everywhere-src-6.10.0.zip qt-everywhere-src-6.10.0 src
if not exist src 7z x -y qt-everywhere-src-6.10.0.zip
:source_end
set LLVM_INSTALL_DIR=C:\llvm19
call vcvars64.bat
pushd src
    "%PATCH%" -N -p1 -i ../0001-missin-min-and-max-def.patch
    call configure -prefix C:\Qt\6.10.0\msvc2020_64 -opensource -confirm-license -shared -platform win32-msvc -opengl desktop -release -submodules qtbase,qtimageformats -nomake tests -nomake examples -- -DFEATURE_system_zlib=OFF -DFEATURE_sql_mysql=ON -DFEATURE_sql_psql=ON -DPostgreSQL_ROOT=C:/postgresql-14 -DMySQL_ROOT=C:/mysql-8.2.0-winx64 -DICU_ROOT=C:/icu
    type config.summary
        cmake --build . || exit /b
popd
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
        cmake --install .
popd
python -c "import mugideploy" || python -m pip install "mugideploy"
mugideploy copy-dep --bin C:\Qt\6.10.0\msvc2020_64\bin\qmake.exe --dst C:\Qt\6.10.0\msvc2020_64\bin
mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.10.0\msvc2020_64\bin
mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.10.0\msvc2020_64\bin
copy /y src\config.summary C:\Qt\6.10.0\msvc2020_64
7z a -y Qt-6.10.0-msvc2020.7z C:\Qt\6.10.0\msvc2020_64
7z a -y libclang-msvc2020.7z C:\llvm19\bin\libclang.dll