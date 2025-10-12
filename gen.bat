@echo off
where pip > NUL || exit /b
where jinja2 > NUL || pip install jinja2-cli
where pbat > NUL || pip install pbat
set ver=6.10.0
jinja2 -D ver=%ver% -D mkspec="win32-g++" qt6.pbat.j2 > build-qt-%ver%-mingw.pbat
jinja2 -D ver=%ver% -D mkspec="win32-msvc" qt6.pbat.j2 > build-qt-%ver%-msvc.pbat
pbat build-qt-%ver%-mingw.pbat build-qt-%ver%-msvc.pbat