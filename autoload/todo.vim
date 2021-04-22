let g:loaded_todo = 1

let s:buf_name        = '__todo__'
let s:help_view       = 0

function! s:BuildTodo() abort
  let entries = []
  for cmd in ['git grep -niIw -e TODO: -e FIXME: -e NOTE: 2> /dev/null',
            \ 'grep -rniIw -e TODO: -e FIXME: -e NOTE: . 2> /dev/null']
    let lines = split(system(cmd), '\n')
    if v:shell_error != 0 | continue | endif
    for line in lines
      let [fname, lno, text] = matchlist(line, '^\([^:]*\):\([^:]*\):\(.*\)')[1:3]
      call add(entries, { 'filename': fname, 'lnum': lno, 'text': text })
    endfor
    break
  endfor
  if !empty(entries)
    call setqflist(entries)
    copen
  endif
endfunction

function! todo#ToggleList() abort
  call s:BuildTodo()
endfunction

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>
autocmd FileType qf nnoremap <buffer> <ESC> :cclose<CR>
