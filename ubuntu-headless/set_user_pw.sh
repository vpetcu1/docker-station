#!/bin/bash

if [ -f /.user_pw_set ]; then
	echo  "REMOTE_USER password already set!"
	exit 0
fi

useradd $REMOTE_USER -m -p '*' -d /home/$REMOTE_USER -s /bin/bash
adduser $REMOTE_USER sudo

echo "=> Setting a password to the $REMOTE_USER user"
echo "$REMOTE_USER:$REMOTE_PASSWORD" | chpasswd

echo "=> Done!"
echo "$REMOTE_USER" >> /.user_pw_set

echo "========================================================================"
echo " $REMOTE_USER password : $REMOTE_PASSWORD "
echo "use this to connect to the x2go server from your x2go client!"
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
exit 0