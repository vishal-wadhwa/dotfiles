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

" Disable the default Vim start-up message.
set shortmess+=I

" Set leader to space as easily accessible from both hands
let mapleader=" "

" The backspace key has slightly unintuitive behaviour by default. For example,
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
" color scheme delek
set background=dark
set termguicolors

" Sometimes setting 'termguicolors' is not enough and one has to set the t_8f and t_8b options explicitly
" :h xterm-true-color
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Italics Support - https://stackoverflow.com/questions/3494435/vimrc-make-comments-italic
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"
" -----------------------------------

" ---------- VIEW/SYNTAX --------
" Turn on syntax highlighting.
syntax on

" Enable filetype detection its plugins and indentation
filetype plugin indent on
au BufNewFile,BufRead *Jenkinsfile* setf groovy

" organize imports in go
au BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Show matching brackets when text indicator is over them
set showmatch

" Use spaces instead of tabs
" set expandtab

" Be smart when using tabs ;)
set smarttab

" https://vim.fandom.com/wiki/Indent_with_tabs,_align_with_spaces
set cindent
set cinoptions=(0,u0,U0

set tabstop=4           " Tab width
set softtabstop=4       " Soft tab width
set shiftwidth=4        " Shift width
set expandtab           " Use spaces instead of tabs

" MOVED TO ftplugin/
" 1 tab == 4 spaces
" set shiftwidth=4
" set tabstop=4
" set softtabstop=0 " for tabs
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
set foldmethod=syntax
" disable auto fold on buffer open
set foldlevelstart=99

" use old regex engine for perf
set re=1

set redrawtime=10000
syntax sync minlines=600
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" set file type without overriding
augroup detect_ft
autocmd BufRead,BufNewFile Dockerfile.*,*.dockerfile setfiletype dockerfile
augroup END


" correct syntax highlight when using jsonc
augroup jsonc_syntac
    autocmd!
    autocmd FileType json syntax match Comment +\/\/.\+$+
augroup END

" fast file open for very large files - more like stupid files with very long
" lines
augroup folding
    autocmd!
    autocmd FileType php set foldmethod=indent
    " autocmd FileType php if getfsize(@%) > 512*1024 | setlocal foldmethod=indent | endif
augroup END
" --------------------------------

" ------ FORMATTING -------------
augroup formatters
    au!
    " autocmd FileType c,cpp,java,proto setlocal equalprg=clang-format\ -style='{BasedOnStyle:\ microsoft,BreakBeforeBraces:\ Attach,AlignTrailingComments:\ true,IndentWidth:\ 4,AllowShortEnumsOnASingleLine:\ false}'
    autocmd FileType c,cpp,java,proto setlocal equalprg=clang-format
    " || true at the end is to avoid NZEC in phpcbf for multiple reasons
    " use phpcs --config-set to set standards
    autocmd FileType php setlocal equalprg=phpcbf\ -d\ memory_limit=512M\ \|\|\ true
    au BufWrite *.py call CocAction('format')
augroup END


" Function to trim whitespace and preserve cursor position and history
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

" wildmenu command
command! TrimWhitespace call TrimWhitespace()

" shortcut
noremap <leader>w :call TrimWhitespace()<cr>

" retain selection on indent/dedent
vnoremap > >gv
vnoremap < <gv

" -------- STATUS LINE -----------
" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" show row, col in status line
set ruler

" status bar colors
augroup status_bar_colors
    au!
    au InsertEnter * hi statusline guifg=black guibg=#d7afff ctermfg=black ctermbg=magenta
    au InsertLeave * hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
augroup END
hi statusline guifg=black guibg=#8fbfdc ctermfg=black ctermbg=cyan
" --------------------------------


" ---------- LINES ---------------
" Show line numbers.
set number

" Show number of lines/bytes/matrix dims in visual modes
set showcmd

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
augroup file_reload
    au!
    au FocusGained,BufEnter * checktime
augroup END

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" Return to last edit position when opening files (You want this!)
augroup cursor_pos
    au!
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

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
        execute("bdelete ".l:currentBufNum)
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
map <leader>t<leader> :tabnext<cr>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
augroup tab_toggle
    au!
    au TabLeave * let g:lasttab = tabpagenr()
augroup END
" -----------------------------------

" --------- WINDOWS -----------------
" smart way to move between windows - disabling due to confict with tmux
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" create new split to the right
set splitright

" create new split down below
set splitbelow
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

" Show search count
set shortmess-=S

" https://vim.fandom.com/wiki/Copy_search_matches
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)

