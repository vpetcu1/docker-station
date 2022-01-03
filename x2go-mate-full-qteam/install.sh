#!/bin/bash
unfold(){
	operation=$1
	folder=$2
    echo "unzip called with params: $@"
    unzip -qq $folder/$operation.zip -d .
}

. ./.env
folder="$PROJECT/install"
argument=$1
if [ "${argument}" = "all" ]; then
    sh download-all.sh all $folder
    echo $OPTIONS
    for val in $OPTIONS; do
        unfold $val $folder
    done
else
    sh download-all.sh $argument $folder
    unfold $argument $folder
fi

rm -rf docker-station