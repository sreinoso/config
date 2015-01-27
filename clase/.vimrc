"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"###########  Plugins ###########
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" #### Ejemplos ####

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site

" #### Introducir Plugins aquí ####
Plugin 'Buffergator'
Plugin 'JavaRun'
Plugin 'JavaScript-Indent'
Plugin 'JavaScript-syntax'
Plugin 'Javascript-OmniCompletion-with-YUI-and-j'
Plugin 'PHP-correct-Indenting'
Plugin 'PHPcollection'
Plugin 'html_FileCompletion'
Plugin 'java_fold'
Plugin 'javacomplete'
Plugin 'javaimports.vim'
Plugin 'php.vim'
Plugin 'phpcomplete.vim'
Plugin 'phpfolding.vim'
Plugin 'open-terminal-filemanager'
Plugin 'basic-colors'
Plugin 'ColorX'
Plugin '285colors-with-az-menu'
Plugin 'Simple-R-Omni-Completion'
Plugin 'Syntastic'
Plugin 'pathogen.vim'
Plugin 'eclm_wombat.vim'
"Plugin 'SnippetComplete'
Plugin 'AutoComplPop'
Plugin 'The-NERD-tree'
"Plugin 'snippets.vim'
Plugin 'snipMate'
Plugin 'git://github.com/moiatgit/vim-rst-sections.git'
Plugin 'clevercss.vim'
Plugin 'HTML5-Syntax-File'
Plugin 'https://github.com/sorin-ionescu/vim-htmlvalidator.git'
" ctags modificado para clase, ya que ctags de clase no era valido
"   Modificando 'tagbar_ctags_bin' del fichero ~/.vim/bundle/Tagbar/autoload/tagbar.vim 
Plugin 'ctags.vim'
Plugin 'Tagbar'
Plugin 'taglist.vim'
Plugin 'bling/vim-airline'
Plugin 'TTCoach'
Plugin 'plantuml-syntax'
Plugin 'Lokaltog/powerline'


call vundle#end()
" ##### Fin de plugins #####

" #### Configuraciones ####
" " Now we can turn our filetype functionality back on
filetype plugin indent on " filetype detection on

" Highlight de códigos
syntax on

" Colores
"color simple256
set t_Co=256
color calmar256-dark

" Codificación
set encoding=utf-8

" Indentaciónes y sangrados
set autoindent      " code autoindent
set smartindent     " advanced indent
set backspace=indent,eol,start
set tabstop=4       " tab with
set shiftwidth=4    " tabs
set softtabstop=4   " tabs
set expandtab       " don't use real tabs
" Add and delete spaces in increments of `shiftwidth' for tabs
set smarttab

" Uso de mouse
set mouse=a

set filetype        " filetype detection on
set autochdir       " always switch to the current file directory
set number          " line numbers
set hlsearch        " highlight search
set incsearch       " show search matches while typing
set showmatch       " show matching elements
set ignorecase      " case unsensitive search
set smartcase       " if there are caps go case-sensitive
set history=2000    " history length
set showcmd         " show mode
set showmode
set ruler
"set listchars=tab:▸\ ,eol:¬
"set statusline=%F%m%h%w\ [%p%%]
set clipboard=unnamed " advanced clipboard
set omnifunc=syntaxcomplete#Complete     " autocomplete function
set completeopt=menu,preview " autocomplete function
set wildmenu        " command-line completion
set scrolloff=3     " lines before EOF
"
"
" backups
"
" map
" up/down keys move one line not paragraph
map <Up> gk
map <Down> gj
map <tab> gt
map <S-tab> gT
"
" reload when source changes
checktime
"set autoread
let mapleader='º'
"
" Some filetype distinctions
"autocmd Filetype rst set textwidth=70
"autocmd Filetype rst set formatoptions-=q   " to avoid considering * as comments
"autocmd Filetype rst behave mswin           " allow ctrl-shif selection
"autocmd Filetype rst set spell              " spell check on
"autocmd Filetype rst set spelllang=ca       " spell language catalan
" considera comentaris nomÃ©s per la primera lÃ­nia.
"
"autocmd Filetype rst set comments=fb:-,fb:*,fb://
"if has("autocmd")
"    autocmd FileType python set complete+=k/home/shakir/.vim/pydiction-0.5/pydiction isk+=.,(
"endif  
"has("autocmd

" share clipboard vim from-to X Window 
" following http://www.reddit.com/r/vim/comments/m9tcz/ask_rvim_anyone_successfully_mapped_yankpaste/
"if has('unnamedplus') 
"    set clipboard=unnamedplus,autoselect " Use + register (X Window clipboard) as unnamed register
"endif
" Elimina la toolbar
"set guioptions-=T
"
" Afegeix un $ al final del text afectat per una comanda (c)hange
set cpoptions+=$

""MAPEAR TAB PARA AUTOINDENT
function! Smart_TabComplete()
    let line = getline('.')                         " current line

    let substr = strpart(line, -1, col('.')+1)      " from the start of the current
    " line to one character right
    " of the cursor
    let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return "\<tab>"
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    if (!has_period && !has_slash)
        return "\<C-X>\<C-P>"                         " existing text matching
    elseif ( has_slash )
        return "\<C-X>\<C-F>"                         " file matching
    else
        return "\<C-X>\<C-O>"                         " plugin matching
    endif
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>





" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
"autocmd FileType make set noexpandtab


" Enable pathogen
call pathogen#infect()
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()


