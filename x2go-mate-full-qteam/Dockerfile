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
