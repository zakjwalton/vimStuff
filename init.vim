let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python2_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
" windows only commands
if has('win32') || has('win64')
  " If the shell is set to "/bin/bash" then this is a windows gvim launched from
  " cygwin, correct the shell.
  if &shell =~ 'bash'
    set shell=C:\Windows\system32\cmd.exe
    set shellcmdflag=\\c
    "set shellpipe=>%s 2>&1
    let &shellpipe = ">%s 2>&1"
    "set shellredir=>%s 2>&1
    let &shellredir = ">%s 2>&1"
    set shellxquote=(
    set shellxescape="&|<>()@^"
  endif

  " avoid having the menu and toolbar elements in the gui
  set guioptions=erL

  " For windows systems use the vimfiles directory
  set runtimepath=~/.vim/,$VIMRUNTIME

  " keep the backups in a manageable place
  set backupdir=~/.backup,$TMP
  set directory=~/.swap,$TMP

  " Define where to store undo files and enable persistent undo
  set undodir=~/.undo,$TMP
  set undofile

  " set my font preference
  "set guifont=Sheldon_Narrow:h9:cANSI
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h6.5
  " set guifont=Ubuntu\ Mono\ derivative\ Powerline:10.5
  " set guifont=Inconsolata\ for\ Powerline\ Medium:h10.5
  "set guifont=Envy_Code_R:h8:cANSI
  " set guifont=Hack:h10.5
  set encoding=utf-8

  " force vim files to be unix format
  autocmd FileType vim,python set fileformat=unix
elseif has('win32unix')
  " avoid having the menu and toolbar elements in the gui, and add an icon
  set guioptions=eirL

  " For cygwin use the same directories as windows
  set runtimepath=~/.vim/,$VIMRUNTIME
  set backupdir=~/.backup,$TMP
  set directory=~/.swap,$TMP

  " Define where to store undo files and enable persistent undo
  set undodir=~/.undo,$TMP
  set undofile

  " set my gtk-vim compatible font preference (Sheldon renders badly for some
  " reason in GTK)
  "set guifont=Envy\ Code\ R\ 8
  "set guifont=ProFontWindows\ 9
else
  " For *ix systems use the .vim directory
  set runtimepath=~/.vim/,$VIMRUNTIME

  " keep the backups in a manageable place
  set backupdir=~/.backup,$TMP
  set directory=~/.swap,$TMP

  " Define where to store undo files and enable persistent undo
  set undodir=~/.undo,$TMP
  set undofile

  " set my font preference
  "set guifont=FreeMono\ 10
  "set guifont=DejaVu\ Sans\ Mono\ 9
  "set guifont=Sheldon_Narrow:h9:cANSI
  "set guifont=ProFontWindows\ 9
  "set guifont=ProFont\ 10
  "set guifont=AnonymousPro\ 9
  "set guifont=Envy_Code_R:h8:cANSI
endif

call plug#begin('~/.vim/plugged')
Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-airline/vim-airline'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'morhetz/gruvbox'
Plug 'vim-jp/vim-cpp'
Plug 'godlygeek/tabular'
Plug 'hynek/vim-python-pep8-indent'
Plug 'ntpeters/vim-better-whitespace'
Plug 'Shougo/unite.vim'
Plug 'Shougo/neoyank.vim'
Plug 'peterhoeg/vim-qml'
Plug 'tjdevries/edit_alternate.vim'
Plug 'equalsraf/neovim-gui-shim'
Plug 'plasticboy/vim-markdown'
if has('nvim')
    Plug 'shougo/deoplete.nvim'
    Plug 'zchee/deoplete-jedi'
    Plug 'neomake/neomake'
    Plug 'tweekmonster/impsort.vim'
    Plug 'floobits/floobits-neovim'
    Plug 'mhinz/neovim-remote'
endif
call plug#end()

if has('nvim')
    " Use deoplete.
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources#jedi#show_docstring = 0
    tnoremap <Esc> <C-\><C-n>

    " Neomake stuff for python
    " Automatically open the error window
    let g:neomake_open_list = 1

    " Python
    let g:neomake_python_flake8_maker = {
            \ 'args': ['--max-line-length=140', '--ignore=E402']
            \ }
    let g:neomake_c_enabled_makers = []
    let g:neomake_cpp_enabled_makers = []

    " TODO: Get prospector to work, maybe just on a special command.
    " let g:neomake_python_prospector_maker = {
    "     \ 'exe': 'prospector',
    "     \ 'args': ['%:p'],
    "     \ }
    " let g:neomake_python_enabled_makers = [ 'flake8', 'prospector' ]

    let g:neomake_python_enabled_makers = [ 'flake8' ]
    augroup vimrc_neomake
        autocmd!
        autocmd BufWritePost * silent Neomake
        autocmd VimLeave * let g:neomake_verbose = 0
    augroup END
    set completeopt-=preview

    " Make esc leave terminal mode
    tnoremap <Esc> <C-\><C-n>
    tnoremap kj <C-\><C-n>
endif

" Settings for better whitespace
autocmd BufWritePre * StripWhitespace

if has("gui_running")
endif

" Set relative line numbers
set relativenumber

" Speed up scrolling through files
set lazyredraw

" Force the default the CWD to be $HOME
" cd $HOME
autocmd BufEnter * silent! lcd %:p:h

set title

" prevent the annoying warning bell
set noerrorbells
set novb

" Break indent settings
set tw=0
set breakindent
let &showbreak=repeat('.', 3)
set linebreak
set wrap

" I very rarely use octal numbers, but do use hex
set nrformats=alpha,hex

" Configure Inccommand
if exists('&inccommand')
  set inccommand=split

  function! TJToggleInccommand() abort
    if &inccommand ==? 'split'
      set inccommand=nosplit
    else
      set inccommand=split
    endif
  endfunction
endif

" Define the set of keyword characters I like
"set iskeyword=@,48-57,_,128-167,224-235

" Use real tabs in HTML files
autocmd FileType html,javascript,css set noexpandtab

" Load the doxygen syntax plugin and set .dox files as doxygen documentation
" files.
let g:load_doxygen_syntax=1
let g:doxygen_enhanced_color=1
let g:doxygen_javadoc_autobrief=0
autocmd BufRead,BufNewFile *.dox set filetype=doxygen

" Set XML syntax folding
let g:xml_syntax_folding=1

" Set WADL files to be XML types.
autocmd BufRead,BufNewFile *.wadl set filetype=xml

" Set MD files to be markdown types.
autocmd BufRead,BufNewFile *.md set filetype=markdown

" C syntax options
let g:c_gnu = 1
let g:c_comment_strings = 1
let g:c_space_errors = 1
" This can make syntax matching for C files slow
"let g:c_curly_error = 1
let g:c_syntax_for_h = 1

" Python syntax options
let g:python_highlight_all = 1
let g:python_comment_text_width = 80

" Set SQLite as the default SQL syntax dialect
let g:sql_type_default = 'sqlite3'

" Set bash/shell script options
let g:is_bash = 1
" Enable function, heredoc, if/do/for folding
let g:sh_fold_enabled = 1 + 2 + 4
let g:sh_noisk = 1

" Set the default format options, text width and auto indent for normal
" buffers.
" (disable autowrap for normal buffers)
" set formatoptions=croqwan21
set formatoptions=tcqj
" set textwidth=80
set autoindent

syntax on
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" setup spell checking variables for version 7 and up
if v:version >= 700 && has("gui_running")
  set spell spelllang=en_us
endif

" setup the options that the behave command does.. but differently than either
" the pure xterm or mswin settings dictate
set selection=exclusive

if has("gui_running")
  set mousemodel=extend
  set selectmode=mouse,key
  set keymodel=startsel,stopsel
else
  set mousemodel=extend
  set selectmode=key
  set keymodel=startsel,stopsel
endif

" enable Vim to backspace over anything
set backspace=indent,eol,start

" always show the mode
set showmode

" setup my searching options
set showmatch
set ignorecase
set smartcase
set incsearch

" I like to see where I am in a file
set ruler

" Ensure that visual selection shows how many lines are selected
set showcmd

" keep backups and a viminfo file
set backup

" Configure the command line completion mode to give a list of matches instead
" of just the first full match.
set wildmode=longest,list

" setup the listchars options, nbsp was added in version 7
if v:version >= 700
  set listchars=eol:$,tab:>-,trail:-,extends:<,precedes:>,nbsp:%
else
  set listchars=eol:$,tab:>-,trail:-,extends:<,precedes:>
endif

" setup the scrolloff option so that I can see a few lines below the cursor
set scrolloff=10

" setup tab options
if v:version >= 700
  "allow a lot of tabs
  set tabpagemax=25
endif

" set the correct gui colorscheme
colorscheme gruvbox
let g:gruvbox_termcolors = 256
let g:gruvbox_italic = 1
set background=dark
set cursorline

if has("gui_running")
  "set the window to 85 columns wide to accommodate the line numbers which are
  "turned on by default
  "set lines=55 columns=85
  "set lines=50 columns=85

  "Make the screen wider than usual
  set lines=55 columns=100
end

" show line numbers
set numberwidth=5
set number

" setup session and view options to be able to store a project editing session
set sessionoptions=buffers,curdir,folds,globals,help,resize,slash,tabpages,unix,winpos,winsize

" make vim automatically reload a file which has changed and the buffer is
" still loaded
set autoread

" allow buffers to be modified and hidden at the same time
" !!! with this option enabled it is absolutely necessary to be very
" !!! careful with :q! and :qa!
set hidden

" setup the search path to help with simple VIM tasks like finding include
" files or macro defs
set path=.

" Set the diffoptions
"set diffopt=filler,icase,iwhite,vertical
set diffopt=filler,vertical

" Force the keywordprg to be :help on all platforms
set keywordprg=:help

" Not really sure what this is doing
autocmd FilterWritePost * if &diff != 0 | call BufViewer#Close("quit") | let &columns = 173 | let &winwidth = 86 | let &equalalways = 1 | endif

" Flake 8 stuff
let g:flake8_cmd = 'C:\Python35\Scripts\flake8.exe'

" netrw settings
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_browse_split = 4
" For some reason netrw has trouble with these settings in windows
if has("win32") || has("win64")
  let g:netrw_localcopycmd = 'C:/Windows/System32/cmd.exe /c copy'
  let g:netrw_localmovecmd = 'C:/Windows/System32/cmd.exe /c move'
endif

" GutenTags settings
set statusline+=%{gutentags#statusline('[Generating...]')}
" Ctags executable (path to cygwin DLL is required to use cygwin ctags)
let g:gutentags_ctags_executable = '/usr/bin/ctags'
let g:gutentags_cache_dir = '~/.project_tags'

" vim-ariline settings
set laststatus=2
let g:airline_powerline_fonts = 1

" vim-markdown settings
let g:vim_markdown_folding_disabled = 1

" -----------------------------------------------------------------------------------------------------
" Mappings
" -----------------------------------------------------------------------------------------------------
" map leader to ,
let mapleader=","
nmap <leader>t :TagbarToggle<CR>

" last-position-jump (if TagsParser isn't on)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Some commands to reduce the number of keystrokes required to move between
" windows
nnoremap <C-j>      <C-W><C-J>
nnoremap <C-k>      <C-W><C-K>
nnoremap <C-h>      <C-W><C-H>
nnoremap <C-l>      <C-W><C-L>

" Some commands to make it more intuitive to resize windows
nnoremap <C-down>   <C-W>-
nnoremap <C-up>     <C-W>+
nnoremap <C-left>   <C-W><
nnoremap <C-right>  <C-W>>

" Tab navigation like Firefox.
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i

inoremap kj <Esc>

" Alt plus number opens a tab
nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt
nnoremap <A-0> :tablast<CR>

" custom searching commands:
nmap <C-f> :vimgrep /<C-R><C-w>/gj *<CR>
vmap <C-f> "0y:vimgrep /<C-R>0/gj *<CR>

" Unite mappings
let g:unite_source_history_yank_enable = 1
nnoremap <leader>f :Unite -start-insert -no-split file_rec:!<CR>
nnoremap <leader>b :Unite -start-insert -no-split buffer<CR>
nnoremap <leader>y :Unite -start-insert -no-split history/yank<CR>

" Mapping for inccommand
" nnoremap <leader>hl :call TJToggleInccommand()<CR>

" Mapping to toggle search highlighting
nnoremap <leader>th :set invhlsearch<CR>

" Edit alternate mappings
nnoremap <leader>h :EditAlternate<CR>

" -----------------------------------------------------------------------------------------------------
" End Mappings
" -----------------------------------------------------------------------------------------------------