" Complex selected expression search in visual mode
" Extended from here:
" https://github.com/bronson/vim-visual-star-search/blob/7c32edb9e3c85d473d9be4dec721a4c9d5d4d69c/plugin/visual-star-search.vim
function! VisualStarSearch(cmdtype,...)
    let temp = (has('clipboard') ? @+ : @" )
    normal! gvy

    if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
    endif
    let @/ = substitute(@", '\n', '\\n', 'g')
    let @/ = substitute(@/, '\[', '\\[', 'g')
    let @/ = substitute(@/, '\~', '\\~', 'g')
    let @/ = substitute(@/, '\.', '\\.', 'g')
    let @/ = '\<'.@/.'\>'

    if has('clipboard')
      let @+ = temp
    endif
    let @" = temp " Since, unnamed and + are always in sync, so copying to both 
endfunction

" replace vim's built-in visual * and # behavior
" gn and gN restart visual mode
xnoremap * :<C-u>call VisualStarSearch('/')<CR>/<C-R>=@/<CR><CR>gn
xnoremap # :<C-u>call VisualStarSearch('?')<CR>?<C-R>=@/<CR><CR>gN
" -----------------------------------

" --------- CLIPBOARD ---------------
" copy buffer file path
if has('clipboard')
    nmap <leader>cp :let @+ = expand("%")<CR>
else
    nmap <leader>cp :let @" = expand("%")<CR>
endif

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

" INSERT MODE COMPLETIONS - disable for speed
" https://github.com/mhinz/vim-galore#faster-keyword-completion
set complete-=i " disable scanning included files
set complete-=t " disable searching tags

" ----------------------------------

" - SPELL CHECK (needs config improvement) ------------
set spell spelllang=en_gb,cjk
set spelloptions=camel " support camelCase

" change spell check highlight to underline
hi clear SpellBad
hi SpellBad cterm=underline ctermfg=Red
hi clear SpellCap
hi SpellCap cterm=underline ctermfg=Blue
hi clear SpellRare
hi SpellRare cterm=underline ctermfg=Magenta

set nospell " disabling for now - enable when required
" ----------------------------------------------------

" -------------- MACROS -----------
" Don't redraw while executing macros (good performance config)
set lazyredraw
" ----------------------------------

" ----------- MOVEMENT --------------
" keep gap of n lines while scrolling
set scrolloff=1
set sidescrolloff=5

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a
" -----------------------------------
" --------- EXTRAS ------------------
" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" swap files at central place. needs dir to exist. // means full path
silent !mkdir -p ~/.vim/_swap
set directory^=$HOME/.vim/_swap//

" file backups at central place
silent !mkdir -p ~/.vim/_backup
set backup
set backupdir^=$HOME/.vim/_backup//

" fixes weird out of memory issues in large php files
set maxmempattern=5000

" better diff algo
if has("patch-8.1.0360")
    set diffopt+=algorithm:histogram
endif
" ----------------------------------

" ---------- COMMAND LINE / EX MODE -
" history num
set history=1000
" ----------------------------------

" ----- PLUGIN MANAGER --------------
" VimPlug install (place it before plugin#begin())
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" ------------------------------------

" ------------ PATHS -----------------
" Read :h python-virtualenv
" https://github.com/neovim/pynvim/issues/16#issuecomment-152417012
" https://github.com/neovim/neovim/issues/1887#issuecomment-280653872
" Figure out the system Python for Neovim.
function! s:GetBrewPrefix(name)
  let result = system("brew --prefix " . a:name)
  if v:shell_error != 0
    echo "Error: Homebrew package '" . a:name . "' not found."
    return ""
  endif
  return substitute(result, '\n', '', 'g')
endfunction

if has("unix")
  let s:uname = system("uname -s")
  if s:uname == "Darwin\n"
      let g:python3_host_prog=s:GetBrewPrefix("python@3.9").'/bin/python3.9'
  endif
endif
" ------------------------------------


" ---------- PLUGIN CONFIG ---------
call plug#begin('~/.vim/plugged')

" == NERDTREE ==
Plug 'preservim/nerdtree'

" NerdTree auto-open on start
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" If another buffer tries to replace NERDTree, put in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" NerdTree auto-close if last
augroup nerdtree_autoclose
    au!
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

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

" php no close
augroup autopairs
    au!
    au FileType php      let b:AutoPairs = AutoPairsDefine({'<?' : '', '<?php': ''})
augroup END

" dont jump to next closing brace when inserting a closing brace
" https://github.com/jiangmiao/auto-pairs/issues/242
let g:AutoPairsWildClosedPair = ''

" == Code commenting ==
Plug 'tpope/vim-commentary'
augroup vimcommentary
    autocmd!
    autocmd FileType cpp,c,php,json,proto,jsonc setlocal commentstring=//\ %s
    autocmd FileType mysql setlocal commentstring=--\ %s
    autocmd FileType vim setlocal commentstring=\"\ %s
augroup END

" == FZF == (giving this a try over ctrlp)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~40%' }
" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 1, 'border': 'top' } }
" let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.5, 'yoffset': 0, 'border': 'bottom' } }
map <c-p> :GitFiles -c -o --exclude-standard<cr>
map <f2> :FZF<cr>
map <leader>p :Buffers<cr>
map <leader>f :Rg<space>
" Visual mode mappings
command! -bar -bang XMaps call fzf#vim#maps("x", <bang>0)

" Insert mode mappings
command! -bar -bang IMaps call fzf#vim#maps("i", <bang>0)

" Operator-pending mappings: https://learnvimscriptthehardway.stevelosh.com/chapters/15.html
command! -bar -bang OMaps call fzf#vim#maps("o", <bang>0)

" == BufExplorer ==
" Plug 'jlanzarotta/bufexplorer'
" Plug 'fholgado/minibufexpl.vim'
let g:miniBufExplMaxSize = 1
let g:miniBufExplBRSplit = 0

" == YCM (disabling in favour of coc.nvim) ==
" Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --ts-completer' }
let g:ycm_filetype_blacklist = { 'go': 1, 'git': 1,  'notes': 1, 'diff': 1,
            \   'markdown': 1, 'unite': 1, 'tagbar': 1, 'pandoc': 1, 'qf': 1,
            \   'vimwiki': 1, 'text': 1, 'infolog': 1, 'mail': 1, 'gitcommit': 1,
            \	'*': 1}

" == coc.nvim completions ==
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Install extensions scripts: npm install --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
let g:coc_global_extensions = [
            \ 'coc-clangd',
            \ 'coc-diagnostic', 
            \ 'coc-docker', 
            \ 'coc-html', 
            \ 'coc-java', 
            \ 'coc-json', 
            \ 'coc-pyright',
            \ 'coc-yaml', 
            \ 'coc-go',
            \ 'coc-tsserver']

" limit suggestions to 10
set pumheight=10

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>r  <Plug>(coc-format-selected)
nmap <leader>r  <Plug>(coc-format-selected)

augroup cocgroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Mappings using CoCList:
" Show all diagnostics.
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" == Vim Go ==
let vim_plugin = 'vim-go'
if vim_plugin == 'vim-go'
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

    " Test and see if there are any perf issue in syntax highlighting
    " in nvim too?
    if !has('nvim')
        " use treesitter
        " let g:go_highlight_structs = 1
        " let g:go_highlight_methods = 1
        " let g:go_highlight_functions = 1
        " let g:go_highlight_operators = 1
        " let g:go_highlight_build_constraints = 1
        " let g:go_highlight_function_calls = 1
        " let g:go_highlight_extra_types = 1
        " let g:go_highlight_function_parameters = 1
        " let g:go_highlight_types = 1
        " let g:go_highlight_fields = 1
        " let g:go_highlight_generate_tags = 1
        " let g:go_highlight_variable_declarations = 1
        " let g:go_highlight_variable_assignments = 1
    endif
    " let g:go_def_mode='gopls'
    " let g:go_info_mode='gopls'

    " show type info for word under cursor
    let g:go_auto_type_info = 1
    " goimports on save
    let g:go_fmt_command = 'goimports'
    " jump to existing buffer
    let g:go_def_reuse_buffer = 1
    " run meta lint on save - needs setup
    let g:go_metalinter_autosave = 0
    " let g:go_gopls_enabled = 0
    " rename command
    let g:go_rename_command = 'gopls'
    " use coc vim - use todo: coc-go
    let g:go_code_completion_enabled = 0
    " disable vim-go :GoDef short cut (gd)
    " this is handled by LanguageClient [LC]
    let g:go_def_mapping_enabled = 0
    " disable vim go docs
    let g:go_doc_keywordprg_enabled = 0
    " loc window bug with vim-go syntastic
    " let g:go_list_type = "quickfix"
    let g:go_debug_address = '127.0.0.1:40000'
    " let g:go_debug_substitue_paths = [ ['/host-path', '/remote-path'] ] 
    let g:go_gopls_options = ['-remote=auto']
else
    " Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'neovim/nvim-lspconfig'
    Plug 'ray-x/go.nvim'
    Plug 'ray-x/guihua.lua' " recommended if need floating window support

    Plug 'mfussenegger/nvim-dap'
    Plug 'rcarriga/nvim-dap-ui'
    Plug 'theHamsta/nvim-dap-virtual-text'
endif

" == SYNTASTIC ==
Plug 'vim-syntastic/syntastic'
" linters
let g:syntastic_loc_list_height = 6
let g:syntastic_error_symbol = '✖'
let g:syntastic_style_error_symbol = '✖'
let g:syntastic_warning_symbol = '!'
let g:syntastic_style_warning_symbol = '!'
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_highlighting = 1
let g:syntastic_ignore_files = ['\mvendor/']
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_mode_map = { 'mode': 'passive', 'passive_filetypes': ['go'] } " passive mode for lightline

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

" == ctags ==
Plug 'ludovicchabant/vim-gutentags'

" indication of gutentag running
" set statusline+=%{gutentags#statusline()}

" update statusline state
augroup MyGutentagsStatusLineRefresher
    autocmd!
    autocmd User GutentagsUpdating call lightline#update()
    autocmd User GutentagsUpdated call lightline#update()
augroup END

" filetype exclude list
let g:gutentags_exclude_filetypes = ['go', 'html', 'javascript']

" start generating as soon as vim is opened
let g:gutentags_generate_on_empty_buffer=1

" more tag info, see ctags --list-fields
let g:gutentags_ctags_extra_args = [
            \ '--tag-relative=yes',
            \ '--fields=+ailmnS',
            \ ]

" dont pollute project root with tags file
let g:gutentags_cache_dir='~/.cache/vim/gutentags'

" == statusline ==
Plug 'itchyny/lightline.vim'

let g:lightline = {
            \ 'colorscheme': 'darcula',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'cocstatus', 'currentfunction', 'readonly', 'relativepath', 'modified' ] ],
            \   'right': [ [ 'lineinfo' ],
            \              [ 'percent' ],
            \              [ 'fileformat', 'fileencoding', 'filetype' ],
            \              [ 'gutentags' ]
            \   ]
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
            \   'gutentags': 'gutentags#statusline',
            \   'currentfunction': 'CocCurrentFunction',
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ }

