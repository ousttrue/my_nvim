#!/usr/bin/python3
import subprocess
import pathlib
import os
import platform
from typing import List

HERE = pathlib.Path(__file__).parent
NEOVIM_DIR = HERE / 'neovim'
DEPS = NEOVIM_DIR / '.deps'
BUILD = NEOVIM_DIR / 'build'


def install_packages(*packages: List[str]):
    if platform.system() == 'Linux':
        run(['sudo', 'apt', 'install', '-y'] + packages)


def run(*cmd: List[str]):
    print(' '.join(cmd))
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    while True:
        rc = process.poll()
        if rc is not None:
            break
        output = process.stdout.readline()
        print(output.decode('utf-8').strip())
    print(rc)


def install():
    if platform.system() == 'Linux':
        # install to /usr/local/bin
        run('sudo', 'cmake', '--install', '.')
    else:
        raise NotImplementedError()


if __name__ == '__main__':

    install_packages('libtool-bin', 'cmake')

    # https://github.com/neovim/neovim/wiki/Building-Neovim

    #
    # build libs
    #
    if not DEPS.exists():
        DEPS.mkdir()
    os.chdir(DEPS)
    run('cmake', '../third-party')
    run('cmake', '--build', '.')

    #
    # build nvim
    #
    if not BUILD.exists():
        BUILD.mkdir()
    os.chdir(BUILD)
    run('cmake', '..')
    run('cmake', '--build', '.')

    install()
