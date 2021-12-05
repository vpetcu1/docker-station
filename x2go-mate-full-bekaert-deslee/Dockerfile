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

COPY ["drive", "/"]
RUN chmod +x /drive

RUN apt-get update
RUN apt-get upgrade -y

#install MySql Workbench
ARG MYSQL_VERSION=8.0.27
RUN wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community_$MYSQL_VERSION-1ubuntu20.04_amd64.deb -P /
RUN apt-get install ./mysql-workbench-community_$MYSQL_VERSION-1ubuntu20.04_amd64.deb -y
RUN wget https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-dbgsym_$MYSQL_VERSION-1ubuntu20.04_amd64.deb -P /
RUN apt-get install ./mysql-workbench-community-dbgsym_$MYSQL_VERSION-1ubuntu20.04_amd64.deb -y


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
