"タブ
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set number
"set list

set nocompatible
filetype plugin indent off

"beepを消す
set visualbell t_vb=

"neobundle
if has('vim_starting')
        set runtimepath+=~/.vim/bundle/neobundle.vim
        call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

"customize

NeoBundle 'fmoralesc/vim-vitamins'
NeoBundle 'vim-scripts/twilight'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'Xuyuanp/nerdtree-git-plugin'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'cohama/agit.vim'

"NeoBundle 'fatih/vim-go'
"NeoBundle 'vim-jp/vim-go-extra'

NeoBundle 'prabirshrestha/async.vim'
NeoBundle 'prabirshrestha/asyncomplete.vim'
NeoBundle 'prabirshrestha/asyncomplete-lsp.vim'
NeoBundle 'prabirshrestha/vim-lsp'
NeoBundle 'mattn/vim-lsp-settings'

"test
NeoBundle 'vim-test/vim-test'

"Dispatch
"コマンド実行時に新たにpainを割り当てる
NeoBundle 'tpope/vim-dispatch'
let test#strategy = "dispatch"

"editorconfigを使う
NeoBundle 'editorconfig/editorconfig-vim'

" ctrl+e -> h,j,k,l
" 細かい設定は下に
NeoBundle 'simeji/winresizer'

"localvimrc
"makeとかで引数違いが地味にある
NeoBundle 'embear/vim-localvimrc'

"go用のutil
NeoBundle 'mattn/vim-gorun'
""go install golang.org/x/tools/cmd/goimports@latest
NeoBundle 'mattn/vim-goimports'
""go install github.com/fatih/gomodifytags@latest
NeoBundle 'mattn/vim-goaddtags'
""go install github.com/josharian/impl@latest
NeoBundle 'mattn/vim-goimpl'


"保存時にeslint
"http://qiita.com/toshihirock/items/39ee62ddee2eb997f7b7
"NeoBundle 'scrooloose/syntastic.git'

filetype plugin indent on

"grepしたいときは :vim ''pattern'' **/*.suffix
autocmd QuickFixCmdPost *grep* cwindow

"日本語テスト
call neobundle#end()

colorscheme vitamins
set t_Co=256

syntax on

"enable BS on INSERT mode
set backspace=indent,eol,start

"NERDTree shortcut
map <C-n> :NERDTreeToggle

"vim-go ワーニングが出る、vim 7.4.2009かNeovim 0.3.1以降推奨とのこと
"let g:go_version_warning = 0

set laststatus=2

"lvimrcロードを暗黙でやる(尋ねてこない)
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

"https://qiita.com/kitagry/items/216c2cf0066ff046d200
nmap <silent> gd :LspDefinition<CR>
nmap <silent> gl :LspHover<CR>
nmap <silent> gi :LspImplementation<CR>
nmap <silent> gc :LspDocumentDiagnostics<CR>
nmap <silent> <f2> :LspRename<CR>

let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_auto_popup = 1
"let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200

"整形とimport整理
autocmd BufWritePre *.go call execute(['LspCodeActionSync source.organizeImports', 'LspDocumentFormatSync'])"
