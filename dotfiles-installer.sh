#!/bin/sh

INSTALL_DIR=$HOME

cd $INSTALL_DIR
if [ ! -e $INSTALL_DIR/.dotfiles ]; then
  echo "git clone kano4/dotfiles"
  git clone git@github.com:kano4/dotfiles $INSTALL_DIR/.dotfiles
else
  echo "git pull kano4/dotfiles"
  cd $INSTALL_DIR/.dotfiles
  git pull
  cd $INSTALL_DIR
fi

if [ ! -e $INSTALL_DIR/.vim/bundle/vundle ]; then
  echo "git clone gmarik/vundle"
  git clone git@github.com/gmarik/vundle.git $INSTALL_DIR/.vim/bundle/vundle
fi

DOTFILES=".gitconfig .vimrc .zshrc .screenrc .gemrc .railsrc"
for DOTFILE in $DOTFILES; do
  echo "Make symbolic link : $DOTFILE"
  if [ -e $INSTALL_DIR/$DOTFILE ]; then
    rm $INSTALL_DIR/$DOTFILE
  fi
  ln -s $INSTALL_DIR/.dotfiles/$DOTFILE $INSTALL_DIR
done

echo "Vundle install"
vim -u .vimrc +BundleInstall +q +q

if [ ! -e .SKK-JISYO.L ]; then
  echo "Download SKK-JISYO.L"
  wget http://openlab.ring.gr.jp/skk/dic/SKK-JISYO.L.gz
  gzip -dc SKK-JISYO.L.gz > .SKK-JISYO.L
  rm $INSTALL_DIR/SKK-JISYO.L.gz
fi

echo "make vimproc"
cd $INSTALL_DIR/.vim/bundle/vimproc/
make -f make_gcc.mak
