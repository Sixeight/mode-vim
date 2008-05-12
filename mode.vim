
" --Settings--
"
" Color bar settings
" 0 => short color bar
" 1 => long color bar
let s:color_bar = 0

" Mode name
let s:mode_think    = ' Think  '
let s:mode_red      = '  Red   '
let s:mode_green    = ' Green  '
let s:mode_refactor = 'Refactor'

" Mode Color
let s:think_color    = 'white'
let s:red_color      = 'red'
let s:green_color    = 'green'
let s:refactor_color = 'yellow'

" Key binds
nmap <silent> <leader>m<C-m> : call <SID>RotateMode()<CR>
nmap <silent> <leader>mc     : call <SID>ModeClear()<CR>
nmap <silent> <leader>mt     : call <SID>ModeThink()<CR>
nmap <silent> <leader>mg     : call <SID>ModeGreen()<CR>
nmap <silent> <leader>mr     : call <SID>ModeRed()<CR>
nmap <silent> <leader>mf     : call <SID>ModeRefactor()<CR>
"
" --End of settings--

" --Script main
let s:original = escape(&statusline, ' ')
if s:color_bar == 1 | let s:endflg = 1 |  endif

let s:think    = escape(s:mode_think, ' ')
let s:red      = escape(s:mode_red, ' ')
let s:green    = escape(s:mode_green, ' ')
let s:refactor = escape(s:mode_refactor, ' ')

func! s:RotateMode()
  let b:my_mode = (b:my_mode + 1) % 4
  if     b:my_mode == 0 | call s:ModeThink()
  elseif b:my_mode == 1 | call s:ModeRed()
  elseif b:my_mode == 2 | call s:ModeGreen()
  elseif b:my_mode == 3 | call s:ModeRefactor()
  endif
endfunc

func! s:ModeClear()
  let b:my_mode = -1
  hi clear User1
  hi User1 cterm=inverse,bold
  exe 'setlocal statusline=' . s:original
endfunc

func! s:ModeThink()
  let b:my_mode = 0
  call s:SetStatusLine(s:think, s:think_color)
endfunc

func! s:ModeRed()
  let b:my_mode = 1
  call s:SetStatusLine(s:red, s:red_color)
endfunc

func! s:ModeGreen()
  let b:my_mode = 2
  call s:SetStatusLine(s:green, s:green_color)
endfunc

func! s:ModeRefactor()
  let b:my_mode = 3
  call s:SetStatusLine(s:refactor, s:refactor_color)
endfunc

func! s:SetStatusLine(mode, color)
  exe 'hi User1 ctermfg=' . a:color
  exe 'setlocal statusline=%1*[' . a:mode . ']' . s:EndorHere('s:endflg', '%*') . '\ ' . s:original . '%=%*'
endfunc

func! s:EndorHere(flg, val)
  if exists(a:flg) | return ''
  else             | return a:val
  endif
endfunc

call s:ModeClear()

