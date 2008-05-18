
" --Settings--
"
" Color bar settings
" 0 => short 1 => long
let s:color_bar = 0

" Mode name
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
nmap <silent> <leader>m<C-m> : call <SID>RotateMode()<CR>
nmap <silent> <leader>mc     : call <SID>ClearMode()<CR>
" mode think
nmap <silent> <leader>mt     : call <SID>ChangeMode(0)<CR>
" mode red
nmap <silent> <leader>mr     : call <SID>ChangeMode(1)<CR>
" mode green
nmap <silent> <leader>mg     : call <SID>ChangeMode(2)<CR>
" mode refactor
nmap <silent> <leader>mf     : call <SID>ChangeMode(3)<CR>
"
" --End of settings--

" --Script main--
let s:original = escape(&statusline, ' ')
let s:hlend = (s:color_bar == 1) ? '' : '%*'

let s:mode_list = [[s:color_think,    escape(s:mode_think, ' ')],
                \  [s:color_red,      escape(s:mode_red, ' ')],
                \  [s:color_green,    escape(s:mode_green, ' ')],
                \  [s:color_refactor, escape(s:mode_refactor, ' ')]]

func! s:ClearMode()
  let b:current_mode = -1
  hi clear User1
  hi User1 cterm=inverse,bold
  exe 'setlocal statusline=' . s:original
endfunc

func! s:RotateMode()
  let b:current_mode = (b:current_mode + 1) % 4
  if     b:current_mode == 0 | call s:ChangeMode(0)
  elseif b:current_mode == 1 | call s:ChangeMode(1)
  elseif b:current_mode == 2 | call s:ChangeMode(2)
  elseif b:current_mode == 3 | call s:ChangeMode(3)
  endif
endfunc

func! s:ChangeMode(mode)
  let b:current_mode = a:mode
  exe 'hi User1 ctermfg=' . s:mode_list[a:mode][0]
  exe 'setlocal statusline=%1*' . s:mode_list[a:mode][1] . s:hlend . s:original . '%=%*'
endfunc

call s:ClearMode()

