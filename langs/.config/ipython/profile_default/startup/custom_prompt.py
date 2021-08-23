from IPython.terminal.prompts import Prompts, Token
from IPython.core.interactiveshell import InteractiveShell
import os

#Location: ~/.config/ipython/startup/custom_prompt.py

class MyPrompt(Prompts):
    def in_prompt_tokens(self):
        D_In= [
                (Token.Prompt, self.vi_mode() ),
                (Token.Prompt, 'In ['),
                (Token.PromptNum, str(self.shell.execution_count)),
                (Token.Prompt, ']: '),
            ]
        return D_In
        #return [ (Token.Prompt, " $ ") ]

    def out_prompt_tokens(self):
        D_Out = [ 
            (Token.OutPrompt, 'Out['),
            (Token.OutPromptNum, str(self.shell.execution_count)),
            (Token.OutPrompt, ']: '),
              ]

        #return D_Out
        return [ (Token.OutPrompt, " ") ]

ip=InteractiveShell.instance()
ip.prompts=MyPrompt(ip)

