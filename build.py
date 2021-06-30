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


def vcvars64():
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

    diff(new, old)

    if rc != 0:
        raise Exception(rc)

    sys.exit()


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
        raise NotImplementedError()


if __name__ == '__main__':

    # vcvars64()

    install_packages('libtool-bin', 'cmake')

    # https://github.com/neovim/neovim/wiki/Building-Neovim

    #
    # build libs
    #
    # if DEPS.exists():
    #     shutil.rmtree(DEPS)
    DEPS.mkdir(exist_ok=True)
    os.chdir(DEPS)
    run('cmake', '../third-party')
    run('cmake', '--build', '.', '--config', 'RelWithDebInfo')

    #
    # build nvim
    #
    # if BUILD.exists():
    #     shutil.rmtree(BUILD)
    BUILD.mkdir(exist_ok=True)
    os.chdir(BUILD)
    run('cmake', '..')
    run('cmake', '--build', '.', '--config', 'RelWithDebInfo')

    install()

    # TODO: setup init.lua
