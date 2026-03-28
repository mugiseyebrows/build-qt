@echo off
rem This file is generated from build.pbat, all edits will be lost
set PATH=C:\Windows\System32;C:\Program Files\7-Zip;C:\Program Files\Git\cmd;%LOCALAPPDATA%\Programs\Python\Python313;%LOCALAPPDATA%\Programs\Python\Python313\Scripts;C:\Python313;C:\Python313\Scripts;C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\postgresql-14\bin;C:\Qt\6.10.0\msvc2020_64\bin;C:\llvm19\bin;C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build;C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build;C:\Miniconda3;C:\Miniconda3\Scripts;%USERPROFILE%\Miniconda3;%USERPROFILE%\Miniconda3\Scripts;C:\Windows
call vcvars64.bat
mugideploy copy-dep --bin C:\Qt\6.10.0\msvc2020_64\bin\qmake.exe --dst C:\Qt\6.10.0\msvc2020_64\bin
mugideploy copy-dep --bin C:\mysql-8.2.0-winx64\lib\libmysql.dll --dst C:\Qt\6.10.0\msvc2020_64\bin
mugideploy copy-dep --bin C:\postgresql-14\lib\libpq.dll --dst C:\Qt\6.10.0\msvc2020_64\bin
copy /y src\config.summary C:\Qt\6.10.0\msvc2020_64
7z a -y Qt-6.10.0-msvc2020.7z C:\Qt\6.10.0\msvc2020_64
7z a -y libclang-msvc2020.7z C:\llvm19\bin\libclang.dll