#!/usr/bin/python3
'''
https://github.com/neovim/neovim/wiki/Building-Neovim
'''
import subprocess
import pathlib
import shutil
import os
import sys
import platform
import pip
from typing import List, Dict

HERE = pathlib.Path(__file__).absolute().parent
NEOVIM_DIR = HERE / 'neovim'
DEPS = NEOVIM_DIR / '.deps'
BUILD = NEOVIM_DIR / 'build'
INSTALL_DIR = HERE / 'install'

VCBARS64 = 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat'


def init_dir() -> pathlib.Path:
    if platform.system() == 'Windows':
        if True:
            APPDATA_DIR = pathlib.Path(os.environ['APPDATA']).absolute()
            return APPDATA_DIR.parent / 'Local/nvim'
        else:
            HOME_DIR = pathlib.Path(os.environ['USERPROFILE']).absolute()
            return HOME_DIR / '.config/nvim'
    else:
        HOME_DIR = pathlib.Path(os.environ['HOME']).absolute()
        return HOME_DIR / '.config/nvim'


INIT_DIR = init_dir()


def mkcd(path: pathlib.Path):
    path.mkdir(exist_ok=True)
    os.chdir(path)


def diff(new: Dict[str, str], old: Dict[str, str]):
    for k, v in new.items():
        old_v = old.get(k)
        if v != old_v:
            print(f'{k}: {v} != {old_v}')


def vcvars64() -> Dict[str, str]:
    # %comspec% /k cmd
    comspec = os.environ['comspec']
    process = subprocess.Popen(
        [comspec, '/k', VCBARS64, '&', 'set', '&', 'exit'],
        stdout=subprocess.PIPE)

    old = {k: v for k, v in os.environ.items()}

    new = {}
    while True:
        rc = process.poll()
        if rc is not None:
            break
        output = process.stdout.readline()
        line = decode(output)

        if '=' in line:
            k, v = line.strip().split('=', 1)
            # print(k, v)
            new[k] = v

    # diff(new, old)

    if rc != 0:
        raise Exception(rc)

    return new


def install_packages(*packages: List[str]):
    if platform.system() == 'Linux':
        run('sudo', 'apt', 'install', '-y', *packages)


def decode(b: bytes) -> str:
    if platform.system() == 'Windows':
        return b.decode('cp932')
    else:
        return b.decode('utf-8')


def run(*cmd: List[str]):
    print(' '.join(cmd))
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    while True:
        rc = process.poll()
        if rc is not None:
            break
        output = process.stdout.readline()
        print(decode(output).strip())

    if rc != 0:
        raise Exception(rc)


def clean_deps():
    if DEPS.exists():
        shutil.rmtree(DEPS)


def clean_nvim():
    if BUILD.exists():
        shutil.rmtree(BUILD)


def clean():
    clean_deps()
    clean_nvim()
    if INSTALL_DIR.exists():
        shutil.rmtree(INSTALL_DIR)


def deps():
    '''
    build libs
    '''
    mkcd(DEPS)
    run('cmake', '../third-party', '-DCMAKE_BUILD_TYPE=RelWithDebInfo')
    run('cmake', '--build', '.', '--config', 'RelWithDebInfo')


def vc_option(line: str) -> str:
    if 'add_compile_options(/W3)' in line:
        return 'add_compile_options(/W3 /source-charset:utf-8 /wd4244 /wd4267 /wd4996 /wd4566)'
    else:
        return line


def patch(file: pathlib.Path):
    lines = [vc_option(line) for line in file.read_text().splitlines()]
    file.write_text('\n'.join(lines))


def nvim():
    '''
    build nvim
    '''
    mkcd(BUILD)

    # patch to CMakeLists.txt
    patch(NEOVIM_DIR / 'CMakeLists.txt')

    # single configuration(make etc)
    run('cmake', '..', '-DCMAKE_BUILD_TYPE=RelWithDebInfo')
    # multi configuration(vc etc)
    run('cmake', '--build', '.', '--config', 'RelWithDebInfo')


def install():
    mkcd(BUILD)
    # run('cmake', '--build', '.', '--target', 'install')
    run('cmake', '--install', '.', '--config', 'RelWithDebInfo', '--prefix',
        '../../install')

    print(INIT_DIR)
    if not INIT_DIR.exists():
        INIT_DIR.mkdir(parents=True)
    (INIT_DIR / 'init.lua').write_text(f'''# this is generated. entry point

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({{'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}})
  execute 'packadd packer.nvim'
end

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]
vim.cmd[[set runtimepath^={HERE / 'runtime'}]]
require 'plugins'
require 'setup'
''')

    (INIT_DIR / 'ginit.vim').write_text('''
set mouse=a
Guifont! Cica:h14
GuiTabline 0
GuiPopupmenu 0
''')


if __name__ == '__main__':

    #
    # setup
    #

    if platform.system() == 'Windows':
        # for luarocks detect vc
        vc_map = vcvars64()
        os.environ['VCINSTALLDIR'] = vc_map['VCINSTALLDIR']
    else:
        # ubuntu
        install_packages('libtool-bin', 'cmake')

    # pip
    pip.main(['install', 'pynvim', 'neovim-remote', 'yapf'])

    # cargo
    run('cargo install bat stylua')

    #
    # actions
    #
    if len(sys.argv) == 1:
        # all
        # actions = ['clean', 'deps', 'nvim', 'install']
        actions = ['deps', 'nvim', 'install']
    else:
        actions = sys.argv[1:]

    for action in actions:
        print(f'########## {action} ##########')
        locals()[action]()
