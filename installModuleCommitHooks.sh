#!/bin/bash -e
hooksFolder=`git rev-parse --git-dir`/hooks

echo "Installing hook in ${hooksFolder}"
cp -f formatSwiftCode.sh "${hooksFolder}"/pre-commit
