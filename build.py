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
from typing import Dict, Optional


class MyNVim:
    def __init__(self, root: pathlib.Path):
        self.root = root
        self.install_dir = self.root / 'install'
        self.init_vim_template = self.root / 'init.vim'
        self.ginit_vim_template = self.root / 'ginit.vim'
        self.language_server_dir = self.root / 'language_server'
        # neovim source
        self.neovim_dir = self.root / 'neovim'
        self.deps = self.neovim_dir / '.deps'
        self.build = self.neovim_dir / 'build'

        self.init_dir = self._get_init_dir()
        self.home_dir = self._get_home_dir()

        self.git_exe = self._get_from_path('git')
        self.cmake_exe = self._get_from_path(
            'cmake', "C:/Program Files/CMake/bin/cmake.exe")
        self.cargo_exe = self._get_cargo_exe()

        self.luarocks_bat_template = self.root / 'luarocks.bat'
        self.luarocks_dir = self.neovim_dir / '.deps/usr/luarocks'
        hererocks_dir = 'packer_hererocks/2.1.0-beta3'
        if platform.system() == "Windows":
            self.hererocks_dir = pathlib.Path(os.environ['USERPROFILE']) / (
                'AppData/Local/Temp/nvim/' + hererocks_dir)
        else:
            self.hererocks_dir = pathlib.Path(
                os.environ['HOME']) / ('.cache/nvim/' + hererocks_dir)

    def _get_home_dir(self) -> pathlib.Path:
        if 'USERPROFILE' in os.environ:
            return pathlib.Path(os.environ['USERPROFILE']).absolute()
        else:
            return pathlib.Path(os.environ['HOME']).absolute()

    def _get_init_dir(self) -> pathlib.Path:
        if platform.system() == 'Windows':
            if 'XDG_CONFIG_HOME' in os.environ:
                xdg_home_dir = pathlib.Path(
                    os.environ['XDG_CONFIG_HOME']).absolute()
                return xdg_home_dir / 'nvim'
            else:
                APPDATA_DIR = pathlib.Path(os.environ['APPDATA']).absolute()
                return APPDATA_DIR.parent / 'Local/nvim'
        else:
            home_dir = pathlib.Path(os.environ['HOME']).absolute()
            return home_dir / '.config/nvim'

    def _get_cargo_exe(self) -> pathlib.Path:
        cargo = self.home_dir / '.cargo/bin/cargo'
        if cargo.exists():
            return cargo
        cargo = self.home_dir / '.cargo/bin/cargo.exe'
        if cargo.exists():
            return cargo
        raise Exception('no cargo')

    def _get_from_path(self,
                       name: str,
                       default: Optional[str] = None) -> pathlib.Path:
        if platform.system() == "Windows":
            name = name + ".exe"
            delimiter = ';'
        else:
            delimiter = ':'

        for path in os.environ['PATH'].split(delimiter):
            exe = pathlib.Path(path) / name
            if exe.exists():
                return exe

        if default:
            cmake = pathlib.Path(default)
            if cmake.exists():
                return cmake

        raise FileNotFoundError(name)


MY = MyNVim(pathlib.Path(__file__).absolute().parent)

VCBARS64 = 'C:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\BuildTools\\VC\\Auxiliary\\Build\\vcvars64.bat'


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

    stdout = process.stdout
    if not stdout:
        raise Exception()

    # old = {k: v for k, v in os.environ.items()}

    new = {}
    while True:
        rc = process.poll()
        if rc is not None:
            break
        output = stdout.readline()
        line = decode(output)

        if '=' in line:
            k, v = line.strip().split('=', 1)
            # print(k, v)
            new[k] = v

    # diff(new, old)

    if rc != 0:
        raise Exception(rc)

    return new


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


def vc_option(line: str) -> str:
    if 'add_compile_options(/W3)' in line:
        return 'add_compile_options(/W3 /source-charset:utf-8 /wd4244 /wd4267 /wd4996 /wd4566)'
    else:
        return line


def patch(file: pathlib.Path):
    lines = [vc_option(line) for line in file.read_text().splitlines()]
    file.write_text('\n'.join(lines))


def nvim(my: MyNVim):
    '''
    build nvim
    '''
    mkcd(my.build)

    # patch to CMakeLists.txt
    patch(my.neovim_dir / 'CMakeLists.txt')

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
                'packer_hererocks_lua_path': f'{my.hererocks_dir}/lua/?.lua;{my.hererocks_dir}/lib/lua/?/init.lua',
                'packer_hererocks_path': f'{my.hererocks_dir}/luarocks.lua',
                'luajit_exe': f'{my.deps}/usr/bin/luajit.exe',
                'luarocks_lua': f'{my.deps}/usr/luarocks/luarocks.lua',
            }))

if __name__ == '__main__':

    if platform.system() == 'Windows':
        # for luarocks detect vc
        vc_map = vcvars64()
        os.environ['VCINSTALLDIR'] = vc_map['VCINSTALLDIR']

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
