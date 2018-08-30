#!/bin/bash

echo '--------------'
echo 'bundle install'
bundle install

echo '----------------'
echo 'rails db:migrate'
rails db:migrate

echo '-----------------------------------'
echo 'bin/rails db:migrate RAILS_ENV=test'
bin/rails db:migrate RAILS_ENV=test

echo '----------------------'
echo 'bundle exec rspec spec'
bundle exec rspec spec
