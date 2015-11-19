" Windows only commands
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
  set runtimepath=~/vimfiles/,$VIMRUNTIME

  " keep the backups in a manageable place
  set backupdir=~/backup,$TMP
  set directory=~/swap,$TMP

  " Define where to store undo files and enable persistent undo
  set undodir=~/undo,$TMP
  set undofile

  " set my font preference
  set guifont=Sheldon_Narrow:h9:cANSI
  "set guifont=Envy_Code_R:h8:cANSI

  " force vim files to be unix format
  autocmd FileType vim,python set fileformat=unix
elseif has('win32unix')
  " avoid having the menu and toolbar elements in the gui, and add an icon
  set guioptions=eirL

  " For cygwin use the same directories as windows
  set runtimepath=~/vimfiles/,$VIMRUNTIME
  set backupdir=~/backup,$TMP
  set directory=~/swap,$TMP

  " set my gtk-vim compatible font preference (Sheldon renders badly for some 
  " reason in GTK)
  "set guifont=Envy\ Code\ R\ 8
  set guifont=ProFontWindows\ 9
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
  set guifont=Envy_Code_R:h8:cANSI
endif

" Force the default the CWD to be $HOME
cd $HOME

set nocompatible
set title

" prevent the annoying warning bell
set noerrorbells
set visualbell

" I very rarely use octal numbers, but do use hex
set nrformats=alpha,hex

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

" Ada syntax options
let g:ada_default_compiler = 'gnat'
let g:ada_extended_tagging = 'jump'
"let g:ada_folding = 'gibpx'
"let g:ada_folding = 'spftc'
let g:ada_folding = 'i'
"let g:ada_rainbow_color = 1
"let g:ada_space_errors = 1
let g:ada_standard_types = 1
let g:ada_with_gnat_project_files = 1
let g:ada_extended_completion = 1
"let g:ada_line_errors = 1
let g:ada_omni_with_keywords = 1
let g:ada_begin_preproc = 1
let g:ada_gnat_extensions = 1

" Ada gnat compiler details
"call gnat#New()
"let g:gnat.Make_Program = '"make -C Build"'
"let g:gnat.Error_Format .= ",%f:%l:%c: %m"

" Python syntax options
let g:python_highlight_all = 1

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
set formatoptions=croqwan21
set textwidth=80
set autoindent

syntax on
filetype plugin indent on

" setup spell checking variables for version 7 and up
if v:version >= 700 && has("gui_running")
  set spell spelllang=en_us
endif

set tabstop=4
set softtabstop=4
set expandtab

if v:version >= 704
  set shiftwidth=0
else
  set shiftwidth=4
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

" the < data is new since 603..4, not sure which but I know 604 has it and 602
" doesn't... so I'll just check for 604 to be safe.
if v:version >= 604
  " If this is a cygwin vim, use a different viminfo file since it seems to 
  " clash with the windows-only vim otherwise.
  if has('win32unix')
    set viminfo='1000,f1,<500,n~/.viminfo.cygwin
  else
    set viminfo='1000,f1,<500,n~/.viminfo
  endif
else
  " If this is a cygwin vim, use a different viminfo file since it seems to 
  " clash with the windows-only vim otherwise.
  if has('win32unix')
    set viminfo='1000,f1,n~/.viminfo.cygwin
  else
    set viminfo='1000,f1,n~/.viminfo
  endif
endif

" setup the listchars options, nbsp was added in version 7
if v:version >= 700
  set listchars=eol:$,tab:>-,trail:-,extends:<,precedes:>,nbsp:%
else
  set listchars=eol:$,tab:>-,trail:-,extends:<,precedes:>
endif

" setup folding values, this will enable us to fold code segments
set foldmethod=syntax
set foldcolumn=0
"set foldlevel=0
set foldlevel=99

" setup the scrolloff option so that I can see a few lines below the cursor
set scrolloff=1

" setup tab options
if v:version >= 700
  "allow a lot of tabs
  set tabpagemax=25
endif

" set the correct gui colorscheme
colorscheme vividchalk
"colorscheme vividchalk

" if this is vim7, turn on the cursorline highlighting but only in modifiable 
" buffers
if v:version >= 700
  set cursorline
  " au InsertLeave * set nocursorline
  " au InsertEnter * set cursorline
  "au BufWinEnter * if &modifiable == 1 | setlocal cursorline | else 
    "| setlocal nocursorline
endif

" set the proper window size 
if has("gui_running")
  "set the window to 85 columns wide to accommodate the line numbers which are
  "turned on by default
  "set lines=55 columns=85
  "set lines=50 columns=85

  "Make the screen wider than usual
  set lines=55 columns=100
end

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

" set the tag search path
" set tags=

" Set the diffoptions
"set diffopt=filler,icase,iwhite,vertical
set diffopt=filler,vertical

" Force the keywordprg to be :help on all platforms
set keywordprg=:help


