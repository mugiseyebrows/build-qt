@echo off
rem This file is generated from pull-mysql.pbat, all edits will be lost
set PATH=C:\mysql-8.2.0-winx64\bin;C:\mysql-8.2.0-winx64\lib;C:\Windows\System32;C:\Program Files\7-Zip;%PATH%
if exist C:\mysql-8.2.0-winx64\bin\mysql.exe goto mysql_end
pushd %~dp0
    if not exist mysql-8.2.0-winx64.zip (
        echo downloading mysql-8.2.0-winx64.zip
        curl -L -o mysql-8.2.0-winx64.zip https://cdn.mysql.com/Downloads/MySQL-8.2/mysql-8.2.0-winx64.zip
    )
    7z x -y -oC:\ mysql-8.2.0-winx64.zip
popd
:mysql_end