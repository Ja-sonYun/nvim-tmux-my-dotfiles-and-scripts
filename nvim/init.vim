" add python support
let g:python_host_prog = system('(type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(pyenv global | grep python2)/bin/python") || echo -n $(which python2)')
let g:python3_host_prog = system('(type pyenv &>/dev/null && echo -n "$(pyenv root)/versions/$(pyenv global | grep python3)/bin/python") || echo -n $(which python3)')

let s:using_snippets = 0

set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()            " required
Plugin 'VundleVim/Vundle.vim'  " required
Plugin 'OmniSharp/omnisharp-vim'
" Mappings, code-actions available flag and statusline integration
Plugin 'nickspoons/vim-sharpenup'

" Linting/error highlighting
Plugin 'dense-analysis/ale'

" Vim FZF integration, used as OmniSharp selector
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'chrisbra/csv.vim'

" Colorscheme
Plugin 'gruvbox-community/gruvbox'
Plugin 'Yggdroot/indentLine'

" Syntax highlight
Plugin 'mxw/vim-jsx'
Plugin 'stanangeloff/php.vim'
Plugin 'posva/vim-vue'
Plugin 'shime/vim-livedown'
Plugin 'plasticboy/vim-markdown'
Plugin 'bad-whitespace'
Plugin 'jwalton512/vim-blade'

" GIT
Plugin 'tpope/vim-fugitive'
Plugin 'mhinz/vim-signify'

" Statusline
Plugin 'itchyny/lightline.vim'
Plugin 'mengelbrecht/lightline-bufferline'
Plugin 'shinchu/lightline-gruvbox.vim'
Plugin 'maximbaz/lightline-ale'

" dash
Plugin 'rizzatti/dash.vim'

" Autocompletion
" Plugin 'pangloss/vim-javascript'
Plugin 'tommcdo/vim-lion'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'chrisbra/unicode.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'schickling/vim-bufonly'
Plugin 'vim-scripts/DrawIt'
Plugin 'surround.vim'
Plugin 'mattn/emmet-vim'
Plugin 'LeafCage/yankround.vim'
Plugin 'jiangmiao/auto-pairs'

Plugin 'prabirshrestha/vim-lsp'
Plugin 'prabirshrestha/asyncomplete-lsp.vim'
Plugin 'prabirshrestha/asyncomplete.vim'
Plugin 'keremc/asyncomplete-clang.vim'
Plugin 'prabirshrestha/async.vim'
Plugin 'runoshun/tscompletejob'
Plugin 'prabirshrestha/asyncomplete-tscompletejob.vim'

" tmux
Plugin 'christoomey/vim-tmux-navigator'

" php completion
Plugin 'shawncplus/phpcomplete.vim'

" directory plugin
Plugin 'preservim/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dyng/ctrlsf.vim'
Plugin 'MultipleSearch'

" cursor
Plugin 'terryma/vim-multiple-cursors'

Plugin 'ryanoasis/vim-devicons'

" Display
if has('nvim')
  Plugin 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/denite.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

" Snippet support
if s:using_snippets
  Plugin 'sirver/ultisnips'
endif

call vundle#end()               " required
filetype plugin indent on       " required
if !exists('g:syntax_on') | syntax enable | endif
set encoding=UTF-8
scriptencoding utf-8

set backspace=indent,eol,start
set expandtab
set shiftround
set shiftwidth=4
set softtabstop=-1
set tabstop=8
set title

set hidden
set nofixendofline
set nostartofline
set splitbelow
set splitright

set clipboard=unnamedplus

set hlsearch
set incsearch
set laststatus=2

set number relativenumber
set showtabline=2

autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=2 sw=2 sts=0 expandtab
autocmd Filetype json setlocal ts=2 sw=2 sts=0 expandtab

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set noruler
set noshowmode
" set signcolumn=yes

set mouse=a
set updatetime=1000

" NMAP:
nmap ,A :ALEDetail
nmap ,a :noh
nmap ,c :tabnew
nmap ,x :tabclose
nmap ,M :tabnext
nmap ,N :tabprevious
nmap ,m :bn
nmap ,n :bp
nmap ,t :NERDTreeToggle
nmap ,tg :TagbarToggle
nmap Q <Nop>

