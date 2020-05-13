# git
git config --global user.name  "********"
git config --global user.email "********"

# vim
- neobundle入れる
-- curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
-- ./install.sh
- .vimrcへのリンク
-- ln -s ~/dotfiles/.vimrc ~/
- vim開いて:neoBundleInstall

# tmux
- 2.6
- .tmux.confへのリンク
-- ln -s ~/dotfiles/.tmux.conf ~/

# go
- 1.10.3
- aptなりyumで入れた後の環境変数
-- cat ~/dotfiles/.bashrc_diff >> ~/.bashrc
- mkdir $HOME/go

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

# terminal
- beepを消す
-- sudo vim /etc/inputrc
-- set bell-style noneの行のコメントアウト解除

あとはgithubに鍵を入れる
スプレッドシートのデータをS3にcsvで退避
