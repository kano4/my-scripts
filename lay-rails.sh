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
gem 'pjax-rails'

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

if [ -e ~/.ruby-bundle ]; then
  echo "Copy vendor/bundle"
  mkdir -p vendor/bundle
  cp -r ~/.ruby-bundle/* vendor/bundle/
fi

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

echo "Install RSpec"
bundle exec rails g rspec:install

echo "Set PJAX"
echo "//= require pjax" >> app/assets/javascripts/application.js

cat > app/views/layouts/application.html.haml <<EOF
!!!
%html
  %head
    %title $app
    = stylesheet_link_tag    "application", :media => "all"
    = javascript_include_tag "application"
    = csrf_meta_tags
  %body
    %h1 $app
    %div{"data-pjax-container" => "true"}
      = yield
EOF

rm app/views/layouts/application.html.erb
