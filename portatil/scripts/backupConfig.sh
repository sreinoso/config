#!/bin/bash

ORIG="/home/sergio/";
ROOT="/tmp/config";
DEST="$ROOT/portatil";
REPO="git@github.com:sreinoso/config";
mkdir -p $DEST;
cd $DEST;

git init $ROOT;
git pull $REPO;

echo "*~" >> $ROOT/.git/info/exclude;
echo ".*.swp" >> $ROOT/.git/info/exclude;

cp -R $ORIG/.vim* $DEST;
#cp -R $ORIG/.bashrc $DEST;
cp -R $ORIG/.zsh* $DEST;
cp -R $ORIG/.oh-my-zsh $DEST;
cp -R $ORIG/scripts $DEST;
cp -R $ORIG/.conky $DEST;

git add *;
git add .vim*;
git add .bash*;
git add .zsh*;
git add .conky*;
git add .oh-my-zsh;

NOW=$(date +"%d-%m-%Y");
git commit -m $NOW; 
git push $REPO;

rm -rf $DEST/.git;
