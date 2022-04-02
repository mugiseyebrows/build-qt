from dataclasses import dataclass, field
from logging import warning
import re
import os
import textwrap

from pbat import read_compile_write
from io import StringIO
import yaml

class folded_str(str): pass
class literal_str(str): pass

def folded_str_representer(dumper, data):
    return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='>')
def literal_str_representer(dumper, data):
    return dumper.represent_scalar('tag:yaml.org,2002:str', data, style='|')

yaml.add_representer(folded_str, folded_str_representer)
yaml.add_representer(literal_str, literal_str_representer)

def compile(text):

    if isinstance(text, Step):
        text = "\n".join(text.run)
    elif isinstance(text, list):
        text = "\n".join(text) + "\n"

    text = """
    curl_in_path true
    download_test off
    unzip_test off
    github true
    """ + text

    src = StringIO()
    src.write(text)
    src.seek(0)
    dst = StringIO()
    read_compile_write(src, dst, echo_off=False, warning=False)
    dst.seek(0)

    value = re.sub("\\s+$","",dst.getvalue()) + "\n"

    return value

def read_names():
    names = []
    p = os.path.join(os.path.dirname(__file__), "md5sums.txt")
    with open(p, 'r') as f:
        for line in f:
            line = line.rstrip()
            cols = re.split('\\s+',line)
            #print(cols)
            if len(cols) == 2:
                h, z = cols
                if z.endswith('xz'):
                    continue
                name = z.split('-')[0]
                names.append(name)
    return names

def long_name(name):
    return '{}-everywhere-src-5.15.2'.format(name)

def zip_name(name):
    return long_name(name) + '.zip'

def link(name):
    return 'https://download.qt.io/official_releases/qt/5.15/5.15.2/submodules/{}'.format(zip_name(name))

def reorder(names):
    qtbase = names.pop(names.index('qtbase'))
    qsqlmysql = 'qsqlmysql'
    qsqlpsql = 'qsqlpsql'
    qtdeclarative = names.pop(names.index('qtdeclarative'))
    qtquickcontrols = names.pop(names.index('qtquickcontrols'))
    qtquickcontrols2 = names.pop(names.index('qtquickcontrols2'))
    qtquick3d = names.pop(names.index('qtquick3d'))
    qtquicktimeline = names.pop(names.index('qtquicktimeline'))
    qtwebsockets = names.pop(names.index('qtwebsockets'))

    qtdoc = names.pop(names.index('qtdoc'))
    qtmacextras = names.pop(names.index('qtmacextras'))
    qtwayland = names.pop(names.index('qtwayland'))
    qtwebengine = names.pop(names.index('qtwebengine'))
    qtx11extras = names.pop(names.index('qtx11extras'))
    qtandroidextras = names.pop(names.index('qtandroidextras'))

    if 0:
        return [qtbase, qsqlmysql, qsqlpsql]

    return [qtbase, qsqlmysql, qsqlpsql, qtdeclarative, qtquickcontrols, qtquickcontrols2, qtquick3d, qtquicktimeline, qtwebsockets] + names

def clean_exp(names):
    clean = []
    for name in names:
        if name in ['qsqlmysql','qsqlpsql']:
            continue
        clean.append("rmdir /q /s {}".format(long_name(name)))
    clean = "\n".join(clean) + "\n"
    return clean

def build_cmds(name):
    configure = {
        'qtbase': 'call configure -prefix %CD%\\..\\Qt-5.15.2 -opensource -confirm-license -shared -platform win32-g++ -opengl desktop -release -nomake tests -nomake examples -openssl-linked OPENSSL_LIBS="-lcrypto-1_1-x64 -lssl-1_1-x64" -I %CD%\\..\\OpenSSL\\include -L %CD%\\..\\OpenSSL\\bin',
        'qsqlmysql': 'call configure -prefix %CD%\\..\\Qt-5.15.2 -opensource -confirm-license -shared -platform win32-g++ -opengl desktop -release -nomake tests -nomake examples -openssl-linked OPENSSL_LIBS="-lcrypto-1_1-x64 -lssl-1_1-x64" -I %CD%\\..\\OpenSSL\\include -L %CD%\\..\\OpenSSL\\bin -plugin-sql-mysql MYSQL_PREFIX=C:\\mysql MYSQL_INCDIR=C:\\mysql\\include MYSQL_LIBDIR=C:\\mysql\\lib',
        'qsqlpsql': 'call configure -prefix %CD%\\..\\Qt-5.15.2 -opensource -confirm-license -shared -platform win32-g++ -opengl desktop -release -nomake tests -nomake examples -openssl-linked OPENSSL_LIBS="-lcrypto-1_1-x64 -lssl-1_1-x64" -I %CD%\\..\\OpenSSL\\include -L %CD%\\..\\OpenSSL\\bin -plugin-sql-psql PSQL_INCDIR=%CD%\\..\\postgresql-14\\include PSQL_LIBDIR=%CD%\\..\\postgresql-14\\bin',
    }
    cmds = []

    if name not in ['qsqlmysql','qsqlpsql']:
        cmds.append('download({},{})'.format(link(name), zip_name(name)))
        cmds.append('unzip({},{})'.format(zip_name(name), long_name(name)))

    if name in configure:
        cmds = cmds + [
            "pushd {}".format(long_name('qtbase')),
            "del /f config.cache",
            configure[name],
            "mingw32-make -j2",
            "mingw32-make install",
            "popd"
        ]
    else:
        cmds = cmds + [
            'pushd {}'.format(long_name(name)),
            "qmake",
            "mingw32-make -j2",
            "mingw32-make install",
            "popd"
        ]
    
    cmds.append('pyfind Qt-5.15.2 -type f > {}.txt'.format(name))
    return cmds

