from typing import Optional
import pathlib
import platform
import os


def vc_option(line: str) -> str:
    if 'add_compile_options(/W3)' in line:
        return 'add_compile_options(/W3 /source-charset:utf-8 /wd4244 /wd4267 /wd4996 /wd4566)'
    else:
        return line


def patch(file: pathlib.Path):
    lines = [vc_option(line) for line in file.read_text().splitlines()]
    file.write_text('\n'.join(lines))


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

        hererocks_dir = 'packer_hererocks'
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

    def patch(self):
        patch(self.neovim_dir / 'CMakeLists.txt')


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