" setup my formating options for C code and comments... these are in addition
" to the defaults done by the ftplugin for c/cpp code
"autocmd FileType c,cpp set textwidth=80 | set cinoptions=>s,e0,n0,f0,{0,}0,^0,:s,=s,l1,gs,b0,hs,ps,t0,is,+s,c3,C3,/0,(0,u0,Us,w0,Ws,M0,j1,)20,*30 | set comments=s1:/*,mb:*,ex:*/
autocmd FileType c,cpp set textwidth=80 | set formatoptions=croqwan1j | set cinoptions=>s,e0,n0,f0,{0,}0,^0,L0,:0,=s,l1,b0,g0,hs,ps,t0,is,+s,c3,C3,/0,(0,u0,U0,w1,Ws,m0,M0,j1,J1,)20,*70,#0 | set comments=lbO://,s1:/*,mb:*,ex:*/ | let &formatlistpat="^[ \\t*/]*\\d\\+[\\]:.)}\\t ]\\s*"


" force Ada files to use my correct formatoptions
if v:version >= 704
  autocmd FileType ada set textwidth=80 | set formatoptions=croqwan1j | setlocal tabstop=2 | setlocal softtabstop=2
else
  autocmd FileType ada set textwidth=80 | set formatoptions=croqwan1j | setlocal tabstop=2 | setlocal softtabstop=2 | setlocal shiftwidth=2
endif

" After a Diff has occurred, resize the window
"autocmd FilterWritePost * if &diff != 0 | call BufViewer#Close("quit") | let &columns = 173 | let &winwidth = 86 | endif
autocmd FilterWritePost * if &diff != 0 | call BufViewer#Close("quit") | let &columns = 173 | let &winwidth = 86 | let &equalalways = 1 | endif

" Add the .tst filetype
"autocmd BufRead *.tst set filetype=tst

" Force the options for tex/latex files to be a bit different than default.
" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
"set sw=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
"set iskeyword+=:
autocmd FileType tex set iskeyword+=: | set formatoptions+=c

" Add Scons files as python
autocmd BufRead,BufNewFile SConstruct set filetype=python
autocmd BufRead,BufNewFile SConscript* set filetype=python

" ---
" Mappings
" ---

" setup F1 to just turn on line numbering
nmap <silent> <F1> :if &number == 0 <bar> let &columns = &columns + 4 <bar> set number <bar> else <bar> let &columns = &columns - 4 <bar> set nonumber <bar> endif<CR>

" setup F2 to show invisible characters (such as tabs and return characters)
nmap <silent> <F2> :set invlist<CR>

" setup F3 to toggle search highlighting
nmap <silent> <F3> :set invhlsearch<CR>

" setup F4 to insert line numbers into the file
nnoremap <silent> <F4> :%s/^/\=strpart(line('.')."     ",0,5)/<CR>
vnoremap <silent> <F4> :s/^/\=strpart((line('.')-line("'<")+1)."     ",0,5)/<CR>

" setup the next key to remove line numbers
" nnoremap <silent> <F5> :%s/^[0-9 ]\{5}//<CR>

" setup F11 to enable text formatting options
nmap <silent> <F11> :if !exists("g:nonTextOptions") <bar> let g:nonTextOptions = [ &autoindent, &textwidth, &formatoptions, &filetype ] <bar> set autoindent <bar> set textwidth=80 <bar> set formatoptions=twn21j <bar> set filetype= <bar> endif<CR>

" setup F12 to reenable the non-text formatting options.
nmap <silent> <F12> :if exists("g:nonTextOptions") <bar> let [ &autoindent, &textwidth, &formatoptions, &filetype ] = g:nonTextOptions <bar> unlet g:nonTextOptions <bar> endif<CR>

" last-position-jump (if TagsParser isn't on)
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Modify the mouse buttons so that selection with left mouse button yanks to
" the clipboard and middle click pastes from the clipboard, also setup the
" double, triple clicks to copy also.  I use Shift-Mouse here because there
" are issues with some of the plugins I'm using if the mouse events are not
" modified.  These had to be modified for vim 7 because of the addition of the 
" <LeftDrag> event.
if v:version >= 700
  noremap <S-LeftMouse> <LeftMouse>
  noremap <S-LeftDrag> <LeftDrag>
  noremap <S-LeftRelease> <LeftRelease>"+ygV
else
  noremap <S-LeftMouse> <LeftMouse>
  noremap <S-LeftRelease> <LeftRelease>"+y
endif
noremap <S-MiddleMouse> <LeftMouse>"+gp

" for some reason when mapping the double and triple clicks to copy, I need
" to insert the <LeftMouse> before the <X-LeftMouse> to get them to work
noremap <S-2-LeftMouse> <LeftMouse><2-LeftMouse>"+y
noremap <S-3-LeftMouse> <LeftMouse><3-LeftMouse>"+y

" since I have a mouse with more buttons, map the X1 and X2 mouse buttons
" to go forward and back in the cursor jump list position
"noremap <X1Mouse> <C-O>
"noremap <X2Mouse> <C-I>

