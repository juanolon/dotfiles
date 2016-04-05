
let g:loaded_python3_provider = 1
let g:python3_host_skip_check = 1
" let g:python3_host_prog = '/usr/local/bin/python3'

" Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'juanolon/mod-base16-railscasts'
Plug 'itchyny/lightline.vim'
" Plug 'kien/ctrlp.vim'
" Plug 'FelikZ/ctrlp-py-matcher'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nixprime/cpsm', { 'do': './install.sh' }
Plug 'kshenoy/vim-signature'
Plug 'Valloric/MatchTagAlways'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Plug 'Shougo/deoplete.nvim'
Plug 'whatyouhide/vim-lengthmatters'
Plug 'morhetz/gruvbox' "test
Plug 'mhartington/oceanic-next' "test

" ##### Helpers
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'zhaocai/GoldenView.Vim'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'
Plug 'jiangmiao/auto-pairs'

" ##### Tools
Plug 'xolox/vim-misc' | Plug 'xolox/vim-notes'
Plug 'mbbill/undotree'
Plug 'tpope/vim-vinegar'
" Plug 'junegunn/vim-peekaboo'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'gabesoft/vim-ags'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'

" ##### FileTypes
Plug 'othree/html5.vim', { 'for': [ 'html', 'htm', 'twig' ]}
Plug 'juanolon/vim-twig', { 'for': 'twig' }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'myhere/vim-nodejs-complete', { 'for': 'javascript' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'garyburd/go-explorer', { 'for': 'go' }
" Plug 'mkusher/padawan.vim'
Plug 'joonty/vdebug', { 'for': 'php' }
Plug 'stephpy/vim-php-cs-fixer', { 'for': 'php' }
Plug 'honza/dockerfile.vim', { 'for': 'docker' }
" syntax highlighting for c, bison, flex
Plug 'justinmk/vim-syntax-extra', { 'for': 'c' }

Plug 'majutsushi/tagbar', { 'for': 'go' }

Plug 'benekastah/neomake'

call plug#end()
" }}}

" General {{{
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
filetype plugin indent on "load filetype plugins/indent settings
syntax on "enable syntax highlight
set shell=/bin/bash "set bash as default shell
" set clipboard=unnamed
set clipboard+=unnamedplus
set fileformat=unix
set noerrorbells
" set nohidden
set hidden
set history=1000 "keep 1000 lines of command line history
set undolevels=1000
set gdefault "the /g flag on :s substitutions by default
set synmaxcol=800 "don't highlight lines longer than 800

set tags+=./tags.vendors,tags.vendors

" colorscheme wombat " alternative: maloki, ir_black
" colorscheme wombat256mod
" colorscheme mod-base16-railscasts
" colorscheme OceanicNext
colorscheme gruvbox
set background=dark

" Don't timeout key sequences
set notimeout
" Timeout key codes (don't wait after Esc)
set ttimeout
set ttimeoutlen=10
if ! has('gui_running')
    set ttimeoutlen=10
    augroup FastEscape
        autocmd!
        au InsertEnter * set timeoutlen=0
        au InsertLeave * set timeoutlen=1000
    augroup END
endif

au BufWinLeave ?* mkview
au BufWinEnter ?* silent! loadview

set scs "smart search (override 'ic' when pattern has upper)
set complete=.,w,b,t,kspell "set the autocomplete search list
set completeopt=menu,noselect,noinsert
set splitbelow

" }}}

" Backup {{{
if ! isdirectory(expand('~/.vimbackup'))
  call mkdir(expand('~/.vimbackup'))
endif
if ! isdirectory(expand('~/.vimtmp'))
  call mkdir(expand('~/.vimtmp'))
endif

if ! isdirectory(expand('~/.vimundo'))
  call mkdir(expand('~/.vimundo'))
endif

" Set persistent undo
set undodir=~/.vimundo
set undofile

" backup
set noswapfile
set backup
set backupdir=~/.vimbackup
set backupext=.vimbackup
set directory=~/.vimtmp
" }}}

" Fixes {{{
" close quick fix window, when leaving file
aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END
" }}}

" UI {{{
set lazyredraw "do not redraw while running macros

set cmdheight=2 "set the commandheight

set wildmode=list:longest,full "command <tab> completion, list matches, then longest common part, then all
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg          " binary images
set wildignore+=*.DS_Store?                             " OSX bullshit
set wildignore+=*.pdf,*.dvi,*.ps                        " Documents

set ignorecase "set ignorecase on
set smartcase
set ruler "show the cursor position all the time

set scrolljump=1 "lines to scroll when cursor leaves screen
set scrolloff=0 "minimun lines to keep adove and below cursor
set showmatch
set showmode "show the current mode

set relativenumber
set number

set showcmd "show partial commands?
set magic "magic for regular expressions
" set anti enc=utf-8 gfn=Source_Code_Pro:h13,Inconsolata-dz_for_Powerline:h11,Menlo:h11,Monaco:h11

"show characters
set list
set listchars=tab:>\ ,eol:¬,extends:>,precedes:<
" }}}

" Folding {{{
set foldmethod=syntax
set nofoldenable " don't open folds by default
" Close higher-level folds on foldenable
set foldnestmax=1
set foldlevel=1
" toggle with space
vnoremap <Space> za
nnoremap <Space> za

fu! CustomFoldText()
    "get first non-blank line
    let fs = v:foldstart
    while getline(fs) =~ '^\s*$' | let fs = nextnonblank(fs + 1)
    endwhile
    if fs > v:foldend
        let line = getline(v:foldstart)
    else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
    endif

    let w = winwidth(0) - &foldcolumn - (&number ? 8 : 0)
    let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = " " . foldSize . " lines "
    let foldLevelStr = repeat("+--", v:foldlevel)
    let lineCount = line("$")
    let foldPercentage = printf("[%.1f", (foldSize*1.0)/lineCount*100) . "%] "
    let expansionString = repeat(".", w - strwidth(foldSizeStr.line.foldLevelStr.foldPercentage))
    return line . expansionString . foldSizeStr . foldPercentage . foldLevelStr
endf
set foldtext=CustomFoldText()
" }}}

" Tabs / Spaces {{{
set expandtab "insert space character, when tab key is pressed
set tabstop=4 "tabs and indenting
set shiftwidth=4
set softtabstop=4

set smartindent
set wrap
set shiftround "always round indents to multiple of shiftwidth
set copyindent "use existind indents for new indents
set preserveindent "save as much indent structure as possible
" }}}

" Settings {{{

" lightline {{{
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'branch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'branch': 'MyBranch',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified',
      \   'filename': 'MyFilename',
      \   'mode': 'MyMode',
      \ },
      \ 'component_expand': {
      \   'neomake': 'neomake#statusline#LoclistStatus',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! MyBranch()
    if &ft !~? 'vimfiler\|undotree\|notes\|vundle'
        let branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
        if branch != ''
            return substitute(branch, '\n', '', 'g')
        endif
    endif
    return ''
endfunction
function! MyModified()
  return &ft =~ 'help\|undotree\|vundle' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! MyReadonly()
  return &ft !~? 'help\|undotree\|vundle' && &readonly ? 'RO' : ''
endfunction
function! MyFilename()
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'nerdtree' ? '' :
        \ &ft == 'undotree' ? '' :
        \ &ft == 'diff' ? '' :
        \ &ft == 'vundle' ? '' :
        \ ('' != fname ? fname : '[No Name]')
endfunction
function! MyMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ &ft == 'undotree' ? 'UndoTree' :
        \ fname == 'diffpanel_3' ? 'UndoDiff' :
        \ fname == '[Vundle] Installer' ? 'Vundle Installer' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction
let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }
function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost g:syntastic_mode_map['active_filetypes'] call lightline#update()
augroup END

