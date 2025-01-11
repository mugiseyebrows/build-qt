@echo off
rem This file is generated from pull-postgresql.pbat, all edits will be lost
set PATH=C:\postgresql-14\bin;C:\Windows\System32;C:\Program Files\7-Zip;%PATH%
if exist C:\postgresql-14\bin\psql.exe goto postgresql_end
pushd %~dp0
    if not exist postgresql-14.12-2-windows-x64-binaries.zip (
        echo downloading postgresql-14.12-2-windows-x64-binaries.zip
        curl -L -o postgresql-14.12-2-windows-x64-binaries.zip https://get.enterprisedb.com/postgresql/postgresql-14.12-2-windows-x64-binaries.zip
    )
    7z x -y -oC:\ postgresql-14.12-2-windows-x64-binaries.zip
    move /y C:\pgsql C:\postgresql-14
popd
:postgresql_end