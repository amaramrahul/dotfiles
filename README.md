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
$ apt-get install exuberant-ctags # dependency for tagbar plugin

$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
$ ln -s dotfiles/vimrc ~/.vimrc
$ vim +PluginInstall +qall
```

Configure UltiSnips snippets
----------------------------
```
$ ln -s dotfiles/UltiSnips ~/.vim/UltiSnips
```
