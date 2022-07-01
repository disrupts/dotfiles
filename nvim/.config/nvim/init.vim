" vim: nowrap fdm=marker
set encoding=utf-8

if &compatible
  set nocompatible
endif

" Basics                                         {{{1
" Preferences not set by nvim                    {{{2
set hidden                  " allow hidden buffers
set relativenumber          " set relative numbering
set number                  " set hybrid numbering
"set showcmd
set nojoinspaces
set listchars=tab:▸\ ,eol:¬ " set new tab and return symbols
set foldlevelstart=20       " folding max out by default
set noswapfile              " disables swap file - BAD
set wrap                    " soft wraping
set linebreak               " remember to toggle nolist with <leader>-l
set ignorecase              " ignore case
set smartcase               " smart case
set spelllang=en_gb         " set language to british english
set mouse=a                 " is this by default now?
" set termguilcolors          " true colour
" set notermguicolors         " gui colours off by default, turn them for default schemes
" set noshowmode              " hides --INSERT--,
                            " use only if a status line is installed


" Default Indentation (Tab configuration)        {{{2
"set ts=2 sts=2 sw=2 expandtab
set ts=4 sts=4 sw=4 expandtab

" FileType detection                             {{{1
" Markdown
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
" *.markdown is already detected

" C header files - instead of C++
autocmd BufNewFile,BufReadPost *.h set filetype=c

" Assembly will be understood as MIPS
autocmd BufNewFile,BufReadPost *.asm set filetype=MIPS

" Fountain film-script detection
autocmd BufNewFile,BufReadPost *.fountain set filetype=fountain

" Filetype configs                               {{{2
autocmd FileType MIPS setlocal foldmethod=indent
autocmd FileType MIPS setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType MIPS setlocal list

autocmd filetype c setlocal foldmethod=syntax
autocmd filetype c setlocal list

autocmd Filetype cpp setlocal foldmethod=syntax
autocmd Filetype cpp setlocal list

autocmd filetype haskell setlocal foldmethod=syntax
autocmd FileType haskell setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType haskell setlocal list

autocmd FileType matlab setlocal foldmethod=indent
autocmd FileType matlab setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType matlab setlocal list
autocmd FileType matlab setlocal fileencoding=latin1

autocmd FileType python setlocal ts=4 sts=4 sw=4 expandtab
autocmd FileType python setlocal list
"autocmd FileType python source ~/.local/share/nvim/site/plugged/...
"jpythonfold.vim
"
autocmd filetype ruby setlocal foldmethod=syntax
autocmd filetype ruby setlocal list 

autocmd filetype sh setlocal foldmethod=syntax
autocmd filetype sh setlocal list

autocmd filetype vhdl setlocal foldmethod=indent
autocmd filetype vhdl setlocal list

autocmd filetype vim setlocal foldmethod=syntax
autocmd filetype vim setlocal list

autocmd filetype zsh setlocal foldmethod=syntax
autocmd filetype zsh setlocal list 

autocmd filetype xml setlocal foldmethod=syntax
autocmd filetype xml setlocal list 

" Fuzzy search                                   {{{1
set path+=** " tab completion for all file-related tasks
set wildmenu " display all matching files when we tab complete

" Ctags                                          {{{1
"" vim commmand that will run in the shell
" let uname = system('uname -s')
"if uname == "OpenBSD\n"
if $OS == "OpenBSD"
    " universal-ctags is in ports
    command! CtagsBuild !uctags -R .
else
    " universal-ctags is deaulft in arch
    command! CtagsBuild !ctags -R .  
endif

" netrw configs                                  {{{1
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'


" Visuals                                        {{{1
" Colourscheme                                   {{{2
"colorscheme molokai
colorscheme bubblegum

" Mark 81st column visible                       {{{2
" Trying out SmartColumnColor plugin instead of the following
" highlight ColorColumn ctermbg=magenta
" call matchadd('ColorColumn', '\%81v', 100)

" Executed when opening & closing a buffer       {{{1
" Go to last location when opening a file        {{{2
 autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|  endif

" Saves the state of foldings and reopens them   {{{2
" BROKEN
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview

" Strip trailing whitespace                      {{{2
autocmd BufWritePre * :%s/\s\+$//e

" Notes                                          {{{1

"runtime! plugin/sensible.vim
" & somehow, the pluggin changes some colours! the magenta marker for char 80
" is grey... not visible with some colorschemes in grafical vim
" vim: nowrap fdm=marker

" Mappings                                       {{{1
" Setting Leader key and Esc key                 {{{2
" map! ñ <Esc> " no longer used since hjkl is now jklñ
let mapleader="-"

" move hjlk to jklñ                              {{{2
noremap j h
noremap k j
noremap l k
noremap ñ l