" fixes colours breaking on save
augroup myvimrc
    au!
    au BufWritePost init.vim,plugins.vim ++nested so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" dont show current mode
set noshowmode

" gruvbox theme
Plug 'morhetz/gruvbox'
" Customize fzf colors to match your color scheme
" if get(g:, 'colors_name', 'default') == "gruvbox"
let g:gruvbox_italic=1
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" == xcode like colors ==
Plug 'arzg/vim-colors-xcode'
augroup vim_colors_xcode
    autocmd!
    autocmd vim_colors_xcode ColorScheme * hi Comment        cterm=italic gui=italic
    autocmd vim_colors_xcode ColorScheme * hi SpecialComment cterm=italic gui=italic
augroup END

" vscode like dark mode
Plug 'martinsione/darkplus.nvim'

" == git line change signs ==
" Update Git signs every time the text is changed
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif
" let g:signify_disable_by_default = 0
let g:signify_sign_add    = '+'
let g:signify_sign_change = '┃'
let g:signify_sign_delete = '-'
let g:signify_sign_show_count = 0 " Don’t show the number of deleted lines.
" not working :/
" autocmd User SignifySetup
"             \ execute 'autocmd! signify' | autocmd signify TextChanged,TextChangedI * call sy#start()

" == Remote Yank ==
" [SECURITY RISK on shared systems]
" uses osc52 escape sequence
Plug 'fcpg/vim-osc52'

