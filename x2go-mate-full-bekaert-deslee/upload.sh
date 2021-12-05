#!/bin/bash

echo "Upload called with params: $@"
artifactId=$1
folder=$2
parentFolderId=1u_hn0JjiEoO-ThkSaL_nHL9vk6SuBpCe
cd /
./drive upload -f $folder$artifactId.zip -p $parentFolderId