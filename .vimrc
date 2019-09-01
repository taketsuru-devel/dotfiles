"タブ
set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

set number

set nocompatible
filetype plugin indent off

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

NeoBundle 'fatih/vim-go'
NeoBundle 'vim-jp/vim-go-extra'

"editorconfigを使う
NeoBundle 'editorconfig/editorconfig-vim'

"保存時にeslint
"http://qiita.com/toshihirock/items/39ee62ddee2eb997f7b7
NeoBundle 'scrooloose/syntastic.git'

filetype plugin indent on

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
let g:go_version_warning = 0

set laststatus=2