" }}}

" vim-notes {{{
if ! isdirectory(expand('~/notes'))
  call mkdir(expand('~/notes'))
endif
let g:notes_directories = [ '~/notes' ]
let g:notes_title_sync = 'change_title' " if file name or first line is changed, this update the first line
" }}}

" CtrlP {{{
let g:ctrlp_working_path_mode = 0 "don't change working directory..
let g:ctrlp_match_window_reversed = 0 " listing order from top to bottom
let g:ctrlp_lazy_update = 350
let g:ctrlp_clear_cache_on_exit = 0 " cross session caching
let g:ctrlp_cache_dir = $HOME.'/.vimtmp/ctrlp'
let g:ctrlp_max_depth = 20
let g:ctrlp_dotfiles = 0 " don't scan dotfiles
let g:ctrlp_open_new_file = 'u' " ope new file in same window
let g:ctrlp_open_multiple_files = 'r' " open multiple files in the current window
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0

" PyMatcher for CtrlP
if !has('python') && !has('python3')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    " let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
    let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
endif

if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
        \ --ignore .git
        \ --ignore .svn
        \ --ignore .hg
        \ --ignore node_modules
        \ --ignore .DS_Store
        \ --ignore "**/*.pyc"
        \ -g ""'
else
    let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others']
endif

