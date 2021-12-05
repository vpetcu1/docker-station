#!/bin/bash
executeOperation(){
	operation=$1
	folder="/home/desktop/${PROJECT}/install"
	mkdir -p $folder
	cd /
	./download.sh $operation.zip
	mv /$operation.zip $folder
	cd $folder 
	rm -rf $operation
	jar -xvf $operation.zip
}

options="${PROJECT}-dxp software liferay-developer-studio eclipse-workspace"
argument=$1
./drive list
if [ "${argument}" = "all" ] || [ -z "$argument" ]; then
	for val in $options; do
		executeOperation $val
	done
else
	executeOperation $argument
fi