" Denite:
augroup denite_filter
  autocmd FileType denite call s:denite_my_settings()
  function! s:denite_my_settings() abort
    nnoremap <silent><buffer><expr> <CR>
    \ denite#do_map('do_action')
    nnoremap <silent><buffer><expr> d
    \ denite#do_map('do_action', 'delete')
    nnoremap <silent><buffer><expr> p
    \ denite#do_map('do_action', 'preview')
    nnoremap <silent><buffer><expr> q
    \ denite#do_map('quit')
    nnoremap <silent><buffer><expr> i
    \ denite#do_map('open_filter_buffer')
    nnoremap <silent><buffer><expr> <Space>
    \ denite#do_map('toggle_select').'j'
  endfunction
augroup END
" use floating
let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7
let s:denite_default_options = {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ 'highlight_filter_background': 'DeniteFilter',
    \ 'prompt': '$ ',
    \ 'start_filter': v:true,
    \ }
let s:denite_option_array = []
for [key, value] in items(s:denite_default_options)
  call add(s:denite_option_array, '-'.key.'='.value)
endfor
call denite#custom#option('default', s:denite_default_options)

call denite#custom#var('file/rec', 'command',
    \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
    \ [ '.git/', '.ropeproject/', '__pycache__/',
    \   'venv/', 'images/', '*.min.*', 'img/', 'fonts/'])
" Ag command on grep source
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
" grep
command! -nargs=? Dgrep call s:Dgrep(<f-args>)
function s:Dgrep(...)
  if a:0 > 0
    execute(':Denite -buffer-name=grep-buffer-denite grep -path='.a:1)
  else
    execute(':Denite -buffer-name=grep-buffer-denite '.join(s:denite_option_array, ' ').' grep')
  endif
endfunction
" show Denite grep results
command! Dresume execute(':Denite -resume -buffer-name=grep-buffer-denite '.join(s:denite_option_array, ' ').'')
" next Denite grep result
command! Dnext execute(':Denite -resume -buffer-name=grep-buffer-denite -cursor-pos=+1 -immediately '.join(s:denite_option_array, ' ').'')
" previous Denite grep result
command! Dprev execute(':Denite -resume -buffer-name=grep-buffer-denite -cursor-pos=-1 -immediately '.join(s:denite_option_array, ' ').'')
" keymap
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')


augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

" Use truecolor in the terminal, when it is supported
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme gruvbox
" }}}

" ALE: {{{
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'

let g:ale_linters = {
\ 'cs': ['OmniSharp'],
\}
" \ 'javascript': ['eslint'],
" }}}

" OmniSharp: {{{
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
  let g:OmniSharp_popup_options = {
  \ 'winhl': 'Normal:NormalFloat'
  \}
else
  let g:OmniSharp_popup_options = {
  \ 'highlight': 'Normal',
  \ 'padding': [0, 0, 0, 0],
  \ 'border': [1]
  \}
endif
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}

if s:using_snippets
  let g:OmniSharp_want_snippet = 1
endif

let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}
" }}}

" Asyncomplete: {{{
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" set completeopt=menuone,noinsert,noselect,preview
" set completepopup=highlight:Pmenu,border:off
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif
autocmd User asyncomplete_setup call asyncomplete#register_source(
    \ asyncomplete#sources#clang#get_source_options({
    \     'config': {
    \         'clang_path': '/usr/local/opt/llvm/bin/clang',
    \         'clang_args': {
    \             'default': ['-I/usr/local/opt/llvm/include'],
    \             'cpp': ['-std=c++11', '-I/usr/local/opt/llvm/include']
    \         }
    \     }
    \ }))
" call asyncomplete#register_source(asyncomplete#sources#tscompletejob#get_source_options({
    " \ 'name': 'tscompletejob',
    " \ 'allowlist': ['typescript'],
    " \ 'completor': function('asyncomplete#sources#tscompletejob#completor'),
    " \ }))
" }}}

" Sharpenup: {{{
" All sharpenup mappings will begin with `<Space>os`, e.g. `<Space>osgd` for
" :ONniSharpGotoDefinition
let g:sharpenup_map_prefix = '<Space>os'

let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END
" }}}

" Lightline: {{{
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\   ],
\   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
\ },
\ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
\ },
\ 'component_expand': {
\   'buffers': 'lightline#bufferline#buffers',
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
\     'buffers': 'tabsel',
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
\  }
\}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "
" }}}

" Ctrlp:
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" NerdCommenter:
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

" NERDTree:
let g:NERDTreeShowBookmarks = 1
let NERDTreeHijackNetrw = 0
function! GotoTree()
    :NERDTree %:p:h
endfunction
let NERDTreeMapActivateNode=''
let NERDTreeHijackNetrw=1
nmap ,nerd :NERDTree


" Yankround:
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)

xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)

" Buffergator:
let g:buffergator_viewport_split_policy="T"
nmap  ,g :BuffergatorOpen
