#!/bin/bash
executeOperation(){
	operation=$1
	folder=$2
	mkdir -p $folder
	sh download.sh $operation.zip
	mv $operation.zip $folder
}

. ./.env
argument=$1
folder=$2
if [ -z "$folder" ]; then
	folder="/home/desktop/${PROJECT}/install"
fi
echo $OPTIONS
if [ "${argument}" = "all" ] || [ -z "$argument" ]; then
	for val in $OPTIONS; do
		executeOperation $val $folder
	done
else
	executeOperation $argument $folder
fi

