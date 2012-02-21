#!/bin/sh
app=$1

if [ -z $app ]
then
  echo "[usage] ./clockwork-init.sh (AppName)"
  exit 0
elif [ -e $app ]
then
  echo "$app is already existing"
  exit 0
fi

# mkdir
echo "Create ${app}"
mkdir $app
cd $app
git init

# Gemfile
echo "source :rubygems

gem 'clockwork'
" > Gemfile

# clock.rb
echo "require 'rubygems'
require 'clockwork'
include Clockwork

every(10.minutes, 'job_name')
" > clock.rb

# .gitignore
echo "/.bundle" > .gitignore

# Procfile
echo "clock: bundle exec clockwork clock.rb" > Procfile

cat <<EOF
What's next:
  $ bundle install

Customize clock.rb
  $ bundle exec clockwork clock.rb
  $ heroku create $app --stack cedar
  $ git push heroku master
  $ heroku scale clock=1
EOF
