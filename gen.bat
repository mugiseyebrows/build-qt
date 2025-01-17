@echo off
where pip > NUL || exit /b
where jinja2 > NUL || pip install jinja2-cli
where pbat > NUL || pip install pbat
jinja2 -D ver="6.8.1" -D mkspec="win32-g++" qt6.pbat.tmpl > build-qt681-mingw.pbat
jinja2 -D ver="6.8.1" -D mkspec="win32-msvc" qt6.pbat.tmpl > build-qt681-msvc.pbat
pbat build-qt681-mingw.pbat build-qt681-msvc.pbat