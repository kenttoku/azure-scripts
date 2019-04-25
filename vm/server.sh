#!/bin/bash

directory=$1
user_email=$2
user_name=$3

## Setup linux environment
curl https://raw.githubusercontent.com/kenttoku/revature-p0/master/linux-setup.sh | bash

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

## Setup git project structure
curl https://raw.githubusercontent.com/kenttoku/revature-p0/master/git-node-project.sh | bash -s "$directory" "$user_email" "$user_name"

## Setup Server
cd "$directory" || exit 1
curl https://raw.githubusercontent.com/kenttoku/azure-scripts/master/vm/server.js > server.js
node server.js