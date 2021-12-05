#!/bin/bash

echo "Upload called with params: $@"
artifactId=$1

NEXUS_URL="http://10.248.116.109:8081"
nexusUser="sera_dev"
nexusPassword="seradevuser1"

folder="/home/desktop/sera"
projectVersion="1.0.0"
credentialsId="nexus-user"
groupId="docker-station.com.bmw"
groupIdUrl="docker-station/com/bmw"
repository="maven-releases"
type="${artifactId#*.}"
applicationType="type=application/$type"
file="$folder/$artifactId"
TOKEN="$nexusUser:$nexusPassword"

set +x
curl -u "$TOKEN" -F "maven2.generate-pom=false" -F "maven2.groupId=$groupId" -F "maven2.artifactId=$artifactId" -F "maven2.packaging=$type" -F "version=$projectVersion" -F "maven2.asset1=@$file;$applicationType" -F "maven2.asset1.extension=$type" "$NEXUS_URL/service/rest/v1/components?repository=$repository"
