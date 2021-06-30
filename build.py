#!/usr/bin/python3
'''

if Windows, run from vcvars64.bat for luarocks build.
or stop 'mingw32-gcc' not found.

'''
import subprocess
import pathlib
import shutil
import os
import sys
import platform
from typing import List, Dict

HERE = pathlib.Path(__file__).absolute().parent
NEOVIM_DIR = HERE / 'neovim'
DEPS = NEOVIM_DIR / '.deps'
BUILD = NEOVIM_DIR / 'build'

VCBARS64 = 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat'


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
        run(['sudo', 'apt', 'install', '-y'] + packages)


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


def install():
    if platform.system() == 'Linux':
        # install to /usr/local/bin
        run('sudo', 'cmake', '--install', '.')
    else:
        pass


def deps():
    #
    # build libs
    #
    # if DEPS.exists():
    #     shutil.rmtree(DEPS)
    DEPS.mkdir(exist_ok=True)
    os.chdir(DEPS)
    run('cmake', '../third-party')
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
    #
    # build nvim
    #
    # if BUILD.exists():
    #     shutil.rmtree(BUILD)
    BUILD.mkdir(exist_ok=True)
    os.chdir(BUILD)

    # patch to CMakeLists.txt
    patch(NEOVIM_DIR / 'CMakeLists.txt')

    run('cmake', '..')
    run('cmake', '--build', '.', '--config', 'RelWithDebInfo')


if __name__ == '__main__':

    #
    # setup
    #

    # for luarocks detect vc
    vc_map = vcvars64()
    os.environ['VCINSTALLDIR'] = vc_map['VCINSTALLDIR']

    install_packages('libtool-bin', 'cmake')

    # https://github.com/neovim/neovim/wiki/Building-Neovim

    if len(sys.argv) == 1:
        # all
        # actions = ['deps', 'nvim', 'install']
        actions = ['nvim', 'install']
    else:
        actions = sys.argv[1:]

    for action in actions:
        print(f'########## {action} ##########')
        locals()[action]()

    # TODO: setup init.lua