nnoremap <C-b> :CtrlPBuffer<CR>
" }}}

" vim-nodejs-complete {{{
" let g:nodejs_complete_config = {
" \  'js_compl_fn': 'jscomplete#CompleteJS',
" \  'max_node_compl_len': 15
" \}

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
" }}}

" vim-less {{{
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType less set omnifunc=csscomplete#CompleteCSS
" }}}

" vim-lengthmatters {{{
let g:lengthmatters_start_at_column = 120
" }}}

" Tabularize: {{{
vmap <leader>t= :Tabularize /=<CR>
vmap <leader>t: :Tabularize /:\zs/l0l1<CR>
" }}}

" MatchTagAlways: {{{
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'html.twig' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'htmldjango' : 1,
    \ 'ezp' : 1,
    \ 'twig' : 1,
    \}
" }}}

" YouCompleteMe: {{{
" change this map, c-space doesn't work, because control will be send the ESC
" character. also when c+space are pressed (maybe change this on keyremap4mac)
" let g:ycm_key_invoke_completion = '<C-Space>'

let g:ycm_extra_conf_globlist = ['~/pebble/*','!~/*']
let g:ycm_show_diagnostics_ui = 1
" let g:ycm_autoclose_preview_window_after_insertion=1
" Ctags needs to be called with the --fields=+l option (that's a lowercase L, not a one)
" let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_semantic_triggers = {}
let g:ycm_semantic_triggers.php = ['->', '::', '(', 'use ', 'namespace ', '\']
" }}}

" deoplete.nvim {{
" let g:deoplete#enable_at_startup = 1
" " let g:deoplete#enable_debug = 1
" let g:deoplete#enable_profile = 1
" let g:deoplete#sources = {}
" let g:deoplete#sources._ = ['buffer', 'file', 'ultisnips']
" }}

" Ultisnips: {{{
let g:snips_author="Juan Pablo Stumpf <juanolon@gmail.com>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetDirectories=["Ultisnips"]

let g:vundle_lazy_load=1
let g:ycm_show_diagnostics_ui=0

func! g:JInYCM()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<c-j>"
endfunction

func! g:KInYCM()
    if pumvisible()
        return "\<C-p>"
    else
        return "\<c-k>"
endfunction

inoremap <c-j> <c-r>=g:JInYCM()<cr>
au BufEnter,BufRead * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:KInYCM()<cr>"
" }}}

" VDebug: {{{
let g:vdebug_keymap = {
\    "run" : "<Leader>s",
\    "run_to_cursor" : "<Down>",
\    "step_over" : "<Up>",
\    "step_into" : "<Right>",
\    "step_out" : "<Left>",
\    "close" : "q",
\    "detach" : "x",
\    "set_breakpoint" : "<Leader>d",
\    "eval_visual" : "<Leader>e"
\}

let g:vdebug_options = {
\    "break_on_open" : 0,
\    "watch_window_style": 'compact',
\    "watch_window_height": 40,
\    "status_window_height": 5
\}
" }}}

" GoldenView: {{{
let g:goldenview__enable_default_mapping = 0
nmap <silent> <leader><C-l> <Plug>GoldenViewSplit
" }}}

" padawan {{{
" let g:padawan#composer_command = "composer"
" }}}

" vim-php-cs-fixer: {{{
" let g:php_cs_fixer_path = "~/php-cs-fixer.phar" " define the path to the php-cs-fixer.phar
let g:php_cs_fixer_level = "psr2"                  " which level ?
let g:php_cs_fixer_config = "sf23"             " configuration
let g:php_cs_fixer_php_path = "php"               " Path to PHP
" If you want to define specific fixers:
let g:php_cs_fixer_fixers_list = "parenthesis"
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
nnoremap <silent><leader>f :call PhpCsFixerFixFile()<CR>
" }}}

" fatih/vim-go {{{
" quick fix for golang
let $PATH .= ':/Users/juanolon/gocode/bin:/usr/local/opt/go/libexec/bin'
" let g:go_bin_path="/Users/juanolon/gocode/bin"
" let g:go_bin_path="/usr/local/opt/go/libexec/bin"
let g:go_fmt_command = "goimports"
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
"}}}

" majutsushi/tagbar {{{
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
"}}}

" undotree {{{
nnoremap <F5> :UndotreeToggle<cr>
" }}}

" easy-motion {{{
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" }}}

" gabesoft/vim-ags {{{
autocmd FileType agsv nnoremap <buffer> ot
  \ :exec 'tab split ' . ags#filePath(line('.'))<CR>

func! GetSelectedText()
  normal gv"xy
  let result = getreg("x")
  normal gv
  return result
endfunc

vnoremap <leader>f :call ags#search(GetSelectedText(), '')<cr>
vnoremap <leader>F :call ags#search(GetSelectedText(), 'add')<cr>
nnoremap <leader>a call ags#search('', 'last')
"}}}

" junegunn/goyo.vim {{{
let g:goyo_width = 120
let g:goyo_height = '100%'

function! s:goyo_enter()
    set textwidth=120
    if exists('$TMUX')
        silent !tmux set status off
    endif
endfunction

function! s:goyo_leave()
    set textwidth=0
    if exists('$TMUX')
        silent !tmux set status on
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" Neomake {{{
let g:neomake_go_enabled_makers = ['golint', 'govet']
" let g:neomake_go_enabled_makers = []

autocmd! BufWritePost * Neomake
" }}}

" }}}

" Maps {{{
nnoremap gp `[v`]