" Disablel arrow keys                            {{{2
" disable arrow keys in insert mode              {{{3
" inoremap <up>       <nop>
" inoremap <down>     <nop>
" inoremap <left>     <nop>
" inoremap <right>    <nop>

" disable arrow keys in normal mode              {{{3
" nnoremap <up>       <nop>
" nnoremap <down>     <nop>
" nnoremap <left>     <nop>
" nnoremap <right>    <nop>

" disable arrow keys in visual mode              {{{3
" vnoremap <up>       <nop>
" vnoremap <down>     <nop>
" vnoremap <left>     <nop>
" vnoremap <right>    <nop>

" un-highlight with Delete key - already ctrl-l {{{2
nmap <silent> <BS> :nohlsearch<CR>
" BAD should I remove <silent>

" use spacebar to fold                           {{{2
nnoremap <Space> za

" Enter BLOCK-VISUAL by default                  {{{2
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v

" Shortcut to rapidly toggle `set list`          {{{2
" nnoremap <leader>l :set list! list?<CR>
nnoremap <leader>l :call <SID>Better_list_with_marker_and_hardwrap()<CR>
function! <SID>Better_list_with_marker_and_hardwrap()
  if (&list == 0)
    set list
    set textwidth=0
    set formatoptions-=ta
    echom "auto-hardwrapping deactivated; list & column marker enabled"
  else
    set nolist
    set textwidth=79
    set formatoptions+=ta
    echom "list & column marker disabled; auto-hardwrapping activated"
  endif
endfunction

" Spell Checking                                 {{{2
nnoremap <leader>s :set spell!<CR>
nnoremap <leader>sen :set spelllang=en_gb<CR>
nnoremap <leader>ses :set spelllang=es_es<CR>
nnoremap <leader>sfr :set spelllang=fr<CR>

" Movement & navigation mappings                 {{{2
" Simplify movement around windows               {{{3
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Simplify changing window arrangement           {{{3
" vim can't distinguish ctrl-letter from ctrl-shift-letter
"nnoremap <C-S-h> <C-w>H
"nnoremap <C-S-j> <C-w>J
"nnoremap <C-S-k> <C-w>K
"nnoremap <C-S-l> <C-w>L

" Simplify movement around soft-wrapped lines    {{{3
" nnoremap ¶ gj
" nnoremap § gk
" nnoremap <M-h> h
" nnoremap <A-l> l

" Simplify movement around tabs                  {{{3
nnoremap <leader>n :tabprevious<CR>
inoremap <leader>n <esc>:tabprevious<CR>
nnoremap <leader>m :tabnext<CR>
inoremap <leader>m <esc>:tabnext<CR>

" Opening files in the same path as current file {{{2
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Saving with ctrl-s - UNFINISHED                {{{2
"noremap <C-S> :update<CR>
"vnoremap <C-S> <C-C>:update<CR>
"inoremap <C-S> <C-O>:update<CR>
" vim: nowrap fdm=marker

" Goyo Toggle                                    {{{2
nnoremap <leader>g :Goyo<CR>


" Pluggins                                       {{{1
" Install vim-plug automatically                 {{{2

" This is dangerous... trust is an illusion

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent execute '!curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Download plugins                               {{{2
call plug#begin('~/.local/share/nvim/site/plugged')
" defaults
"Plug 'tpop/vim-sensible' " testing, probably not needed with nvim
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align' " replaced tabular

" stuff to learn to use
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'

" status lines
" Plug 'hoob3rt/lualine.nvim' "requires a few
" Plug 'kyazdani31/nvim-web-devions' "lualine requirement
" Plug 'glepnir/galaxyline.nvim'
" Plug 'itchyny/lightline.vim'

" autocorrection
Plug 'tpope/vim-abolish'
Plug 'jdelkins/vim-correction' " it's pretty slow to start

" prose
Plug 'junegunn/goyo.vim'
" Plug 'Pocco81/TrueZen.nvim' " i don't have lua installed!

" formats
Plug 'vim-scripts/fountain.vim'
Plug 'nelstrom/vim-markdown-folding'
"Plug 'harenome/vim-mipssyntax'
"
" other
"Plug 'sjl/gundo.vim'     " unmaintained
call plug#end()

" Changes for individual plugins                 {{{2

" Easy-Align / Tabular mappings                  {{{3

" Start interactive EasyAlign in visual mode (e.g. vipga) 
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip) 
nmap ga <Plug>(EasyAlign)


" vim-correct                                    {{{3
let g:correction_filetypes = [
  \ 'text', 'markdown', 'gitcommit', 'plaintext', 'tex',
  \ 'latex', 'rst', 'asciidoc', 'textile', 'pandoc', 'md' ]

"
" Status bar                                     {{{3
" lua << EOF
" require('lualine').setup()
" EOF

" Gundo mappings                                 {{{3
" nnoremap <leader>u :GundoToggle<CR>

