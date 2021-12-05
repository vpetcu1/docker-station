#!/bin/bash

echo "Download called with params: $@"
artifactId=$1

NEXUS_URL="http://10.248.116.109:8081"
nexusUser="sera_dev"
nexusPassword="seradevuser1"

projectVersion="1.0.0"
credentialsId="nexus-user"
groupId="docker-station.com.bmw"
groupIdUrl="docker-station/com/bmw"
repository="maven-releases"
type="${artifactId#*.}"
applicationType="type=application/$type"
file="$artifactId"
TOKEN="$nexusUser:$nexusPassword"


set +x
curl -u "$TOKEN" -X GET "$NEXUS_URL/repository/$repository/$groupIdUrl/$artifactId/$projectVersion/$artifactId-$projectVersion.$type" --output $file