" toggle paste
nnoremap <F3> :set paste!<cr>

" remove unwanted spaces and keep last search and retab
nnoremap <silent> <F6> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<Bar>:retab<CR>
" TODO: when i search for a new entry, than always activate hlseach
nnoremap <silent> <F7> :set hlsearch!<CR>
" toggle syntastic mode
" nnoremap <F10> :SyntasticToggleMode<CR>
" toggle between displaying whitespace characters or not
noremap <F11> :set list!<CR>

nmap <Leader>t :tabnew<CR>

" Save with sudo.
cnoremap w!! %!sudo tee > /dev/null %
cnoremap W w
cnoremap Bd bd

noremap k gk
noremap j gj
noremap 0 g0
noremap $ g$

" Navigate 4x faster when holding down Ctrl
nnoremap <c-j> 4j
nnoremap <c-k> 4k
cnoremap <c-j> 4j
cnoremap <c-k> 4k

" start/end of line
nnoremap <C-h> ^
nnoremap <C-l> $
vnoremap <C-h> ^
vnoremap <C-l> $

" split lines under the cursor (opposite of J)
" noremap <c-m> K
noremap K i<CR><Esc>g;

" Delete a character with the black hole register.
nnoremap X  "_X
nnoremap x  "_x

cnoremap <C-b> <S-Left>
cnoremap <C-w> <S-Right>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-d> <C-w>

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

