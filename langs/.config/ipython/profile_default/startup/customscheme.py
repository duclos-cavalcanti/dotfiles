from pygments.style import Style
from pygments.token import Keyword, Name, Comment, String, Error, \
     Number, Operator, Generic, Whitespace, Token

# Location: ~/.config/ipython/profile_default/startup/customscheme.py

class CustomStyle(Style):
    """
    Styles Custom to my Arch theme. 
    pygments package must be installed. This file should be located at 
    /usr/lib/python3.8/site-packages/pygments/styles/Custom.py.

    sudo ln -sf custom_scheme.py /usr/lib/python3.8/site-packages/pygments/styles/

    """

    background_color = "#404552"
    highlight_color = "#ffffff"
    default_style = "#ffffff"

    styles = {
        Token:                      "#ffffff",
        Token.Prompt:               "#ffffff",
        Token.PromptNum:            "#ffffff",
        Token.String:               "#ffffff",
        Token.Generic:              "#ffffff",
        Token.OutPrompt:            "#ffffff",
        Token.OutPromptNum:         "#ffffff",
        Token.PromptInsertMode:     "#ffffff",

        Whitespace:                "",
        Comment:                   "#7c818c",
        Comment.Preproc:           "#7c818c",
        Comment.Special:           "bold #7c818c",

        Keyword:                   "#ffffff",
        Keyword.Declaration:       "#ffffff",
        Keyword.Namespace:         "#ffffff",
        Keyword.Pseudo:            "#ffffff",
        Keyword.Type:              "#ffffff",

        Operator:                  "#00bcd4",
        Operator.Word:             "#00bcd4",

        Name:                      "#00bcd4",
        Name.Class:                "#00bcd4",
        Name.Builtin:              "#00bcd4",
        Name.Exception:            "bold #00bcd4",
        Name.Variable:             "#ffffff",

        String:                    "#cbdef6",
        Number:                    "#cbdef6",

        Generic:                   "#ffffff",
        Generic.Heading:           "#ffffff",
        Generic.Subheading:        "#ffffff",
        Generic.Deleted:           "#ffffff",
        Generic.Inserted:          "#00cd00",
        Generic.Error:             "#d41800",
        Generic.Emph:              "#ffffff",
        Generic.Strong:            "#ffffff",
        Generic.Prompt:            "#ffffff",
        Generic.Output:            "#d41800",
        Generic.Traceback:         "#ffffff",

        Error:                     "border:#d41800"
    }

    overrides= {
        Token:                      "#ffffff",
        Token.Prompt:               "#ffffff",
        Token.PromptNum:            "#ffffff",
        Token.String:               "#ffffff",
        Token.Generic:              "#ffffff",
        Token.OutPrompt:            "#ffffff",
        Token.OutPromptNum:         "#ffffff",
        Token.PromptInsertMode:     "#ffffff"
    }
