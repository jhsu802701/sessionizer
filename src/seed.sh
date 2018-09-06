#!/bin/bash

sh pg-start.sh

echo '--------------------'
echo 'rails db:schema:load'
rails db:schema:load

echo '-------------'
echo 'rails db:seed'
rails db:seed
