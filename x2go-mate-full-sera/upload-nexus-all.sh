#!/bin/bash
executeOperation(){
	operation=$1
	
	case $operation in 
		apache-maven.zip)
			cd /work/ABATech20/tools
			zip -r $operation apache-maven/
			mv $operation /home/desktop/sera/
			;;
		eclipse.zip)
			cd /work/ABATech20/tools
			zip -r $operation eclipse/
			mv $operation /home/desktop/sera/
			;;
		payara.zip)
			cd /work/ABATech20/tools
			zip -r $operation payara/
			mv $operation /home/desktop/sera/
			;;
		Java.zip)
			cd /work/ABATech20/tools
			zip -r $operation Java/
			mv $operation /home/desktop/sera/
			;;
		sqldeveloper.zip)
			cd /work/ABATech20/tools
			zip -r $operation sqldeveloper/
			mv $operation /home/desktop/sera/
			;;
		domains.zip)
			cd /work/ABATech20
			zip -r $operation domains/
			mv $operation /home/desktop/sera/
			;;
		bin.zip)
			cd /work/ABATech20
			zip -r $operation bin/
			mv $operation /home/desktop/sera/
			;;
		.sqldeveloper.zip)
			cd /home/desktop/
			zip -r $operation .sqldeveloper/
			mv $operation /home/desktop/sera/
			;;
		.postman.zip)
			cd /home/desktop/
			zip -r $operation .postman/
			mv $operation /home/desktop/sera/
			;;
		snowflake-ssh.zip)
			cd /home/desktop/
			zip -r $operation snowflake-ssh/
			mv $operation /home/desktop/sera/
			;;
		google-chrome.zip)
			cd /home/desktop/.config
			zip -r $operation google-chrome/
			mv $operation /home/desktop/sera/
			;;
		barracudavpn.zip)
			cd /etc
			zip -r $operation barracudavpn/
			mv $operation /home/desktop/sera/
			;;
		sera.epf)
			;;
		SERA_Clean_Up.xml)
			;;
		SERA_Formatter.xml)
			;;
		*)
			echo "Must pass one of the args .sqldeveloper.zip|apache-maven.zip|pull"
			;;
	esac
	cd /
	pwd
	./nexus-upload.sh $operation
}

options="apache-maven.zip eclipse.zip payara.zip Java.zip sqldeveloper.zip domains.zip bin.zip .sqldeveloper.zip .postman.zip snowflake-ssh.zip google-chrome.zip barracudavpn.zip sera.epf SERA_Clean_Up.xml SERA_Formatter.xml"
argument=$1
if [ "${argument}" = "all" ]; then
	for val in $options; do
		executeOperation $val
	done
else
	executeOperation $argument
fi
