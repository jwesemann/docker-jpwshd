#!/bin/sh

gitrepo=`basename $PWD`
echo $gitrepo

git remote -v

git remote remove origin
git remote add origin git@github.com:jwesemann/${gitrepo}.git

git remote remove gogs
git remote add gogs ssh://git@git.weseit.de:3002/jwesemann/${gitrepo}.git


git push --set-upstream origin main
#git branch --set-upstream-to=origin/main

git fetch gogs

git remote -v

git branch -a -vv

echo "Press return-key"
read
git log --oneline --graph

