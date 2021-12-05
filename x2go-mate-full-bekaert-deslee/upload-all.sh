#!/bin/bash
executeOperation(){
	operation=$1
	folderInstall="/home/desktop/${PROJECT}/install/"
	
	case $operation in 
		${PROJECT}-dxp.zip)
			cd $folderInstall
			zip -r $operation.zip $operation/
			;;
		liferay-developer-studio.zip)
			cd $folderInstall
			zip -r $operation liferay-developer-studio/
			;;
		software.zip)
			cd $folderInstall
			zip -r $operation software/
			;;
		eclipse-workspace.zip)
			cd $folderInstall
			zip -r $operation eclipse-workspace/
			;;
		*)
			echo "Must pass one of the args ${PROJECT}-dxp software liferay-developer-studio eclipse-workspace"
			;;
	esac
	cd /
	pwd
	./upload.sh $operation $folderInstall
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
chown desktop:desktop -R $folderInstall