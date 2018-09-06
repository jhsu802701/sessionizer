#!/bin/bash

# Run this script before entering "git add" and "git commit".

sh test_app.sh

sh outline-short.sh

echo '----------'
echo 'git status'
git status
