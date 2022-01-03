operation=$1
case $operation in 
	start)
        if [ ! -f "mysql.zip" ]; then
            ./download.sh mysql.zip
        fi
        if [ ! -d "mysql" ]; then
            unzip mysql.zip
        fi
        if [ ! -d ${PROJECT} ]; then
            install.sh            
        fi
        sudo COMPOSE_PROJECT_NAME=${PROJECT} docker-compose up --remove-orphans
		;;
	stop)
		sudo docker-compose down
		;;
	*)
		echo "Must pass one of the args start|stop"
		;;
esac

