#!/bin/sh

# Ruby 2.0.0
# git clone https://github.com/ruby/ruby.git
# cd ruby
# autoconf
# ./configure --prefix "$HOME/.rsm/versions/ruby-2.0.0-dev" --enable-shared --disable-install-doc
# make
# make install

# Ruby 1.9.3
# wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.bz2
# tar -jxf ruby-1.9.3-p0.tar.bz2
# cd ruby-1.9.3-p0
./configure --prefix "$HOME/.rsm/versions/ruby-1.9.3-p0" --enable-shared --disable-install-doc
make
make install

# Ruby 1.8.7
# wget ftp://ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.7-p352.tar.bz2
# tar -jxf ruby-1.8.7-p352.tar.bz2
# cd ruby-1.8.7-p352
# wget http://redmine.ruby-lang.org/attachments/download/1931/stdout-rouge-fix.patch
# patch -p1 < stdout-rouge-fix.patch
# ./configure --prefix "$HOME/.rsm/versions/ruby-1.8.7-p352" --enable-shared --disable-install-doc
# make
# make install
