set encoding=utf-8

" indent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smartindent
set smarttab

" display
set number
set ruler

" delay between insert to normal
set ttimeoutlen=10

" util
let mapleader = "\<Space>"
set noswapfile
set nobackup
set nocompatible
set completeopt+=menuone

" search
set wrapscan
set showmatch
set ignorecase
set incsearch
set smartcase
set hlsearch
set lazyredraw

filetype plugin indent on

" for util
set mouse=a
if has("clipboard")
    set clipboard=unnamed,autoselect
endif

call plug#begin()
Plug 'tani/vim-jetpack', {'opt': 1}
" for views
Plug 'Rigellute/rigel'
Plug 'vim-airline/vim-airline'
" Jetpack 'tpope/vim-fugitive'
" for input helper
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" support
Plug 'github/copilot.vim'
" filer
Plug 'lambdalisue/fern.vim'
" for finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-matchfuzzy'
" for editting
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" load after some plugins
Plug 'ryanoasis/vim-devicons'
" for lsp
Plug 'dense-analysis/ale'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'rhysd/vim-lsp-ale'
" for run
Plug 'thinca/vim-quickrun'
" for each languages
" Go
Plug 'mattn/vim-goimports'
Plug 'sebdah/vim-delve'
" Rust
Plug 'rust-lang/rust.vim'
" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
" Html
Plug 'alvan/vim-closetag'
call plug#end()

if (has("termguicolors"))
  set termguicolors
endif

syntax enable
colorscheme rigel

let g:rigel_airline = 1
let g:airline_theme = 'rigel'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 1

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <C-Space>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <C-Space>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'

" ctrlP
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
let g:ctrlp_user_command = [['.git', 'git -C "%s" ls-files']]
let g:ctrlp_cmd = 'CtrlPMixed'

" vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" autopairs
let g:AutoPairsMultilineClose = 0

" vim-lsp
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_float_cursor = 0
let g:asyncomplete_popup_delay = 10
let g:asymcomplete_auto_popup = 1

nnoremap <Leader>l :LspDocumentDiagnostics<CR>
augroup go_leader_l_mapping
    autocmd!
    autocmd FileType go nnoremap <buffer> <Leader>l :lopen<CR>
augroup END
nnoremap <Leader>f :LspDocumentFormat<CR>
nnoremap <Leader>h :LspHover<CR>
nnoremap <Leader>d :Fern .<CR>
nnoremap <Leader>def :LspHover<CR>

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~ '\s'
endfunction

inoremap <expr><CR> pumvisible() ? "\<c-y>" : "\<cr>"
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" run
nmap <silent> <Leader>r :QuickRun<CR>

" change split view
nmap <silent> <Leader>p :wincmd p<CR>
nmap <silent> <Leader>w :wincmd w<CR>
" open terminal in the bottom of the screen
nmap <silent> <Leader>t :bo term<CR>

" Go
nmap <silent> <Leader>9 :DlvToggleBreakpoint<CR>
nmap <silent> <Leader>5 :DlvDebug<CR>
let g:lsp_settings_filetype_go = ['gopls']
let g:lsp_settings={'gopls':{'initialization_options': {'usePlaceholders': v:true,},},}
let g:ale_linters = {'go': ['revive']}
let g:ale_fix_on_save = 1

" Rust
let g:rustfmt_autosave = 1

" Markdown
let g:vim_markdown_folding_disabled = 1

" For each languages
" TS,JS
let g:lsp_settings_filetype_typescript = ['typescript-language-server', 'deno']
let g:lsp_settings_filetype_typescript = ['javascript-language-server', 'deno']
autocmd BufWritePre *.ts call execute('LspDocumentFormat')
autocmd BufWritePre *.js call execute('LspDocumentFormat')

" tmpl
au BufRead,BufNewFile *.tmpl set filetype=html
" html
let g:closetag_filetypes = 'html,xhtml,phtml'

" for copilot
let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ 'markdown': v:true,
    \ 'yaml': v:true
    \ }
