FROM vpetcu1/x2go-mate-full:20.04
MAINTAINER Vasilica Petcu <vpetcu1@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

USER root

#install ABATech20
RUN mkdir -p /work/ABATech20/tools

#install openjdk-8-jdk
RUN apt-get update && apt-get install openjdk-8-jdk -y

#install openjdk-11-jdk
RUN apt-get update && apt-get install openjdk-11-jdk -y

#install vscode
RUN wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
RUN apt-get update && apt-get install code -y

#install vscode extensions
USER $REMOTE_USER
RUN code --install-extension jmMeessen.jenkins-declarative-support
RUN code --install-extension ms-vscode-remote.remote-ssh
RUN code --install-extension ms-vscode-remote.remote-ssh-edit

USER root

#install teams
RUN wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.3.00.30857_amd64.deb -P /
RUN dpkg -i teams_1.3.00.30857_amd64.deb

#install google-chrome
COPY ./install-chrome.sh /
RUN chmod +x /install-chrome.sh 
RUN /install-chrome.sh

#install postman
COPY ./install-postman.sh /
RUN chmod +x /install-postman.sh 
RUN /install-postman.sh

#install docker
COPY ./install-docker.sh /
RUN chmod +x /install-docker.sh 
RUN /install-docker.sh

#install git
RUN apt-get install git -y

#install mate-tweak
RUN apt-get install mate-tweak -y

#install dos2unix
RUN apt-get install dos2unix -y

#install sshpass
RUN apt-get install sshpass -y

#install libgomp1
RUN apt-get install libgomp1 -y

#install libgomp1
RUN apt-get install sudo -y

#install linux-image-generic
RUN apt-get install linux-image-generic -y

#upgrade
RUN apt-get upgrade -y

COPY ["*.sh", "/"]
RUN chmod +x /*.sh

COPY ["*.desktop", "/home/$REMOTE_USER/Desktop/"]
RUN chmod +x /home/$REMOTE_USER/Desktop/*.desktop

#install apache-maven
RUN ./nexus-download.sh apache-maven.zip
RUN cd /work/ABATech20/tools && jar -xvf /apache-maven.zip

#install eclipse
RUN ./nexus-download.sh eclipse.zip
RUN cd /work/ABATech20/tools && jar -xvf /eclipse.zip

#tune eclipse
COPY ./lombok.jar /work/ABATech20/tools/eclipse/
COPY ./eclipse.ini /work/ABATech20/tools/eclipse/

RUN ./tune-eclipse.sh 

#install on eclipse: jrebel, Payara Tools, Eclipse Web Developer Tools

#install payara
RUN ./nexus-download.sh payara.zip
RUN cd /work/ABATech20/tools && jar -xvf /payara.zip

#install sqldeveloper
RUN ./nexus-download.sh sqldeveloper.zip
RUN cd /work/ABATech20/tools && jar -xvf /sqldeveloper.zip

#install Java
RUN ./nexus-download.sh Java.zip
RUN cd /work/ABATech20/tools && jar -xvf /Java.zip

#install domains
RUN ./nexus-download.sh domains.zip
RUN cd /work/ABATech20 && jar -xvf /domains.zip

#install .sqldeveloper.zip
RUN ./nexus-download.sh .sqldeveloper.zip
RUN cd /home/$REMOTE_USER/ && jar -xvf /.sqldeveloper.zip

#install .postman.zip
RUN ./nexus-download.sh .postman.zip
RUN cd /home/$REMOTE_USER/ && jar -xvf /.postman.zip

#install google-chrome.zip
RUN ./nexus-download.sh google-chrome.zip
RUN cd /home/$REMOTE_USER/.config && jar -xvf /google-chrome.zip

#install snowflake-ssh.zip
RUN ./nexus-download.sh snowflake-ssh.zip
RUN cd /home/$REMOTE_USER/ && jar -xvf /snowflake-ssh.zip

#install bin.zip
RUN ./nexus-download.sh bin.zip
RUN cd /work/ABATech20 && jar -xvf /bin.zip

#install sera.epf
RUN ./nexus-download.sh /tmp/sera.epf
RUN mv -f /tmp/sera.epf /work/ABATech20/sera.epf

#install SERA_Formatter.xml
RUN ./nexus-download.sh /tmp/SERA_Formatter.xml
RUN mv -f /tmp/SERA_Formatter.xml /work/ABATech20/SERA_Formatter.xml

#install SERA_Clean_Up.xml
RUN ./nexus-download.sh /tmp/SERA_Clean_Up.xml
RUN mv -f /tmp/SERA_Clean_Up.xml /work/ABATech20/SERA_Clean_Up.xml

#copy startEclipse
COPY ["startEclipse.sh", "/home/$REMOTE_USER/Desktop"]
RUN chmod +x /home/$REMOTE_USER/Desktop/startEclipse.sh

#copy sqldeveloper.sh
COPY ["sqldeveloper.sh", "/home/$REMOTE_USER/Desktop"]
RUN chmod +x /home/$REMOTE_USER/Desktop/sqldeveloper.sh

#copy .profile
COPY [".profile", "/home/$REMOTE_USER"]

#copy known_hosts
RUN mkdir -p /home/$REMOTE_USER/.ssh
COPY ["known_hosts", "/home/$REMOTE_USER/.ssh"]

COPY ["cloud.pem", "/home/$REMOTE_USER/"]

#install barracuda
COPY ["barracudavpn_5.0.2.7_amd64.deb", "/home/$REMOTE_USER/"]
RUN dpkg -i /home/$REMOTE_USER/barracudavpn_5.0.2.7_amd64.deb

#install snowflake
COPY ["snowflake-1.0.4-setup-amd64.deb", "/home/$REMOTE_USER/"]
RUN dpkg -i /home/$REMOTE_USER/snowflake-1.0.4-setup-amd64.deb

#install barracudavpn.zip
RUN ./nexus-download.sh barracudavpn.zip
RUN cd /etc/ && jar -xvf /barracudavpn.zip && chmod 777 /etc/barracudavpn
RUN chmod 777 -R /etc/barracudavpn

#permissions 
RUN chmod 777 -R /work
RUN chmod 400 /home/$REMOTE_USER/cloud.pem


#clean up
RUN rm -rf /tmp/*
RUN rm -rf /*.zip

RUN apt-get -y autoclean && apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

RUN chown $REMOTE_USER:$REMOTE_USER -R /home/$REMOTE_USER/

RUN sh /x2go-mate-full-sera-entrypoint.sh
EXPOSE 22
ENTRYPOINT ["/start-supervisor.sh"]
