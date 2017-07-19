#!/bin/sh

## Configure git

git config --global user.name slevy316
git config --global user.email samuellevy@hotmail.co.uk

## Change the "origin" remote URL and push
git remote set-url origin git@github.com:slevy316/handouts.git

## Set upstream
git remote add upstream https://github.com/sesync-ci/handouts
git pull upstream master
