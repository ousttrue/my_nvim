from typing import Dict
from invoke.context import Context
from invoke import task
import pathlib
import os
import sys
import shutil
import platform
import re
import urllib.request
import pip
from mynvim import MyNVim

MY = MyNVim(pathlib.Path(__file__).absolute().parent)


def run(c: Context, exe: pathlib.Path, *args: str, **kwargs):
    cmd = str(exe)
    if ' ' in cmd:
        cmd = f'"{cmd}"'
    cmd = f'{cmd} {" ".join(args)}'

    try:
        rel = pathlib.Path(c.cwd).absolute().relative_to(MY.root)
    except ValueError:
        rel = str(c.cwd)

    print(f'{rel}$ {cmd}')
    if kwargs.get('sudo', False):
        del kwargs['sudo']
        c.sudo(cmd, **kwargs)
    else:
        c.run(cmd, **kwargs)


@task
def tools(c):
    '''
    install apt, pip, cargo
    '''

    if platform.system() == 'Windows':
        pass
    else:
        # ubuntu
        run(c,
            pathlib.Path('/usr/bin/apt'),
            'install',
            '-y',
            'libtool-bin',
            'cmake',
            'python3',
            'python3-pip',
            'ninja-build',
            'clangd',
            sudo=True)
        '''
        $ sudo apt install -y nodejs npm
        $ sudo npm install n -g
        $ sudo n stable
        $ sudo apt purge -y nodejs npm
        $ node -v
        v14.17.3

        $ curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/bin/rust-analyzer
        $ chmod +x ~/bin/rust-analyzer
        '''

    # pip
    pip.main(['install', 'pynvim', 'neovim-remote', 'yapf', 'debugpy'])

    # cargo
    run(
        c,
        MY.cargo_exe,
        'install',
        'bat',
        'stylua',
        'ripgrep',
        #'rhq',
    )


def clean_deps(my: MyNVim):
    if my.deps.exists():
        shutil.rmtree(my.deps)


def clean_nvim(my: MyNVim):
    if my.build.exists():
        shutil.rmtree(my.build)


@task
def clean(c):
    '''
    clean ./neovim/build, ./neovim/.deps, ./install
    '''
    clean_deps(MY)
    clean_nvim(MY)
    if MY.install_dir.exists():
        shutil.rmtree(MY.install_dir)


@task
def update(c):
    '''
    git pull
    '''
    print('update...')
    run(c, MY.git_exe, 'pull')
    run(c, MY.git_exe, 'submodule', 'update', '--init', '--recursive')


@task(update)
def neovim_deps(c):
    '''
    build ./neovim/.deps third-party dependencies
    '''
    print('neovim_deps...')

    MY.deps.mkdir(exist_ok=True)
    with c.cd(MY.deps):
        run(c, MY.cmake_exe, '../third-party',
            '-DCMAKE_BUILD_TYPE=RelWithDebInfo')
        run(c, MY.cmake_exe, '--build', '.', '--config', 'RelWithDebInfo')


@task(neovim_deps)
def neovim_build(c):
    '''
    build ./neovim/build
    '''
    print('neovim_build...')

    MY.build.mkdir(exist_ok=True)
    with c.cd(MY.build):
        # patch to CMakeLists.txt
        MY.patch()

        # single configuration(make etc)
        run(c, MY.cmake_exe, '..', '-DCMAKE_BUILD_TYPE=RelWithDebInfo')
        # multi configuration(vc etc)
        run(c, MY.cmake_exe, '--build', '.', '--config RelWithDebInfo')


@task(neovim_build)
def install(c):
    '''
    install neovim to ./install
    '''
    print('install...')
    MY.build.mkdir(exist_ok=True)
    with c.cd(MY.build):
        run(c, MY.cmake_exe, '--install', '.', '--config', 'RelWithDebInfo',
            '--prefix', '../../install')


def map_template(path: pathlib.Path, map: Dict[str, str]) -> str:
    def callback(matchobj: re.Match):
        return map[matchobj.group(1)]

    return re.sub(r'\$\{(\w+)\}', callback, path.read_text())


@task
def init_files(c):
    '''
    install neovim init.vim & ginti.vim
    '''
    print(MY.init_dir)
    if not MY.init_dir.exists():
        MY.init_dir.mkdir(parents=True)

    (MY.init_dir / 'init.vim').write_text(
        map_template(MY.init_vim_template,
                     {'my_nvim_root': str(MY.root).replace('\\', '/')}))
    (MY.init_dir / 'ginit.vim').write_text(MY.ginit_vim_template.read_text())


def build_lua_language_server(c: Context, path: pathlib.Path):
    # build luamake
    print('build_lua_language_server...')
    if platform.system() == 'Windows':
        if not (path / '3rd/luamake/luamake.exe').exists():
            with c.cd(path / '3rd/luamake'):
                run(c,
                    pathlib.Path(os.environ['COMSPEC']),
                    '/C',
                    'compile\\install.bat',
                    warn=True)
        # build language-server
        with c.cd(path):
            run(c, path / '3rd/luamake/luamake.exe', 'rebuild')
    else:
        if not (path / '3rd/luamake/luamake').exists():
            with c.cd(path / '3rd/luamake'):
                run(c, path / '3rd/luamake/compile/install.sh')
        # build language-server
        with c.cd(path):
            run(c, path / '3rd/luamake/luamake', 'rebuild')


@task
def ls(c):
    '''
    setup language servers
    '''
    build_lua_language_server(c,
                              MY.language_server_dir / 'lua-language-server')
    # pip.main(['install', 'python-language-server']) # this is require python2
    # pip.main(['install', 'python-lsp-server[all]'])


# HEREROCKS_URL = 'https://raw.githubusercontent.com/luarocks/hererocks/latest/hererocks.py'
HEREROCKS_URL = 'https://raw.githubusercontent.com/ousttrue/hererocks/master/hererocks.py'

@task
def hererocks(c):
    '''
    build lualocks from hererocks
    '''
    if platform.system() != "Windows":
        return

    print(f'hererocks: {MY.hererocks_dir}')
    MY.hererocks_dir.mkdir(exist_ok=True, parents=True)
    with c.cd(MY.hererocks_dir):
        data = urllib.request.urlopen(HEREROCKS_URL)
        dst = MY.hererocks_dir / 'hererocks.py'
        dst.write_bytes(data.read())

        run(c, pathlib.Path(sys.executable), 'hererocks.py', '--verbose',
            '-j', '2.1.0-beta3', '-r', 'latest',
            '2.1.0-beta3')
