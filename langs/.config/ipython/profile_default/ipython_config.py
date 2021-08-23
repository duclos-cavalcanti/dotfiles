# _____            _   _                 
#|_   _|          | | | |                
#  | | _ __  _   _| |_| |__   ___  _ __  
#  | || '_ \| | | | __| '_ \ / _ \| '_ \ 
# _| || |_) | |_| | |_| | | | (_) | | | |
# \___/ .__/ \__, |\__|_| |_|\___/|_| |_|
#     | |     __/ |                      
#     |_|    |___/                       
#

#Location - ~/.ipython/profile_default/ipython_config.py

import sys

c = get_config()

c.TerminalInteractiveShell.editor = 'vim'

c.TerminalInteractiveShell.editing_mode = 'emacs'

c.InteractiveShell.autoindent = True

c.InteractiveShell.confirm_exit = False

# c.InteractiveShell.pretty_print = True

c.AliasManager.user_aliases = [
 ('la', 'ls -al')
]

sys.path.insert(1, '/home/duclos/.config/ipython/profile_default/startup/')
from customscheme import CustomStyle as MyStyle

c.InteractiveShell.colors = 'neutral'
c.InteractiveShell.highlighting_style = MyStyle
c.TerminalInteractiveShell.highlighting_style_overrides = MyStyle.overrides

# Would be LOCATED in /usr/lib/python3.8/site-packages/pygments/styles/Custom.py.
# It is better however to plainly ovveride directly the colorscheme with the
# custom dict above.

# IPDB Debugger
from IPython.core import debugger
debugger.prompt="(ipdb) > "
