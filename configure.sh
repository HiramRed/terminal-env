#! /bin/sh
cp .vimrc .tmux.conf ~
cp autoload/plug.vim ~/.vim/autoload
cp init.vim cocmap.vim ~/.config/nvim
echo 'done'
