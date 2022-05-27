#!/bin/bash
fold(){
	operation=$1
    mkdir -p $PROJECT/upload
    echo "zip called with params: $@"
    zip -r -qq $PROJECT/upload/$operation.zip $PROJECT/install/$operation
}

. ./.env
argument=$1
if [ "${argument}" = "all" ]; then
    echo $OPTIONS
    for val in $OPTIONS; do
        fold $val
        sh upload.sh $val.zip
    done
else
	fold $argument
    sh upload.sh $argument.zip
fi
#sh upload-all.sh all