" == Startup screen ==
Plug 'mhinz/vim-startify'
let g:startify_change_to_dir = 0

" == Fugitive (git manager) ==
Plug 'tpope/vim-fugitive'

" == GBrowse support for GitHub in fugitive.vim
Plug 'tpope/vim-rhubarb'

" == Icons (nerdtree, lightline, startify)
Plug 'ryanoasis/vim-devicons'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" == More Text Objects ==
" https://github.com/wellle/targets.vim/blob/master/cheatsheet.md
Plug 'wellle/targets.vim'
" extend argument to curlies
autocmd User targets#mappings#user call targets#mappings#extend({
            \ 'a': {'argument': [{'o': '[{([]', 'c': '[])}]', 's': ','}]},
            \ })

" == Smart substitute ==
Plug 'tpope/vim-abolish'

" == Show all registers ==
Plug 'junegunn/vim-peekaboo'

" == Markdown preview ==
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
" let g:mkdp_filetypes = ['markdown', 'gitcommit']

" == Aligning (tabularize) ==
Plug 'godlygeek/tabular'

" == Xdebug ==
Plug 'vim-vdebug/vdebug'
let g:vdebug_options = {}
let g:vdebug_options['port'] = 9000
let g:vdebug_options['ide_key'] = 'XDEBUG_IDE_KEY'
let g:vdebug_options['debug_file_level'] = 2
" let g:vdebug_options['debug_file'] = '/tmp/vdebug.log'

