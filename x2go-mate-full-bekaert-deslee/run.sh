CONTAINER_NAME=${PROJECT}
DOCKER_NAME=vpetcu1/x2go-mate-full-${PROJECT}:20.04
RUN_COMMAND="docker run -d --name $CONTAINER_NAME -p 23:22 -p 8080:8080 --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /home/vpetcu1/${PROJECT}:/home/desktop/${PROJECT} --shm-size 2g $DOCKER_NAME"
#RUN_COMMAND="docker run -d -p 23:22 -p 8080:8080 --privileged -v /var/run/docker.sock:/var/run/docker.sock -v /home/vpetcu1/${PROJECT}-data:/home/desktop/${PROJECT}-data --shm-size 2g $DOCKER_NAME"
operation=$1
case $operation in 
	start)
		if [ ! "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
		    if [ "$(docker ps -aq -f status=exited -f name=$CONTAINER_NAME)" ]; then
			# cleanup
			docker container rm $CONTAINER_NAME
		    fi
		    # run your container
		    $RUN_COMMAND
		fi
		;;
	stop)
		docker stop $CONTAINER_NAME
		;;
	pull)
		docker pull $DOCKER_NAME
		;;
	*)
		echo "Must pass one of the args start|stop|pull"
		;;
esac
