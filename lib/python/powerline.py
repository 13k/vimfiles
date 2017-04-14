import os
import sys

POWERLINE_PIP_PATH_ENV_VAR = "POWERLINE_PIP_PATH"

def setup_powerline():
    path = os.getenv(POWERLINE_PIP_PATH_ENV_VAR)

    if path is None:
        return

    sys.path.insert(0, path)

    try:
        from powerline.vim import setup as powerline_setup
        powerline_setup()
        del powerline_setup
    except ImportError:
        return

setup_powerline()
del setup_powerline
del POWERLINE_PIP_PATH_ENV_VAR