noremap ' `

" }}}

" FUNCTIONS {{{
" Highlight Word {{{
" https://github.com/sjl/dotfiles/blob/master/vim/vimrc#L1827
"
" This mini-plugin provides a few mappings for highlighting words temporarily.
"
" Sometimes you're looking at a hairy piece of code and would like a certain
" word or two to stand out temporarily.  You can search for it, but that only
" gives you one color of highlighting.  Now you can use <leader>N where N is
" a number from 1-6 to highlight the current word in a specific color.

function! HiInterestingWord(n)
    " Save our location.
    normal! mz

    " Yank the current word into the z register.
    normal! "zyiw

    " Calculate an arbitrary match ID.  Hopefully nothing else is using it.
    let mid = 86750 + a:n

    " Clear existing matches, but don't worry if they don't exist.
    silent! call matchdelete(mid)

    " Construct a literal pattern that has to match at boundaries.
    let pat = '\V\<' . escape(@z, '\') . '\>'

    " Actually match the words.
    call matchadd("InterestingWord" . a:n, pat, 1, mid)

    " Move back to our original location.
    normal! `z
endfunction

" TODO: clear all iteresting words
nnoremap <silent> <leader>1 :call HiInterestingWord(1)<cr>
nnoremap <silent> <leader>2 :call HiInterestingWord(2)<cr>
nnoremap <silent> <leader>3 :call HiInterestingWord(3)<cr>
nnoremap <silent> <leader>4 :call HiInterestingWord(4)<cr>
nnoremap <silent> <leader>5 :call HiInterestingWord(5)<cr>
nnoremap <silent> <leader>6 :call HiInterestingWord(6)<cr>

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195
" }}}

" Zoom / Restore window {{{
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        exec t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
" nnoremap <silent> <M-z> :ZoomToggle<CR>
nnoremap <silent> <C-w>z :ZoomToggle<CR>
" }}}

" show syntax item name {{{
function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

" show syntax block
" call Pl#Theme#InsertSegment(SyntaxItem(), 'after', 'filetype')
" }}}

" show supported colors {{{
" Color test: Save this file, then enter ':so %'
" Then enter one of following commands:
"   :VimColorTest    "(for console/terminal Vim)
"   :GvimColorTest   "(for GUI gvim)
function! VimColorTest(outfile, fgend, bgend)
  let result = []
  for fg in range(a:fgend)
    for bg in range(a:bgend)
      let kw = printf('%-7s', printf('c_%d_%d', fg, bg))
      let h = printf('hi %s ctermfg=%d ctermbg=%d', kw, fg, bg)
      let s = printf('syn keyword %s %s', kw, kw)
      call add(result, printf('%-32s | %s', h, s))
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
" Increase numbers in next line to see more colors.
command! VimColorTest call VimColorTest('vim-color-test.tmp', 12, 16)

function! GvimColorTest(outfile)
  let result = []
  for red in range(0, 255, 16)
    for green in range(0, 255, 16)
      for blue in range(0, 255, 16)
        let kw = printf('%-13s', printf('c_%d_%d_%d', red, green, blue))
        let fg = printf('#%02x%02x%02x', red, green, blue)
        let bg = '#fafafa'
        let h = printf('hi %s guifg=%s guibg=%s', kw, fg, bg)
        let s = printf('syn keyword %s %s', kw, kw)
        call add(result, printf('%s | %s', h, s))
      endfor
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction
command! GvimColorTest call GvimColorTest('gvim-color-test.tmp')
" }}}

" Next and Last {{{
" thanks steve losh

"
" Motion for "next/last object".  "Last" here means "previous", not "final".
" Unfortunately the "p" motion was already taken for paragraphs.
"
" Next acts on the next object of the given type in the current line, last acts
" on the previous object of the given type in the current line.
"
" Currently only works for (, [, {, b, r, B, ', and ".
"
" Some examples (C marks cursor positions, V means visually selected):
"
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')
"                                                                C
"
" canb  -> change around next parens                   foo = bar('spam')
"                                                      C
"                                                      foo = bar
"                                                               C
"
" vil"  -> select inside last double quotes            print "hello ", name
"                                                                        C
"                                                      print "hello ", name
"                                                             VVVVVV

onoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', 'f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', 'f')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', 'F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', 'F')<cr>

function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())

  if c ==# "b"
      let c = "("
  elseif c ==# "B"
      let c = "{"
  elseif c ==# "r"
      let c = "["
  endif

  exe "normal! ".a:dir.c."v".a:motion.c
endfunction

" }}}

" Number Motion {{{
" Motion for numbers.  Great for CSS.  Lets you do things like this:
" margin-top: 200px; -> daN -> margin-top: px;

onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>

function! s:NumberTextObject(whole)
    normal! v

    while getline('.')[col('.')] =~# '\v[0-9]'
        normal! l
    endwhile

    if a:whole
        normal! o

        while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
            normal! h
        endwhile
    endif
endfunction
" }}}

" Execute {{{
":[range]Execute    Execute text lines as ex commands.
command! -bar -range Execute silent <line1>,<line2>yank z | let @z = substitute(@z, '\n\s*\\', '', 'g') | @z
" }}}

" Show rebundant spaces {{{
highlight RedundantSpaces ctermbg=grey guibg=grey
au Syntax * syn match RedundantSpaces /\s\+$\| \+\ze\t/
highlight BadWhitespace ctermbg=red guibg=red
fun! s:MatchBadWhitespace(current)
    if exists('b:hide_bad_whitespace')
        match none
    return
    endif
    if a:current
        match BadWhitespace /\s\+$/
    else
        match BadWhitespace /\s\+\%#\@<!$/
    endif
endfun

augroup WhitespaceMatch
    " Highlight whitespace on open buffer
    autocmd BufWinEnter * call s:MatchBadWhitespace(1)
    " Don't highlight while typing
    autocmd InsertEnter * call s:MatchBadWhitespace(0)
    autocmd InsertLeave * call s:MatchBadWhitespace(1)
    " Clear match when leaving buffer to avoid memory leaks
    autocmd BufWinLeave * call clearmatches()
augroup END
" }}}

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" }}}

" FILETYPE {{{
augroup ft_c
    au!
    au FileType php setlocal foldmethod=manual
augroup END
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
augroup ft_vim
    au!
    au FileType vim setlocal foldmethod=marker
augroup END
augroup ft_markdown
    au!
    autocmd FileType gitcommit setlocal spell
    autocmd FileType markdown setlocal spell
    setlocal spell spelllang=en_us
augroup END

"activate omnifunc: strg-x o
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
" autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" autocmd FileType c set omnifunc=ccomplete#Complete
"
au BufRead,BufNewFile *.tpl  set filetype=ezp

" eZ Publish configuration
au BufRead,BufNewFile *.ini.append.php set filetype=ezpini
au BufRead,BufNewFile *.ini.append set filetype=ezpini
au BufRead,BufNewFile *.ini set filetype=ezpini

autocmd FileType javascript nnoremap <Leader>js :nbs<CR>
autocmd FileType javascript nnoremap <Leader>jc :nbs<CR>
autocmd FileType apache set commentstring=#\ %s
" }}}
