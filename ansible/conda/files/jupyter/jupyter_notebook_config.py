c = get_config()

# Run all nodes interactively
from IPython.core.interactiveshell import InteractiveShell
c.InteractiveShell.ast_node_interactivity = 'all'

c.InlineBackend.figure_format = 'retina'

c.InteractiveShellApp.exec_lines=[
    'import sys; sys.path.append("/usr/local/anaconda/bin/conda")'
]

### If you want to auto-save .html and .py versions of your notebook:
# modified from: https://github.com/ipython/ipython/issues/8009
import os
from subprocess import check_call

def post_save(model, os_path, contents_manager):
    """post-save hook for converting notebooks to .py scripts"""
    if model['type'] != 'notebook':
        return # only do this for notebooks
    d, fname = os.path.split(os_path)
    check_call(['jupyter', 'nbconvert', '--to', 'script', fname], cwd=d)
    check_call(['jupyter', 'nbconvert', '--to', 'html', fname], cwd=d)

c.FileContentsManager.post_save_hook = post_save

c.NotebookApp.ip = '127.0.0.1'
c.NotebookApp.port = 8889
c.NotebookApp.open_browser = False
