
" Color bar settings
" 0 => short, 1 => long
let s:color_bar = 0

" Mode strings
let s:mode_think    = '[ Think  ]'
let s:mode_red      = '[  Red   ]'
let s:mode_green    = '[ Green  ]'
let s:mode_refactor = '[Refactor]'

" Mode Color
let s:color_think    = 'white'
let s:color_red      = 'red'
let s:color_green    = 'green'
let s:color_refactor = 'yellow'

" Key binds
nmap <silent> <leader>m<C-m> :call <SID>RotateMode()<CR>
nmap <silent> <leader>mc :call <SID>ClearMode()<CR>
nmap <silent> <leader>mt :call <SID>ChangeMode('think')<CR>
nmap <silent> <leader>mr :call <SID>ChangeMode('red')<CR>
nmap <silent> <leader>mg :call <SID>ChangeMode('green')<CR>
nmap <silent> <leader>mf :call <SID>ChangeMode('refactor')<CR>

" --Script main--
let s:original = escape(&statusline, ' ')
let s:hlend = (s:color_bar == 1) ? '\ ' : '%*\ '

let s:mode_dict = {'think'   : [0, s:color_think,    escape(s:mode_think, ' ')],
                \  'red'     : [1, s:color_red,      escape(s:mode_red, ' ')],
                \  'green'   : [2, s:color_green,    escape(s:mode_green, ' ')],
                \  'refactor': [3, s:color_refactor, escape(s:mode_refactor, ' ')]}

func! s:ClearMode()
  let b:current_mode = -1
  hi clear User1
  hi User1 cterm=inverse,bold
  exe 'setlocal statusline=' . s:original
endfunc

func! s:RotateMode()
  let b:current_mode = (b:current_mode + 1) % 4
  if     b:current_mode == 0 | call s:ChangeMode('think')
  elseif b:current_mode == 1 | call s:ChangeMode('red')
  elseif b:current_mode == 2 | call s:ChangeMode('green')
  elseif b:current_mode == 3 | call s:ChangeMode('refactor')
  endif
endfunc

func! s:ChangeMode(mode)
  let m = eval("s:mode_dict['" . a:mode. "']")
  let b:current_mode = m[0]
  exe 'hi User1 ctermfg=' . m[1]
  exe 'setlocal statusline=%1*' . m[2] . s:hlend . s:original . '%=%*'
endfunc

call s:ClearMode()

