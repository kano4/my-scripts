#!/bin/sh

# If you clone ruby from https://github.com/ruby/ruby.git , running autoconf command is required.
# git clone https://github.com/ruby/ruby.git
# cd ruby
# autoconf
# ./configure --prefix "$HOME/.rsm/versions/ruby-2.0.0-dev" --enable-shared --disable-install-doc

# wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.bz2
# tar -jxf ruby-1.9.3-p0.tar.bz2
./configure --prefix "$HOME/.rsm/versions/ruby-1.9.3-p0" --enable-shared --disable-install-doc
make
make install
