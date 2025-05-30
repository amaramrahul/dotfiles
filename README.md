dotfiles
========

Get dotfiles
------------
```
$ cd ~
$ git clone https://github.com/amaramrahul/dotfiles.git
```

Setup vim (with plugin dependencies)
------------------------------------
```
$ sudo apt-get install exuberant-ctags # dependency for tagbar plugin

$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ ln -s dotfiles/vimrc ~/.vimrc
$ ln -s dotfiles/gvimrc ~/.gvimrc
$ ln -s dotfiles/tmux.conf ~/.tmux.conf
$ vim +PluginInstall +qall
```

Configure UltiSnips snippets
----------------------------
```
$ ln -s dotfiles/UltiSnips ~/.vim/UltiSnips
```
