operation=$1
case $operation in 
	start)
        sudo ./drive list
        if [ ! -f "mysql.zip" ]; then
            ./download.sh mysql.zip
        fi
        if [ ! -d "mysql" ]; then
            unzip mysql.zip
        fi
        if [ ! -d "bekaert-deslee" ]; then
            mkdir bekaert- deslee
        fi
        sudo COMPOSE_PROJECT_NAME=${PROJECT} docker-compose up
		;;
	stop)
		sudo docker-compose down
		;;
	*)
		echo "Must pass one of the args start|stop"
		;;
esac

