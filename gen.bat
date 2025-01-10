@echo off
where pip > NUL || exit /b
where jinja2 > NUL || pip install jinja2-cli
where pbat > NUL || pip install pbat
jinja2 -D ver=6.8.1 qt6.pbat.tmpl > qt681.pbat
pbat qt681.pbat