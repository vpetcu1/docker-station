#!/bin/bash
fold(){
	folder=$1
    operation=$2
    mkdir -p backup/$folder/upload
    echo "zip called with params: $@"
    zip --symlinks -r -qq backup/$folder/upload/$operation.zip  $folder/$operation/
}

folder=""
option="all"
for i in "$@"; do
  case $i in
    -f=*|--folder=*)
      folder="${i#*=}"
      shift # past argument=value
      ;;
    -o=*|--option=*)
      option="${i#*=}"
      shift # past argument=value
      ;;
    -*|--*)
      echo "Unknown option $i"
      exit 1
      ;;
    *)
      ;;
  esac
done

if [ "${folder}" = "" ]; then
    echo "Unknown option $i"
    exit 1
fi

echo folder=$folder and option=$option
. ./$folder/.env
if [ "${option}" = "all" ]; then
    echo $OPTIONS
    for val in $OPTIONS; do
        fold $folder $val
        sh upload.sh -f=$folder -o=$val.zip
    done
else
    fold $folder $option
    sh upload.sh -f=$folder -o=$option.zip
fi
#sh upload-all.sh all
