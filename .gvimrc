" vim: foldmethod=marker

" My mods to gvimrc                              {{{1
" Preferences                                    {{{2
set guioptions-=T   "remove the toolbar
set guifont=Inconsolata-g\ for\ Powerline
" Colourschemes                                  {{{2
" Default colour for MacVim to blue!
colorscheme blue
" and to dark blue if it is xml file"
au FileType xml      colorscheme darkblue
au FileType ruby     colorscheme slate
au FileType c        colorscheme molokai
"au BufEnter *.h     colorscheme molokai
au FileType cpp      colorscheme desert
au FileType markdown colorscheme molokai
au FileType python   colorscheme molokai
" stored in case markdown detection is not good enough
"au BufEnter *.md  colorscheme molokai
"au BufEnter *.markdown  colorscheme molokai


" MacVim Defaults - WHAT ARE THEY?               {{{1

" Make sure the '<' and 'C' flags are not included in 'cpoptions', otherwise
" <CR> would not be recognized.  See ":help 'cpoptions'".
"let s:cpo_save = &cpo
"set cpo&vim

"if !exists("syntax_on")
  "syntax on
"endif


" To make tabs more readable, the label only contains the tail of the file
" name and the buffer modified flag.
"set guitablabel=%M%t

" Send print jobs to Preview.app.  This does not delete the temporary ps file
" that is generated by :hardcopy.
"set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ +\ v:shell_error


" This is so that HIG Cmd and Option movement mappings can be disabled by
" adding the line
"   let macvim_skip_cmd_opt_movement = 1
" to ~/.vimrc.
"if !exists("macvim_skip_cmd_opt_movement")
  "no   <D-Left>       <Home>
  "no!  <D-Left>       <Home>
  "no   <M-Left>       <C-Left>
  "no!  <M-Left>       <C-Left>
"
  "no   <D-Right>      <End>
  "no!  <D-Right>      <End>
  "no   <M-Right>      <C-Right>
  "no!  <M-Right>      <C-Right>
"
  "no   <D-Up>         <C-Home>
  "ino  <D-Up>         <C-Home>
  "no   <M-Up>         {
  "ino  <M-Up>         <C-o>{
"
  "no   <D-Down>       <C-End>
  "ino  <D-Down>       <C-End>
  "no   <M-Down>       }
  "ino  <M-Down>       <C-o>}
"
  "ino  <M-BS>         <C-w>
  "ino  <D-BS>         <C-u>
"endif " !exists("macvim_skip_cmd_opt_movement")


" This is so that the HIG shift movement related settings can be enabled by
" adding the line
"   let macvim_hig_shift_movement = 1
" to ~/.vimrc.
"if exists("macvim_hig_shift_movement")
  "" Shift + special movement key (<S-Left>, etc.) and mouse starts insert mode
  "set selectmode=mouse,key
  "set keymodel=startsel,stopsel

  " HIG related shift + special movement key mappings
  "nn   <S-D-Left>     <S-Home>
  "vn   <S-D-Left>     <S-Home>
  "ino  <S-D-Left>     <S-Home>
  "nn   <S-M-Left>     <S-C-Left>
  "vn   <S-M-Left>     <S-C-Left>
  "ino  <S-M-Left>     <S-C-Left>

  "nn   <S-D-Right>    <S-End>
  "vn   <S-D-Right>    <S-End>
  "ino  <S-D-Right>    <S-End>
  "nn   <S-M-Right>    <S-C-Right>
  "vn   <S-M-Right>    <S-C-Right>
  "ino  <S-M-Right>    <S-C-Right>

  "nn   <S-D-Up>       <S-C-Home>
  "vn   <S-D-Up>       <S-C-Home>
  "ino  <S-D-Up>       <S-C-Home>

  "nn   <S-D-Down>     <S-C-End>
  "vn   <S-D-Down>     <S-C-End>
  "ino  <S-D-Down>     <S-C-End>
"endif " exists("macvim_hig_shift_movement")


" Restore the previous value of 'cpoptions'.
"let &cpo = s:cpo_save
"unlet s:cpo_save
