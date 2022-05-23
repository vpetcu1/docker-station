FROM ubuntu:20.04
MAINTAINER Vasilica Petcu <vpetcu1@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

USER root

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update -y -qq && \
    apt-get dist-upgrade -y && \
    apt-get install locales software-properties-common -y && \
    locale-gen en_US.UTF-8 && \
    # install supervisor and openssh
    add-apt-repository universe

RUN apt-get update
RUN apt-get install -y supervisor openssh-server

#install zip 
RUN apt-get install -y zip unzip
#install ping
RUN apt-get install -y iputils-ping
#install telnet
RUN apt-get install -y telnet

#install openjdk-8-jdk
RUN apt-get update && apt-get install openjdk-8-jdk -y

#install openjdk-11-jdk
RUN apt-get update && apt-get install openjdk-11-jdk -y

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

USER $REMOTE_USER

ENV REMOTE_USER=desktop
ENV REMOTE_PASSWORD=password

#install set_user_pw
COPY ./set_user_pw.sh /
RUN chmod +x /set_user_pw.sh 
RUN /set_user_pw.sh

#install docker
COPY ./install-docker.sh /
RUN chmod +x /install-docker.sh 
RUN /install-docker.sh

ENV NODE_VERSION lts/fermium

USER $REMOTE_USER
# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

USER root 

# sshd stuff
RUN mkdir -p /var/run/sshd && \
    sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config && \
# fix so resolvconf can be configured
   echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections && \
# create needed folders
    mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix && \
    mkdir -p /var/run/dbus


#clean up
RUN rm -rf /tmp/*
RUN apt-get remove -y apport && apt autoremove -y
RUN apt-get autoclean && apt-get autoremove
RUN rm -rf /var/lib/apt/lists/*


#copy necessary to configure workingstation
COPY ["*.conf", "/etc/supervisor/conf.d/"]
COPY ["*.sh", "/"]

RUN chmod +x /*.sh

RUN cp /entrypoint.sh x2go-mate-${PROJECT}-entrypoint.sh
RUN sh /x2go-mate-${PROJECT}-entrypoint.sh
EXPOSE 22
ENTRYPOINT ["/start-supervisor.sh"]
