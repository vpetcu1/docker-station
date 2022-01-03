#!/bin/bash
unfold(){
	operation=$1
	folder=$2
    echo "unzip called with params: $@"
    unzip -qq $folder/$operation.zip -d .
}

. ./.env
folder="$PROJECT/install"
sh download-all.sh all $folder
echo $OPTIONS
for val in $OPTIONS; do
    unfold $val $folder
done
rm -rf docker-station