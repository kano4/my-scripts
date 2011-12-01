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

gem 'rails',          '~> 3.1.3'

# db
gem 'pg',             '~> 0.11.0'

# assets
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier',     '~> 1.1.0'
end

gem 'jquery-rails',   '~> 1.0.19'
gem 'haml-rails',     '~> 0.1.0'

group :development, :test do
  gem 'rspec-rails',  '~> 2.7.0'
  gem 'thin',         '~> 1.3.1'
end
" > Gemfile

bundle install --binstubs --path vendor/bundle
expect -c "
spawn bundle exec rails new . -T -d postgresql --skip-bundle
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
" >> .gitignore

bundle exec rails g rspec:install
