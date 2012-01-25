#!/bin/sh
app=$1

if [ -z $app ]
then
  echo "[Usage] ./lay_rails.sh (AppName)"
  exit 0
elif [ -e $app ]
then
  echo "$app is already existing"
  exit 0
fi

echo "Creating ${app}"
mkdir $app
cd $app

cat > Gemfile <<EOF
source :rubygems

gem 'rails'

gem 'sqlite3'

gem 'haml-rails'
gem 'jquery-rails'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'thin'
end
EOF

bundle install --binstubs --path vendor/bundle
expect -c "
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