def zip_cmds(names):
    cmds = []
    for n1, n2 in zip(names,names[1:]):
        cmds.append('pycat {}.txt {}.txt | pysort | pyuniq -u > {}.txt\n'.format(n1, n2, n2 + '-diff'))

    for i, name  in enumerate(names):
        cmds.append('del /f Qt-5.15.2-{}.zip\n'.format(name))

    for i, name in enumerate(names):
        txtname = name + '-diff' if i > 0 else name
        cmds.append('pyzip a --list {}.txt Qt-5.15.2-{}.zip\n'.format(txtname, name))
    return cmds

def extra_cmds():

    excl = " | ".join(["pygrep -v {}".format(n) for n in ['mingw64', 'OpenSSL', 'Qt5Core', 'Qt5Sql', 'libssl', 'libcrypto', 'sqldrivers']])
    
    debug = """
 echo qsqlmysql list
mugideploy list --bin Qt-5.15.2\\plugins\\sqldrivers\\qsqlmysql.dll
echo qsqlmysql list filtered
mugideploy list --bin Qt-5.15.2\\plugins\\sqldrivers\\qsqlmysql.dll | {}
echo qsqlpsql list
mugideploy list --bin Qt-5.15.2\\plugins\\sqldrivers\\qsqlpsql.dll
echo qsqlpsql list filtered
mugideploy list --bin Qt-5.15.2\\plugins\\sqldrivers\\qsqlpsql.dll | {}
""".format(excl,excl)

    return """
pyzip a -v --dir Qt-5.15.2\\bin --base OpenSSL\\bin Qt-5.15.2-qtbase.zip OpenSSL\\bin\\*.dll
mugideploy list --bin Qt-5.15.2\\plugins\\sqldrivers\\qsqlmysql.dll | {} | pyxargs pyzip a -v --dir Qt-5.15.2\\bin Qt-5.15.2-qsqlmysql.zip
mugideploy list --bin Qt-5.15.2\\plugins\\sqldrivers\\qsqlpsql.dll | {} | pyxargs pyzip a -v --dir Qt-5.15.2\\bin Qt-5.15.2-qsqlpsql.zip
""".format(excl,excl).split("\n")

def prepare_cmds():
    return """set MINGW_BIN_PATH=%CD%\\mingw64\\bin
set_path(
    %MINGW_BIN_PATH%,
    %CD%\\Qt-5.15.2\\bin,
    %CD%\\OpenSSL\\bin,
    C:\\Strawberry\\perl\\bin,
    %CD%\\postgresql-14\\bin,
    C:\\mysql\\lib,
    C:\\Program Files\\7-Zip,
    C:\\Miniconda,
    C:\\Miniconda\\Scripts,
    C:\\Users\\Stanislav\\Miniconda3\\Scripts,
    C:\\Users\\Stanislav\\Miniconda3,
    C:\\windows\\system32,
    C:\\windows,
    %PATH%
)
python -m pip install mugicli mugideploy
#exit /b
rmdir /q /s Qt-5.15.2
# mingw
download(https://github.com/mugiseyebrows/mirror-mingw/releases/download/8.1.0/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z, x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z)
unzip(x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z, mingw64)
# openssl
download(https://github.com/mugiseyebrows/build-openssl/releases/download/1.1.1n/OpenSSL.zip, OpenSSL.zip)
unzip(OpenSSL.zip, OpenSSL)
copy_dir(C:\\Program Files\\PostgreSQL\\14\\bin, postgresql-14\\bin)
copy_dir(C:\\Program Files\\PostgreSQL\\14\\include, postgresql-14\\include)
""".split('\n')

def zip_list(names):
    return "\n".join(['Qt-5.15.2-{}.zip'.format(name) for name in names]) + "\n"

class Dumper(yaml.Dumper):
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # disable resolving on as tag:yaml.org,2002:bool (disable single quoting)
        cls = self.__class__
        cls.yaml_implicit_resolvers['o'] = []

@dataclass
class Step:
    name: str
    run: list = field(default_factory=list)

if __name__ == "__main__":
    steps = []
    
    names = read_names()
    names = reorder(names)
    
    steps.append(Step('prepare', prepare_cmds()))

    for name in names:
        steps.append(Step('build ' + name, build_cmds(name)))
    
    steps.append(Step("zip", zip_cmds(names)))

    steps.append(Step("extra", extra_cmds()))

    steps_ = []
    for step in steps:
        run = compile(step)
        steps_.append({"name": step.name, "shell": "cmd", "run": literal_str(run)})

    steps_.append({
        "name": "release",
        "uses": "softprops/action-gh-release@v1",
        "if": "startsWith(github.ref, 'refs/tags/')",
        "with": {"files": literal_str(zip_list(names))},
    })

    dst = os.path.join(os.path.dirname(__file__), ".github", "workflows", "main.yml")

    os.makedirs(os.path.dirname(dst), exist_ok=True)

    data = {"name":"main","on":{"push":{"tags":"*"}},"jobs":{"main": {"runs-on":"windows-2022","steps":steps_}}}

    with open(dst, 'w', encoding='utf-8') as f:
        f.write(yaml.dump(data, None, Dumper=Dumper, sort_keys=False))
