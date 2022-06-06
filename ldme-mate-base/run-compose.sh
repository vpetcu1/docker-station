operation=$1
case $operation in 
	start)
        if [ ! -d ${PROJECT} ]; then
            mkdir -p ${PROJECT}
        fi
        COMPOSE_PROJECT_NAME=${PROJECT} docker-compose up --remove-orphans &
		;;
	stop)
		docker-compose down
		;;
	*)
		echo "Must pass one of the args start|stop"
		;;
esac

