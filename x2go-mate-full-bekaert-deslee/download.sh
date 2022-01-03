#!/bin/bash
. ./.env
echo "Download called with params: $@"
artifactId=$1
./drive pull -ignore-checksum=false -quiet docker-station/$PROJECT/$artifactId
mv docker-station/$PROJECT/$artifactId $artifactId
rm -rf docker-station/$PROJECT