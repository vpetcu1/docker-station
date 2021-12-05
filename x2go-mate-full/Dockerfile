FROM vpetcu1/x2go-mate-base:20.04
MAINTAINER Vasilica Petcu <vpetcu1@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

USER root

ARG PROJECT

# install x2go and Ubuntu Mate
RUN apt-get update && apt-get install -y ubuntu-mate-desktop
    
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
ARG TEAMS=teams_1.4.00.26453_amd64.deb
RUN wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/${TEAMS} -P /
RUN dpkg -i ${TEAMS}

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

#install snowflake
ARG SNOWFLAKE_VERSION=1.0.4
RUN wget https://github.com/subhra74/snowflake/releases/download/v${SNOWFLAKE_VERSION}/snowflake-${SNOWFLAKE_VERSION}-setup-amd64.deb -P /
RUN dpkg -i snowflake-${SNOWFLAKE_VERSION}-setup-amd64.deb

#upgrade
RUN apt-get upgrade -y

#clean up
RUN rm -rf /tmp/*

RUN apt-get -y autoclean && apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

COPY ["*.desktop", "/home/$REMOTE_USER/Desktop/"]
RUN chmod +x /home/$REMOTE_USER/Desktop/*.desktop

COPY ["*.sh", "/"]
RUN chmod +x /*.sh

RUN chown $REMOTE_USER:$REMOTE_USER -R /home/$REMOTE_USER/

RUN cp /entrypoint.sh x2go-mate-${PROJECT}-entrypoint.sh
RUN sh /x2go-mate-${PROJECT}-entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/start-supervisor.sh"]
