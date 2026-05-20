dotfiles
========

Get dotfiles
------------

```
cd ~
git clone https://github.com/amaramrahul/dotfiles.git
```

Setup vim (with plugin dependencies) and Ultisnips snippets
-----------------------------------------------------------

```
sudo apt install universal-ctags # dependency for tagbar plugin

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -s dotfiles/vimrc ~/.vimrc
ln -s dotfiles/gvimrc ~/.gvimrc
vim +PluginInstall +qall
```

```
ln -s ../dotfiles/UltiSnips ~/.vim/UltiSnips
```

Set up vscode and cursor
------------------------

```
ln -s ../../../dotfiles/vscode/settings.json ~/.config/Code/User/settings.json
ln -s ../../../dotfiles/vscode/keybindings.json ~/.config/Code/User/keybindings.json
```

```
ln -s ../../../dotfiles/cursor/settings.json ~/.config/Cursor/User/settings.json
ln -s ../../../dotfiles/cursor/keybindings.json ~/.config/Cursor/User/keybindings.json
```


Setup other configurations
--------------------------

```
ln -s dotfiles/tmux.conf ~/.tmux.conf
```
