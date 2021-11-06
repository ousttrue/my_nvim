def task_clone():
    '''
    clone neovim
    '''
    return {
        # 'targets': ['requests.png'],
        'actions': ['dot -Tpng %(dependencies)s -o %(targets)s'],
    }

