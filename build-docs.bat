@echo off
rem This file is generated from build-docs.pbat, all edits will be lost
set PATH=C:\mingw1310_64\bin;C:\Windows\System32;C:\Program Files\7-Zip;C:\llvm19\bin;C:\qt\6.10.0\mingw_64\bin;%PATH%
if exist C:\mingw1310_64\bin\gcc.exe goto mingw_end
if not exist winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z (
    echo downloading winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
    curl -L -o winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.5-11.0.0-ucrt-r5/winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
)
7z rn winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z mingw64 mingw1310_64
if not exist C:\mingw1310_64\bin\gcc.exe 7z x -y -oC:\ winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64ucrt-11.0.0-r5.7z
:mingw_end
if exist C:\llvm19\bin\clang.exe goto llvm_end
if not exist llvm19-mingw.7z (
    echo downloading llvm19-mingw.7z
    curl -L -o llvm19-mingw.7z https://github.com/mugiseyebrows/build-clang/releases/download/19.1.7/llvm19-mingw.7z
)
7z x -y -oC:\ llvm19-mingw.7z
:llvm_end
if exist src goto source_end
if not exist qt-everywhere-src-6.10.0.zip (
    echo downloading qt-everywhere-src-6.10.0.zip
    curl -L -o qt-everywhere-src-6.10.0.zip https://download.qt.io/official_releases/qt/6.10/6.10.0/single/qt-everywhere-src-6.10.0.zip
)
7z rn qt-everywhere-src-6.10.0.zip qt-everywhere-src-6.10.0 src
if not exist src 7z x -y qt-everywhere-src-6.10.0.zip
:source_end
if exist C:\qt\6.10.0\mingw_64\bin\qmake.exe goto host_end
if not exist Qt-6.10.0-mingw13.zip (
    echo downloading ce2a25348c7a26a429e7879de283bc31b569ccaa913b61cffacf0ffa94dfa712.zip?rscd=attachment%3B+filename%3D%22Qt-6.10.0-mingw13.zip%22&se=2025-10-16T18%3A10%3A27Z&sig=g96aG0NNU4BWUeB8BmBjcIoI3z9DW5g0e9udT%2BPtVEs%3D&ske=2025-10-17T05%3A10%3A45Z&skoid=ca7593d4-ee42-46cd-af88-8b886a2f84eb&sks=b&skt=2025-10-16T17%3A10%3A45Z&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skv=2025-11-05&sp=r&spr=https&sr=b&st=2025-10-16T18%3A00%3A22Z&sv=2025-11-05
    curl -L -o Qt-6.10.0-mingw13.zip "https://productionresultssa17.blob.core.windows.net/actions-results/25b6dff9-53df-491b-a3f2-8437fc5c0011/workflow-job-run-c8dd341e-11fe-5937-9771-8d5f53b73a3e/artifacts/ce2a25348c7a26a429e7879de283bc31b569ccaa913b61cffacf0ffa94dfa712.zip?rscd=attachment%3B+filename%3D%22Qt-6.10.0-mingw13.zip%22&se=2025-10-16T18%3A10%3A27Z&sig=g96aG0NNU4BWUeB8BmBjcIoI3z9DW5g0e9udT%2BPtVEs%3D&ske=2025-10-17T05%3A10%3A45Z&skoid=ca7593d4-ee42-46cd-af88-8b886a2f84eb&sks=b&skt=2025-10-16T17%3A10%3A45Z&sktid=398a6654-997b-47e9-b12b-9515b896b4de&skv=2025-11-05&sp=r&spr=https&sr=b&st=2025-10-16T18%3A00%3A22Z&sv=2025-11-05"
)
7z x -y -oC:\Qt\6.10.0\mingw_64 Qt-6.10.0-mingw13.zip
:host_end
set LLVM_INSTALL_DIR=C:\llvm19
pushd src
    cmake -G Ninja -DQT_HOST_PATH=C:\qt\6.10.0\mingw_64 -DQT_NO_PACKAGE_VERSION_CHECK=ON -DQT_NO_PACKAGE_VERSION_INCOMPATIBLE_WARNING=ON -DBUILD_qtwebengine=OFF -DCMAKE_INSTALL_PREFIX=C:/Qt/6.10.0/mingw_64 .
    ninja docs
    ninja install_docs
popd
7z a -y docs.7z C:\qt\6.10.0\mingw_64\doc