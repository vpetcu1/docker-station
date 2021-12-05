#!/bin/bash

echo "Download called with params: $@"
artifactId=$1

grepResult=$(./drive list | grep -w $artifactId | grep -o '^\S*')
./drive download -i $grepResult --force
