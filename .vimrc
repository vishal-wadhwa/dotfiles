" --------- GENERAL -------------
" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" 256 color terminal
set t_Co=256

" Disable the default Vim startup message.
set shortmess+=I

" Set leader to space as easily accessible from both hands
let mapleader=" "

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
" -------------------------------

" --------- THEME (keep above others)
colorscheme delek
set background=dark
" -----------------------------------

" ---------- VIEW/SYNTAX --------
" Turn on syntax highlighting.
syntax on

" Enable filetype detection its plugins and indentation
filetype plugin indent on

" Show matching brackets when text indicator is over them
set showmatch 

" Use spaces instead of tabs
" set expandtab

" Be smart when using tabs ;)
set smarttab

" https://vim.fandom.com/wiki/Indent_with_tabs,_align_with_spaces
set cindent
set cinoptions=(0,u0,U0

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=0 " for tabs
" set tabstop=4 " to be used with expandtab - read tabstop docs

" Use indent from current line
set autoindent

" Auto insert indent after { and such cases
set smartindent

" no wrapping
set nowrap

" vertical lines
set colorcolumn=80,100,120
highlight ColorColumn ctermbg=0 guibg=lightgrey

" code folding
" set foldmethod=syntax
set foldmethod=manual
" --------------------------------

" -------- STATUS LINE -----------
" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" show row, col in status line
set ruler

" status bar colors
au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
" --------------------------------


" ---------- LINES ---------------
" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber
" Line number
set number relativenumber
" set numberwidth=3
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END
" -----------------------------------

" ---------- BUFFERS/FILES ----------
" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" Set to auto read when a file is changed from the outside and warn to reload
set autoread
au FocusGained,BufEnter * checktime

" :W sudo saves the file 
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>
" -----------------------------------

" ------------ TABS -----------------
" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()
" -----------------------------------

" --------- WINDOWS -----------------
" smart way to move between windows - disabling due to confict with tmux
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" -----------------------------------

" --------- SEARCH ------------------
" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" For regular expressions turn magic on
set magic " on by default
" -----------------------------------

" --------- CLIPBOARD ---------------
" copy buffer file path
nmap <leader>cp :let @+ = expand("%")<CR>

" sync clipboards
set clipboard+=unnamed

" paste with correct indent - https://coderwall.com/p/if9mda/automatically-set-paste-mode-in-vim-when-pasting-in-insert-mode
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" -----------------------------------

" --------- COMPLETIONS ------------
" == WILDMENU (vim : completions) ==
" Turn on the Wild menu
set wildmenu

" ignore case while completing
set wildignorecase

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Fill first match and then cycle with <Tab> and <S-Tab>
set wildmode=longest:full,full
" ----------------------------------

" - SPELL CHECK (needs config improvement) ------------
setl spell spelllang=en_us

" change spell check highlight to underline
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=Red
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=Blue
hi clear SpellRare
hi SpellRare cterm=underline ctermfg=Magenta

setl nospell " disabling for now
" ----------------------------------------------------

" -------------- MACROS -----------
" Don't redraw while executing macros (good performance config)
set lazyredraw
" ----------------------------------

" ----------- MOVEMENT --------------
" keep gap of n lines while scrolling
set scrolloff=3
set sidescrolloff=3

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a
" -----------------------------------
" --------- EXTRAS ------------------
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.
nmap <C-a> <Nop> " avoid conflict with tmux prefix
" ----------------------------------

" ----- PLUGIN MANAGER --------------
" VimPlug install (place it before plugin#begin())
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ------------------------------------


" ---------- PLUGIN CONFIG ---------
call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdtree'

" == NERDTREE ==
" NerdTree auto-open on start
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" NerdTree auto-close if last
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NerdTree leftside
let g:NERDTreeWinPos = "left"
" let g:NERDTreeIgnore = ['.*vendor/.*']

" Exclude .git et al. from rendering
let g:NERDTreeRespectWildIgnore = 1

" NerdTree git
" Plug 'Xuyuanp/nerdtree-git-plugin'

nnoremap <leader>tt :NERDTreeToggle <CR>
nnoremap <leader>tf :NERDTreeFind <CR>

" == VimSurround ==
Plug 'tpope/vim-surround'

" == Repeat dot operator for plugins ==
Plug 'tpope/vim-repeat'

" == Bracket completion ==
Plug 'jiangmiao/auto-pairs'
" fix for https://github.com/jiangmiao/auto-pairs/issues/217
" inoremap <expr> <CR> strcharpart(getline('.'),getpos('.')[2]-1,1) == '}' ? "\<CR>\<Esc>O" : "<CR>"
 
" dont jump to next closing brace when inserting a closing brace 
" https://github.com/jiangmiao/auto-pairs/issues/242
let g:AutoPairsWildClosedPair = ''
 
" == Code commenting ==
Plug 'tpope/vim-commentary'

" == FZF == (giving this a try over ctrlp)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = '~/.local/share/fzf-history'
map <C-p> :FZF <CR>

" == BufExplorer ==
" Plug 'jlanzarotta/bufexplorer'
Plug 'fholgado/minibufexpl.vim'

" == YCM ==
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer' }
let g:ycm_filetype_blacklist = { 'go': 1, 'git': 1,  'notes': 1, 
\   'markdown': 1, 'unite': 1, 'tagbar': 1, 'pandoc': 1, 'qf': 1,
\   'vimwiki': 1, 'text': 1, 'infolog': 1, 'mail': 1, 'gitcommit': 1 }

" == Vim Go ==
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } 
let g:go_highlight_structs = 1 
let g:go_highlight_methods = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
" show type info for word under cursor
let g:go_auto_type_info = 1
" goimports on save
let g:go_fmt_command = 'goimports'
" jump to existing buffer
let g:go_def_reuse_buffer = 1
" run meta lint on save - needs setup
let g:go_metalinter_autosave = 0
" rename command
let g:go_rename_command = 'gopls'

" == TOML support ==
Plug 'cespare/vim-toml'

" == smart tabs ==
" messes with newline between brackets from auto-pairs
" Plug 'vim-scripts/Smart-Tabs'

" == some sensible defaults ==
Plug 'tpope/vim-sensible'

" == some handy key bindings ==
Plug 'tpope/vim-unimpaired'

" == protobuf syntax ==
Plug 'uarun/vim-protobuf'

" == CTRL P ==
" CtrlP file search
let g:ctrlp_lazy_update = 0
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|DS_Store|vendor)|(\.(swp|ico|git|svn))$'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_show_hidden = 1

call plug#end()
" -----------------------------------