""" Functions

function! ConditionalPairMap(open, close)
    let line = getline('.')
    let col = col('.')
    if col < col('$') || stridx(line, a:close, col + 1) != -1
        return a:open
    else
        return a:open . a:close . repeat("\<left>", len(a:close))
    endif
endf
""" End Functions

syntax enable
if !has('gui_running')
    " Compatibility for Terminal
    let g:solarized_termtrans=1

    if (&t_Co >= 256 || $TERM == 'xterm-256color')
        " Do nothing, it handles itself.
    else
        " Make Solarized use 16 colors for Terminal support
        let g:solarized_termcolors=16
    endif
endif
""" Colorschemes
"colorscheme solarized
hi Normal ctermbg=NONE
"set background=dark
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Folds
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

set foldmethod=indent
set foldlevel=99

" SuperTab plugin

au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"

set completeopt=menuone,longest,preview




" Useful macros for cleaning up code to conform to LLVM coding guidelines
" Delete trailing whitespace and tabs at the end of each line
command! DeleteTrailingWs :%s/\s\+$//

" Convert all tab characters to two spaces
command! Untab :%s/\t/  /g



map <c-n> o <esc>
" NERDTree
map <F2> :NERDTreeToggle<CR>
"Enable Ctrl+P to paste
map <C-Y> :set paste<CR> "@set paste
" Moving around windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <leader>vimrc :tabe ~/.vimrc<cr>
map <leader>bashrc :tabe ~/.bashrc<cr>
nmap <F12> :TagbarToggle<CR>
:map <M-Esc>[62~ <MouseDown> 
:map! <M-Esc>[62~ <MouseDown> 
:map <M-Esc>[63~ <MouseUp> 
:map! <M-Esc>[63~ <MouseUp> 
:map <M-Esc>[64~ <S-MouseDown> 
:map! <M-Esc>[64~ <S-MouseDown> 
:map <M-Esc>[65~ <S-MouseUp> 
:map! <M-Esc>[65~ <S-MouseUp>
" Moving around windows
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" Let's remember some things, like where the .vim folder is.
"if has("win32") || has("win64")
"    let windows=1
"    let vimfiles=$HOME . "/vimfiles"
"    let sep=";"
"else
"    let windows=0
"    let vimfiles=$HOME . "/.vim"
"    let sep=":"
"endif


"if has("gui_running")
set cursorline                  "Highlight background of current line
"autocmd VimEnter * NERDTree     "run nerdtree
"autocmd VimEnter * TagbarOpen

" Show tabs and newline characters with ,s
nmap <Leader>s :set list!<CR>
set listchars=tab:▸\ ,eol:¶
"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
"endif

"if has("gui_macvim") "Use Experimental Renderer option must be enabled for transparencY
"let s:uname = system("uname")
"if s:uname == "Darwin\n"
"    set guifont=Menlo\ for\ Powerline:h14
"endif
"map <SwipeLeft> :bprev<CR>
"map <SwipeRight> :bnext<CR>
"endif

if filereadable($HOME.'/.vimrc_local')
    source $HOME/.vimrc_local
endif

" For statusline
set t_Co=256
autocmd bufwritepost .vimrc source $MYVIMRC

" Go tags

let g:tagbar_type_go = {
            \ 'ctagstype' : 'go',
            \ 'kinds'     : [
            \ 'p:package',
            \ 'i:imports:1',
            \ 'c:constants',
            \ 'v:variables',
            \ 't:types',
            \ 'n:interfaces',
            \ 'w:fields',
            \ 'e:embedded',
            \ 'm:methods',
            \ 'r:constructor',
            \ 'f:functions'
            \ ],
            \ 'sro' : '.',
            \ 'kind2scope' : {
            \ 't' : 'ctype',
            \ 'n' : 'ntype'
            \ },
            \ 'scope2kind' : {
            \ 'ctype' : 't',
            \ 'ntype' : 'n'
            \ },
            \ 'ctagsbin'  : 'gotags',
            \ 'ctagsargs' : '-sort -silent'
            \ }
"set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
map <F8> :noh <CR>
map <C-l> :!clear <CR>
au FileType rst call SetRSTOptions()
au FileType java call SetJavaOptions()
au FileType html call SetHtmlOptions()

function! SetRSTOptions()
    map <F7> :!rst2pdf % <CR>
    map <F4> :!gnome-open %<.pdf <CR>
    Tagbar
endfunction
function! SetJavaOptions()
    map <F7> :!javac % && java %< <CR>
    Tagbar
endfunction
function! SetHtmlOptions()
    map <F4> :!gnome-open % <CR>
endfunction
:nnoremap <F6> "=strftime("%c")<CR>P
:inoremap <F6> <C-R>=strftime("%c")<CR>
au FileType html compiler html
au QuickFixCmdPost make cwindow

" Tagbar para RST
let g:tagbar_type_rst = {
            \ 'ctagstype': 'rst',
            \ 'ctagsbin' : '/home/sergio.reinoso/ctags/usr/share/rst2ctags.py',
            \ 'ctagsargs' : '-f - --sort=yes',
            \ 'kinds' : [
            \ 's:sections',
            \ 'i:images'
            \ ],
            \ 'sro' : '|',
            \ 'kind2scope' : {
            \ 's' : 'section',
            \ },
            \ 'sort': 0,
            \ }
 
" Siempre visible statusline
set laststatus=2

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
"let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
"let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
"let g:airline_symbols.linenr = '␤'
"let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
"let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
"let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
"let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
set ttimeoutlen=50
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '▶'
map <T-c> :wq <CR>
"com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"
map <T-c> :wq <CR>
