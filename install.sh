#!/bin/bash

shopt -s extglob

staging=$(mktemp -d)

# Installation Directory
installDir=/usr/local/share/cons3rt-utils

mkdir -p $installDir

binSrc=$installDir/bin
binDest=/usr/local/bin

curl -L0k -o $staging/cons3rt-utils.tar.gz https://github.com/oconnormi/cons3rt-utils/archive/master.tar.gz
tar --strip-components=1 -C $installDir -xzvf $staging/cons3rt-utils.tar.gz

find $installDir -type d -exec chmod +x {} \;

ln -s $binSrc/+([^.]) $binDest

rm -rf $staging
