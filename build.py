#!/usr/bin/python3
'''
https://github.com/neovim/neovim/wiki/Building-Neovim
'''
import subprocess
import pathlib
import shutil
import os
import sys
import re
import platform
import pip
from typing import Dict
from mynvim import MyNVim
import vcenv

MY = MyNVim(pathlib.Path(__file__).absolute().parent)


def mkcd(path: pathlib.Path):
    path.mkdir(exist_ok=True)
    os.chdir(path)


def diff(new: Dict[str, str], old: Dict[str, str]):
    for k, v in new.items():
        old_v = old.get(k)
        if v != old_v:
            print(f'{k}: {v} != {old_v}')


def install_packages(*packages: str):
    if platform.system() == 'Linux':
        run(pathlib.Path('/usr/bin/sudo'), 'apt', 'install', '-y', *packages)


def decode(b: bytes) -> str:
    if platform.system() == 'Windows':
        try:
            return b.decode('cp932')
        except:
            return b.decode('utf8')
    else:
        return b.decode('utf-8')


def run(exe: pathlib.Path, *cmd: str, **args):
    if not exe.exists():
        raise Exception(f'{exe} not found')

    print(f'{exe} ' + ''.join(f' {cmd}'))
    process = subprocess.Popen([str(exe)] + list(cmd), stdout=subprocess.PIPE)
    stdout = process.stdout
    if not stdout:
        raise Exception()
    while True:
        rc = process.poll()
        if rc is not None:
            break

        output = stdout.readline()
        print(decode(output).strip())

    if rc != 0:
        if rc != args.get('rc', 0):
            raise Exception(rc)


def clean_deps(my: MyNVim):
    if my.deps.exists():
        shutil.rmtree(my.deps)


def clean_nvim(my: MyNVim):
    if my.build.exists():
        shutil.rmtree(my.build)


def clean(my: MyNVim):
    clean_deps(my)
    clean_nvim(my)
    if my.install_dir.exists():
        shutil.rmtree(my.install_dir)


def deps(my: MyNVim):
    '''
    build libs
    '''
    mkcd(my.deps)
    run(my.cmake_exe, '../third-party', '-DCMAKE_BUILD_TYPE=RelWithDebInfo')
    run(my.cmake_exe, '--build', '.', '--config', 'RelWithDebInfo')


def nvim(my: MyNVim):
    '''
    build nvim
    '''
    mkcd(my.build)

    # patch to CMakeLists.txt
    my.patch()

    # single configuration(make etc)
    run(my.cmake_exe, '..', '-DCMAKE_BUILD_TYPE=RelWithDebInfo')
    # multi configuration(vc etc)
    run(my.cmake_exe, '--build', '.', '--config', 'RelWithDebInfo')


def install(my: MyNVim):
    mkcd(my.build)
    # run(my.cmake_exe, '--build', '.', '--target', 'install')
    run(my.cmake_exe, '--install', '.', '--config', 'RelWithDebInfo',
        '--prefix', '../../install')


def map_template(path: pathlib.Path, map: Dict[str, str]) -> str:
    def callback(matchobj: re.Match):
        return map[matchobj.group(1)]

    return re.sub(r'\$\{(\w+)\}', callback, path.read_text())


def init_files(my: MyNVim):
    #
    # init.vim & ginit.vim
    #
    print(my.init_dir)
    if not my.init_dir.exists():
        my.init_dir.mkdir(parents=True)

    (my.init_dir / 'init.vim').write_text(
        map_template(my.init_vim_template,
                     {'my_nvim_root': str(my.root).replace('\\', '/')}))
    (my.init_dir / 'ginit.vim').write_text(my.ginit_vim_template.read_text())


def build_lua_language_server(path: pathlib.Path):
    # build luamake
    if platform.system() == 'Windows':
        if not (path / '3rd/luamake/luamake.exe').exists():
            os.chdir(path / '3rd/luamake')
            run(pathlib.Path(os.environ['COMSPEC']),
                '/C',
                'compile\\install.bat',
                rc=1)
        # build language-server
        os.chdir(path)
        run(path / '3rd/luamake/luamake.exe', 'rebuild')
    else:
        if not (path / '3rd/luamake/luamake').exists():
            os.chdir(path / '3rd/luamake')
            run(path / '3rd/luamake/compile/install.sh')
        # build language-server
        os.chdir(path)
        run(path / '3rd/luamake/luamake', 'rebuild')


def ls(my: MyNVim):
    build_lua_language_server(my.language_server_dir / 'lua-language-server')
    # pip.main(['install', 'python-language-server']) # this is require python2
    pip.main(['install', 'python-lsp-server[all]'])


def tools(my: MyNVim):

    if platform.system() == 'Windows':
        pass
    else:
        # ubuntu
        install_packages('libtool-bin', 'cmake', 'python3', 'python3-pip',
                         'ninja-build', 'clangd')
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
        my.cargo_exe,
        'install',
        'bat',
        'stylua',
        #'rhq',
    )


def pull(my: MyNVim):
    run(my.git_exe, 'pull')
    run(my.git_exe, 'submodule', 'update', '--init', '--recursive')


def hererocks(my: MyNVim):
    '''
    copy lualocks from neovim/.deps
    '''
    if platform.system() != 'Windows':
        return
    shutil.copytree(my.luarocks_dir, my.hererocks_dir, dirs_exist_ok=True)
    shutil.copytree(my.luarocks_dir.parent / 'lib/luarocks',
                    my.hererocks_dir / 'lib',
                    dirs_exist_ok=True)

    # replace luarocks.bat
    (my.hererocks_dir / 'luarocks.bat').write_text(
        map_template(
            my.luarocks_bat_template, {
                'packer_hererocks_lua_path':
                f'{my.hererocks_dir}/lua/?.lua;{my.hererocks_dir}/lib/lua/?/init.lua',
                'packer_hererocks_path': f'{my.hererocks_dir}/luarocks.lua',
                'luajit_exe': f'{my.deps}/usr/bin/luajit.exe',
                'luarocks_lua': f'{my.deps}/usr/luarocks/luarocks.lua',
            }))


if __name__ == '__main__':

    #
    # actions
    #
    if len(sys.argv) == 1:
        # all
        actions = ['tools', 'deps', 'nvim', 'install', 'ls']
        # actions = ['init_files']
    else:
        actions = sys.argv[1:]

    for action in actions:
        print(f'########## {action} ##########')
        locals()[action](MY)
