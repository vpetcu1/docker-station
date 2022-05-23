FROM vpetcu1/x2go-mate-full:20.04
MAINTAINER Vasilica Petcu <vpetcu1@gmail.com>
ENV DEBIAN_FRONTEND noninteractive

USER root

ARG PROJECT
#install ${PROJECT}
RUN mkdir -p /work/${PROJECT}/tools

COPY ["*.sh", "/"]
RUN chmod +x /*.sh

#copy .profile
COPY [".profile", "/home/$REMOTE_USER"]
#copy .env
COPY [".env", "/home/$REMOTE_USER"]

COPY ["drive", "/"]
RUN chmod +x /drive

RUN apt-get update
RUN apt-get upgrade -y

#RUN cd /home/$REMOTE_USER/$PROJECT/install
#RUN wget https://downloads.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}}-bin.tar.gz -P /
#RUN tar -xvzf apache-maven-${MAVEN_VERSION}-bin.tar.gz

# Declare constants
ENV NODE_VERSION 12.22.0

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install pre-reqs
RUN apt-get update
RUN apt-get -y install curl build-essential

USER $REMOTE_USER

# Install NVM
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

ENV NVM_DIR="/home/$REMOTE_USER/$PROJECT/install/.nvm"

# Install NODE
RUN source ~/.nvm/nvm.sh; \
    nvm install $NODE_VERSION; \
    nvm use --delete-prefix $NODE_VERSION;
    
USER root

#clean up
RUN rm -rf /tmp/*
RUN rm -rf /*.zip

RUN apt-get -y autoclean && apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

RUN chown $REMOTE_USER:$REMOTE_USER -R /home/$REMOTE_USER/

RUN cp /entrypoint.sh x2go-mate-${PROJECT}-entrypoint.sh
RUN sh /x2go-mate-${PROJECT}-entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/start-supervisor.sh"]
