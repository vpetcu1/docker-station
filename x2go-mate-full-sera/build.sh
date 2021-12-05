#!/bin/bash
tag="";
imageName="vpetcu1/x2go-mate-full-sera"
if [ -z "$1" ]
    then
        echo "No tag specified"
        echo "Ex: ./build.sh 20.04 will generate a docker image with tag 20.04 $imageName:20.04"
    else
        tag=":$1"
fi
echo $tag
sudo docker build --no-cache -t $imageName$tag .
sudo docker login
sudo docker push $imageName$tag