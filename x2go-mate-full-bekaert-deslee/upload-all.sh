#!/bin/bash
executeOperation(){
	operation=$1
	sh upload.sh $operation.zip
}

. ./.env
argument=$1
if [ "${argument}" = "all" ]; then
	for val in $OPTIONS; do
		executeOperation $val
	done
else
	executeOperation $argument
fi

