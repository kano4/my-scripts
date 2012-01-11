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

cat > Gemfile <<EOF
source :rubygems

gem 'rails', '~> 3.2.0.rc1'

gem 'sqlite3'

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
EOF

bundle install --binstubs --path vendor/bundle
expect -c "
#spawn bundle exec rails new . -T -d postgresql --skip-bundle
spawn bundle exec rails new . -T -d sqlite3 --skip-bundle
expect \"Ynaqdh\"; send \"n\r\"
interact
"
git init

cat > .gitignore <<EOF
/.bundle
/bin
/db/*.sqlite3
/log/*.log
/tmp
/vendor/bundle
EOF

bundle exec rails g rspec:install
