#!/bin/bash
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

echo download called with folder=$folder and option=$option
. ./$folder/.env

./drive pull -ignore-checksum=false -quiet docker-station/$folder/$option
mkdir -p backup/download/$folder/
mv docker-station/$folder/$option backup/download/$folder/$option
