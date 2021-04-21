scriptencoding utf-8

if &cp || exists('g:loaded_todo')
    finish
endif

command! Todo call todo#CreateTodoList()
