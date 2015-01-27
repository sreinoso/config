#!/bin/bash

ORIG="/home/sergio.reinoso/";
ROOT="/tmp/config";
DEST="$ROOT/clase";
REPO="git@github.com:sreinoso/config";
mkdir -p $DEST;
cd $DEST;

git init $ROOT;
git pull $REPO;

echo "*~" >> $ROOT/.git/info/exclude;
echo ".*.swp" >> $ROOT/.git/info/exclude;

cp -R $ORIG/.vim* $DEST;
cp -R $ORIG/.bashrc $DEST;
cp -R $ORIG/scripts $DEST;

git add *;
git add .vim*;
git add .bash*;

NOW=$(date +"%d-%m-%Y");
git commit -m $NOW; 
git push $REPO;

rm -rf $DEST;
