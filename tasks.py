from invoke.context import Context
from invoke import task
import pathlib
from mynvim import MyNVim

MY = MyNVim(pathlib.Path(__file__).absolute().parent)


def run(c: Context, exe: pathlib.Path, *args: str, **kwargs):
    cmd = str(exe)
    if ' ' in cmd:
        cmd = f'"{cmd}"'
    cmd = f'{cmd} {" ".join(args)}'
    print(f'{pathlib.Path(c.cwd).absolute().relative_to(MY.root)}$ {cmd}')
    c.run(cmd, **kwargs)


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
    build neovim/third-party dependencies
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
    build neovim
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
