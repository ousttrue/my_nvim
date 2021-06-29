#!/usr/bin/python3
import subprocess
import pathlib
import os
from typing import List

HERE = pathlib.Path(__file__).parent
NEOVIM_DIR = HERE / 'neovim'
DEPS = NEOVIM_DIR / '.deps'
BUILD = NEOVIM_DIR / 'build'


def run(cmd: List[str]):
    print(' '.join(cmd))
    process = subprocess.Popen(cmd, stdout=subprocess.PIPE)
    while True:
        rc = process.poll()
        if rc is not None:
            break
        output = process.stdout.readline()
        print(output.decode('utf-8').strip())
    print(rc)


if __name__ == '__main__':

    run(['sudo', 'apt', 'install', 'libtool-bin', 'cmake', '-y'])

    # https://github.com/neovim/neovim/wiki/Building-Neovim

    if not DEPS.exists():
        DEPS.mkdir()
    os.chdir(DEPS)
    run(['cmake', '../third-party'])
    run(['cmake', '--build', '.'])

    if not BUILD.exists():
        BUILD.mkdir()
    os.chdir(BUILD)
    run(['cmake', '..'])
    run(['cmake', '--build', '.'])
    # install to /usr/local/bin
    run(['sudo', 'cmake', '--install', '.'])
