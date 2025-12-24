# 初期設定
- ~/でgit clone
- ln -s dotfiles/.bash_profile_add ~/
- ln -s dotfiles/.tmux_conf ~/
- ~/.bash_profileの末尾にsource .bash_profile_add
- cd ~/.config/nvim && ln -s ~/dotfiles/init.lua ./
- cd ~/.claude/ && ln -s ~/dotfiles/skills ./

# git
- git config --global user.name  "********"
- git config --global user.email "********"
- gh入れてgh auth login

# tmux
- 2.6
  - ctrl+qで切り替え
    - cで窓追加
    - p,nで切り替え
    - "で下分割
    - %で横分割

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

# nvim
## カスタムキーバインド
### 基本
- リーダーキー: スペース
- ファイルツリー: `Ctrl+h` でNvimTreeトグル（.vimrcでは `Ctrl+n`）
- ターミナルモード脱出: `Esc`

### nvim-tree内
- `s`: 垂直分割で開く
- `i`: 水平分割で開く
- `t`: 新しいタブで開く

### LSP（init.lua）
- `gh`: ホバー情報表示
- `gf`: フォーマット
- `gr`: リファレンス表示
- `gd`: 定義へジャンプ
- `gD`: 宣言へジャンプ
- `gi`: 実装へジャンプ
- `gy`: 型定義へジャンプ
- `gn`: リネーム
- `ga`: コードアクション
- `ge`: 診断情報を表示
- `g]`: 次の診断へ
- `g[`: 前の診断へ

### 補完（nvim-cmp）
- `Ctrl+p`: 前の候補
- `Ctrl+n`: 次の候補
- `Ctrl+l`: 補完を開く
- `Ctrl+e`: 補完を閉じる
- `Enter`: 補完を確定

### Git
- `Ctrl+g`: カーソル下の単語をGgrepで検索

### Claude Code
- `<leader>ac` (スペース+ac): Claude Code トグル
- `<leader>af`: Claude Code フォーカス
- `<leader>ar`: Claude Code 再開
- `<leader>aC`: Claude Code 継続
- `<leader>am`: モデル選択
- `<leader>ab`: 現在のバッファを追加
- `<leader>as`: 選択範囲を送信（ビジュアルモード）
- `<leader>aa`: diff承認
- `<leader>ad`: diff拒否

### Supermaven（AI補完）
- `Tab`: 補完を受け入れ
- `Ctrl+e`: 補完をクリア
- `Ctrl+j`: 単語単位で受け入れ


# claude code
- nvimのskill追加