" setup keys that will format the current code block and file
nmap <F5> =i{
nmap <F6> gg=G

" setup some keys to make it easier to go to the next and previous errors
noremap ,o :copen<CR>
noremap ,w :cwindow<CR>
noremap ,c :cclose<CR>
noremap ,n :cnext <bar> if foldclosed('.') != -1 <bar> foldopen! <bar> endif<CR>
noremap ,p :cprevious <bar> if foldclosed('.') != -1 <bar> foldopen! <bar> endif<CR>

" Some commands to reduce the number of keystrokes required to move between
" windows
nnoremap <C-j>      <C-W><C-J>
nnoremap <C-k>      <C-W><C-K>
nnoremap <C-h>      <C-W><C-H>
nnoremap <C-l>      <C-W><C-L>

" Remap the C-W keys to make more intuitive window swapping
"TBD

" Some commands to make it more intuitive to resize windows
nnoremap <C-down>   <C-W>-
nnoremap <C-up>     <C-W>+
nnoremap <C-left>   <C-W><
nnoremap <C-right>  <C-W>>

" Create some maps for the commands to open up the filename under the cursor in 
" a new window, and in a new tab.
"nnoremap <C-f> <C-W><C-F>
"nnoremap <C-g> <C-W>gf

" - Functionality now added to TagsParser plugin
" Map C-] to :tjump so that when multiple selections are available 
"nmap <silent> <C-]> :exec "tjump " . expand("<cword>")<cr>
"vmap <silent> <C-]> "0y:exec "tjump " . getreg("0")<cr>

" Create a keymap so that the \s and \S commands will do a search-and-replace, 
" using the current word in normal mode and the current selection in visual 
" mode.
nnoremap <leader>s :exec "%s/\\<" . expand("<cword>") . "\\>/" . input(">") .
      \ "/gc"<cr>
nnoremap <leader>S :exec "%s/\\<" . expand("<cword>") . "\\>/" . input(">") .
      \ "/g"<cr>
vnoremap <leader>s "0y:exec "%s/\\<" . getreg("0") . "\\>/" . input(">") .
      \ "/gc"<cr>
vnoremap <leader>S "0y:exec "%s/\\<" . getreg("0") . "\\>/" . input(">") .
      \ "/gc"<cr>

" Convert to hex
"nmap <leader>x b"0dwa<C-R>=printf("0x%08x", eval(getreg("0")))<CR><ESC>
nnoremap ,x :s/\(-\?\d*\%#-\?\d*\)/\=printf("0x%08x", eval(submatch(1)))/<CR>$

" Convert to decimal
"nmap <leader>d b"0dwa<C-R>=printf("%d", eval(getreg("0")))<CR><ESC>
nnoremap ,d :s/\([0-9a-fA-FxX]*\%#[0-9a-fA-FxX]*\)/\=printf("%d", eval(submatch(1)))/<CR>$

" Convert string to hex sequence
vnoremap ,a "0c<C-R>=Str2Hex(getreg("0"))<CR><ESC>

" Eval and append result
vnoremap ,e "0y$a<C-R>=Eval(getreg("0"))<CR><ESC>

" custom searching commands:
nmap <C-f> :vimgrep /<C-R><C-w>/ *<CR>
vmap <C-f> "0y:vimgrep /<C-R>0/ *<CR>


" - ~/vimfiles/plugins/SessionSaver.vim
let g:loaded_sessionsaver = 1
"let g:SessionSaverAutoSave = 0
"let g:SessionSaverSessionFileBackup = 0
"let g:SessionSaverSessionFile = '~/.sessions/vimsession.vim'
"let g:SessionSaverSaveSessionCmds =
"      \ 'call TagsParser#MkSessionPrep() | call BufViewer#MkSessionPrep()'

" - ~/vimfiles/plugins/NERD_tree.vim
"let g:loaded_nerd_tree=1
"let g:NERDTreeMouseMode = 3
"let g:NERDTreeShowHidden = 1

" - $VIMRUNTIME/vimfiles/plugins/netrw.vim
let g:netrw_liststyle = 3
let g:netrw_winsize = 30
let g:netrw_browse_split = 4

" For some reason netrw has trouble with these settings in windows
if has("win32") || has("win64")
  let g:netrw_localcopycmd = 'C:/Windows/System32/cmd.exe /c copy'
  let g:netrw_localmovecmd = 'C:/Windows/System32/cmd.exe /c move'
endif

" vim 'submodules'
runtime bundle/vim-pathogen/autoload/pathogen.vim
exec pathogen#infect()

" gutentags
set statusline+=%{gutentags#statusline('[Generating...]')}

" Ctags executable (path to cygwin DLL is required to use cygwin ctags)
let $PATH = 'C:\cygwin\bin;' . $PATH
let g:gutentags_ctags_executable = 'ctags.exe'
let g:gutentags_cache_dir = '~/.project_tags'

" syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
