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

echo upload called with folder=$folder and option=$option

. ./$folder/.env
mv ./backup/$folder/upload/$option $option
./drive push -force -verbose -destination docker-station/$PROJECT $option
rm -rf $option
#rm -rf docker-station/$PROJECT