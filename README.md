# 初期設定
- ln -s dotfiles/.vimrc ~/
- ln -s dotfiles/.bash_profile_add ~/
- ln -s dotfiles/.tmux_conf ~/
- ~/.bash_profileの末尾にsource .bash_profile_add

# git
- git config --global user.name  "********"
- git config --global user.email "********"

# vim
- neobundle入れる
    - curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
    - ./install.sh
- vim開いて:neoBundleInstall
- .lvimrcも使える
    - サンプル
    - nmap <silent> gm :Dispatch make -f scripts/Makefile build-linux<CR>
    - nmap <silent> gt :TestFile<CR>
## キーバインド
- 追加したものやデフォのもの含めメモ
    - `C-n` -> nerdtree
    - `C-e h,j,k,l` -> リサイズ
    - `gd` -> Lspで定義ジャンプ
    - `gl` -> Lspで定義簡易表示
    - `gi` -> Lspで？？？
    - `gc` -> Lspで文法チェック
    - `:vim "pattern" */**(.suffix)` -> grep & quickfix

# tmux
- 2.6

# go
- goenv
    - git clone https://github.com/syndbg/goenv.git ~/.goenv 
- aptなりyumで入れた後の環境変数
    - cat ~/dotfiles/.bashrc_diff >> ~/.bashrc
- mkdir $HOME/go
- ツールを入れる
    - go install golang.org/x/tools/cmd/goimports@latest
    - go install github.com/fatih/gomodifytags@latest
    - go install github.com/josharian/impl@latest
    - 多分goenvのバージョン単位で必要
    - `:GoImpl if名 str名`でstrと実装すべきfuncを生成
    - 構造体定義の中で`:GoAddTags json`でtag、`:GoRemoveTags`で削除生成
    - デフォはsnake、camelにしたけりゃ.lvimrcで`let g:go_addtags_transform = 'camelcase'`

# node
- nvm入れる
-- ubuntuではこれが必要
--- build-essential libssl-dev
-- curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh > install.sh
-- ./install.sh
- source ~/.bashrc
- 今使ってるのは10.16.3
-- nvm install 10.16.3
-- nvm use 10.16.3

# rust
- curl -sSf https://sh.rustup.rs | sh
- 公式のlspを使う
-- rustup component add rls rust-analysis rust-src 

# terminal
- beepを消す
-- sudo vim /etc/inputrc
-- set bell-style noneの行のコメントアウト解除
