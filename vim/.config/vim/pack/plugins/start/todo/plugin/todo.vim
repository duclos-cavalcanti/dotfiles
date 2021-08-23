" Todo.vim 
" A minimalist todo list manager heavily inspired/base from/on the
" bujo plugin from:
"   Maintainer:   Jersey Fonseca <http://www.jerseyfonseca.com/>
"   Version:      0.5
"
" Planning on modifying/extending it.

" Get custom configs
let g:todo#todo_file_path = get(g:, "todo#todo_file_path", $HOME . "/.cache/todo")
let g:todo#window_width = get(g:, "todo#window_width", 30)

" Make todo directory if it doesn't exist"
if empty(glob(g:todo#todo_file_path))
  call mkdir(g:todo#todo_file_path)
endif

" Tells us if the directory we are currently working in is a git repository.
function s:InGitRepository()
    :silent let bool = system("git rev-parse --is-inside-work-tree")

    " The git function will return true with some leading characters.
    if split(bool, '\v\n')[0] == 'true'
      return 1
  else
      return 0
    endif
endfunction


" Gives us a clean name of the git repository currently on.
function s:GetToplevelFolder()
    let absolute_path = system("git rev-parse --show-toplevel")
    let repo_name = split(absolute_path, "/")
    let repo_name_clean = split(repo_name[-1], '\v\n')[0]
    return repo_name_clean
endfunction


" Returns which file path we will be using. 
"
" If we are in a git repository, we return the directory for that specific git repo.
"
" Otherwise, we return the general file path. 
"
function s:GetTodoFilePath(general)
    "If general argument is not empty OR there is no current git repo.
    if a:general || !s:InGitRepository()
        "Global Todo
        return g:todo#todo_file_path . "/todo.md"
    else
        let repo_name = s:GetToplevelFolder()
        let todo_path = g:todo#todo_file_path . "/" . repo_name 
        if empty(glob(todo_path))
            call mkdir(todo_path)
        endif
        return todo_path . "/todo.md"
    endif
endfunction


" Opens the respective todo.md file from g:todo#todo_file_path.
"
" If we are in a git repository, we open the todo.md for that git repository.
"
" Otherwise, we open the global todo file.
"
" Paramaters : 
" 
"   mods    - allows a user to use <mods> (see :h mods)
" 
"   ...     - any parameter after calling :Todo will mean that the user wants
"             us to open the general file path.
function s:OpenTodo(mods, ...)
    "Argument(s) after :Todo.
    let general_bool = a:0
    let todo_path = s:GetTodoFilePath(general_bool)
    exe a:mods . " " . g:todo#window_width "vs  " . todo_path
endfunction

if !exists(":Todo")
    "Creates vim command-line callable function that may have 0 or 1 arguments
    command -nargs=? Todo :call s:OpenTodo(<q-mods>, <f-args>)
endif

" Update title of the todo mardown file upon file create. 
autocmd bufnewfile todo.md call append(0, '#' . split(expand('%:p:h:t'), '\v\n')[0] . " todo")  
