#!/bin/sh
app=$1

if [ -z $app ]
then
  echo "[usage] ./lay_rails.sh (AppName)"
  exit 0
elif [ -e $app ]
then
  echo "$app is already existing"
  exit 0
fi

echo "Start Creating ${app}"
mkdir $app
cd $app

echo "install rails"

# Gemfile
echo "source :rubygems

gem 'rails'

# db
#gem 'pg'
gem 'sqlite3'

# assets
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'haml-rails'

group :development, :test do
  gem 'rspec-rails'
  gem 'thin'
end
" > Gemfile

bundle install --binstubs --path vendor/bundle
expect -c "
#spawn bundle exec rails new . -T -d postgresql --skip-bundle
spawn bundle exec rails new . -T -d sqlite3 --skip-bundle
expect \"Ynaqdh\"; send \"n\r\"
interact
"
git init

# .gitignore
echo "
/.bundle
/bin
/db/*.sqlite3
/log/*.log
/tmp
/vendor/bundle
" > .gitignore

bundle exec rails g rspec:install
