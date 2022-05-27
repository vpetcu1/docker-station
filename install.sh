#!/bin/bash
unfold(){
	folder=$1
	operation=$2
    echo "unzip called with params: $@"
    unzip -qq backup/download/$folder/$operation.zip -d $folder/
    rm -rf backup/download/$folder/*
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

echo install called with options folder=$folder and option=$option
. ./$folder/.env

#folder="$folder/$PROJECT"
if [ "${option}" = "all" ]; then
    echo $OPTIONS
    for val in $OPTIONS; do
        sh download.sh -f=$folder -o=$val.zip
        unfold $folder $val 
    done
else
    sh download.sh -f=$folder -o=$option.zip
    unfold $folder $option
fi