" == Terraform ==; more: https://github.com/hashivim/vim-terraform
Plug 'hashivim/vim-terraform'

" == jsonnet filetype highlight
Plug 'google/vim-jsonnet'

" == fFtT;, on steroids
Plug 'unblevable/quick-scope'
let g:qs_buftype_blacklist = ['terminal', 'nofile', 'startify']
let g:qs_lazy_highlight = 1
let g:qs_delay = 150 " 150ms

" == Split and Join lines
Plug 'AndrewRadev/splitjoin.vim'

" == CTRL P ==
" CtrlP file search
" let g:ctrlp_lazy_update = 0
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|DS_Store|vendor)|(\.(swp|ico|git|svn))$'
" let g:ctrlp_max_files=0
" let g:ctrlp_max_depth=40
" let g:ctrlp_show_hidden = 1

if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " https://github.com/nvim-treesitter/nvim-treesitter#supported-languages
endif

" == Python requirements.txt syntax plugin
Plug 'raimon49/requirements.txt.vim'

" == k8s helm chart syntax
Plug 'towolf/vim-helm'

" == jinja syntax
Plug 'Glench/Vim-Jinja2-Syntax'

" == ansible syntax
Plug 'pearofducks/ansible-vim'

" vim debugger with DAP
Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings='HUMAN'
let g:vimspector_install_gadgets = [ 'debugpy' ]
let g:vimspector_base_dir = expand( '$HOME/.config/vimspector' )

" csv plugin
Plug 'chrisbra/csv.vim'

" GitHub codeowners
Plug 'rhysd/vim-syntax-codeowners'

" postgres syntax highlighting
Plug 'lifepillar/pgsql.vim'

" copilot
Plug 'github/copilot.vim'
let g:copilot_enabled = v:false

" codeium (free copilot)
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }

" diff view

if has('nvim')
    Plug 'sindrets/diffview.nvim'
    Plug 'nvim-tree/nvim-web-devicons'
endif

" TODO - to be tried later
" https://github.com/nvim-telescope/telescope.nvim

call plug#end()
" -----------------------------------

" gruvbox
" colorscheme gruvbox

" dark colour scheme for neovim
colorscheme darkplus

" xcode
" colorscheme xcodedark
" colorscheme xcodedarkhc
" colorscheme xcodelight
" colorscheme xcodelighthc
" colorscheme xcodewwdc

" coc extensions - after plug#end

" private vimrc
try
    source ~/.private.vimrc
catch
    " no issues
endtry
