#!/bin/bash
. ./.env
echo "Upload called with params: $@"
artifactId=$1
mv $PROJECT/upload/$artifactId $artifactId
./drive push -force -verbose -destination docker-station/$PROJECT $artifactId
rm -rf $artifactId
#rm -rf docker-station/$PROJECT