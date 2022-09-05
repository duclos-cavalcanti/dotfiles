local ls = require "luasnip"

local M = {}

function M.config()
    ls.config.set_config {
        history = true,
        updateevents = "TextChanged,TextChangedI",
        enable_autosnippets = true,
    }
end

function M.setup()
    ls.cleanup()
    ls.add_snippets("all", {
            ls.parser.parse_snippet("hello", "hello world"),
        }
    )

    ls.add_snippets("markdown", {
            ls.parser.parse_snippet("tb",
[[
| ${0:foo} | ${1:bar} | ${2:baz} |
| ---------|----------|----------|
| x        |    y     |     z    |
| x        |    y     |     z    |
]]),
            ls.parser.parse_snippet("ch",
[[
- [ ] ${1:todo}
]]),
            ls.parser.parse_snippet("drop",
[[
<details closed>
<summary>
${1:title}
</summary>
$0
</details>
]]),
            ls.parser.parse_snippet("img",
[[
![${0:title}](.imgs/${1:img}.png)
]]),
            ls.parser.parse_snippet("link",
[[
[${0:word}](${1:url})
]]),
            ls.parser.parse_snippet("table",
[[
1. [Introduction](#intro)
    1. [sub](#sub1)
    2. [sub2](#sub2)
    3. [sub3](#sub3)

<a name="intro"/>
]])
        }
    )

    ls.add_snippets("tex", {
            ls.parser.parse_snippet("bold",
[[
\textbf{$1}$0]]),
            ls.parser.parse_snippet("ita",
[[
\textit{$1}$0]]),
            ls.parser.parse_snippet("cite",
[[
\cite{$1}$0]]),
            ls.parser.parse_snippet("ref",
[[
\ref{$1}$0]]),
            ls.parser.parse_snippet("lb",
[[
\label{$1}$0]]),
            ls.parser.parse_snippet("red",
[[
\textcolor{red}{
    $0
}]]),
            ls.parser.parse_snippet("subfg",
[[
\begin{figure}
\centering
    \begin{subfigure}{0.1\textwidth}
    \includegraphics[width=\textwidth]{$1}
    \caption{First subfigure.}
    \label{fig:first}
\end{subfigure}
\hfill
    \begin{subfigure}{0.1\textwidth}
    \includegraphics[width=\textwidth]{$2}
    \caption{Second subfigure.}
    \label{fig:second}
\end{subfigure}
\caption{Creating subfigures in \LaTeX.}
\label{fig:figures}
\end{figure}
}]]),
    })

    ls.add_snippets("c", {
            ls.parser.parse_snippet("if",
[[
if ({$1}) {
    $0
}
]]),
            ls.parser.parse_snippet("ife",
[[
if ({$1}) {
    $2
} else {
    $0
}
]]),
    })
end

return M
