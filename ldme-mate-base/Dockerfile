FROM linuxmintd/lmde6-amd64

ENV DEBIAN_FRONTEND=noninteractive
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

ADD entrypoint.sh /entrypoint.sh

#Generic packages
RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common build-essential libpython3-dev fonts-liberation xdg-utils dbus libdbus-1-dev dbus-x11 nano pulseaudio curl wget libxext-dev sudo gpg-agent libxrender-dev libxtst-dev supervisor htop apt-transport-https wget openssh-server fuse libfuse2
    
#Yarn and Node
#RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - \
#    && wget -qO- https://deb.nodesource.com/setup_12.x | -E bash - \
#    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
#	&& apt-get install --no-install-recommends -y nodejs yarn 

#JDK
#RUN apt-get install -y openjdk-11-jdk 
	
#VSCode
#RUN apt-get clean \
#	&& wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | apt-key add - \
#    && apt-get update && apt-get install --no-install-recommends -y software-properties-common && add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
#    && apt-get update \
#    && apt-get install --no-install-recommends -y code 

#Git and Git-Flow
RUN apt-get install --no-install-recommends -y git libu2f-udev apt-utils

#Chrome
RUN curl -fSL "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -o chrome.deb \
	&& dpkg -i chrome.deb \
	&& rm chrome.deb

#NoMachine
RUN curl -fSL "https://download.nomachine.com/download/8.8/Linux/nomachine_8.8.1_1_amd64.deb" -o nomachine.deb \
        && dpkg -i nomachine.deb \
        && rm nomachine.deb \
	&& chmod +x /entrypoint.sh \
	&& apt-get clean \
	&& mkdir -p /usr/NX/scripts/userscripts \
	&& mkdir -p /var/run/dbus

#MATE
RUN apt update -y && apt install mate-desktop-environment mate-desktop-environment-extras -y

#rclone
RUN curl -fSL "https://downloads.rclone.org/v1.65.0/rclone-v1.65.0-linux-amd64.deb" -o rclone.deb \
	&& dpkg -i rclone.deb \
	&& rm rclone.deb

#some utils
RUN apt-get update && apt-get install sshuttle iputils-ping telnet sshpass -y

#teams-for-linux
RUN mkdir -p /etc/apt/keyrings
RUN wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
RUN echo "deb [signed-by=/etc/apt/keyrings/teams-for-linux.asc arch=$(dpkg --print-architecture)] https://repo.teamsforlinux.de/debian/ stable main" | tee /etc/apt/sources.list.d/teams-for-linux-packages.list
RUN apt-get update
RUN apt-get install teams-for-linux -y

#docker
RUN echo "Installing docker..."
RUN apt-get update && \
  apt-get install ca-certificates curl gnupg -y && \
  install -m 0755 -d /etc/apt/keyrings && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
  chmod a+r /etc/apt/keyrings/docker.gpg && \
  echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu focal stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && \
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin


#COPY userstartup.sh /usr/NX/scripts/userscripts/userstartup.sh
#RUN chmod 777 /usr/NX/scripts/userscripts/*.sh

# setting current keymap on user logon
RUN echo '\n#Custom Startupscript\n\
UserScriptAfterSessionStart = "/usr/NX/scripts/userscripts/userstartup.sh"\n#EOF\n'\
>> /usr/NX/etc/node.cfg

RUN echo '\n#Overwritten AvailableSessionTypes\n\
AvailableSessionTypes nxvfb,physical-desktop\n#EOF\n'\
>> /usr/NX/etc/server.cfg

#DefaultDesktopCommand "/usr/sbin/dbus-launch --exit-with-session startxfce4"\n\

#MySql Workbench
RUN curl -fSL "https://cdn.mysql.com/archives/mysql-workbench/mysql-workbench-community_8.0.34-1ubuntu22.04_amd64.deb" -o mysql-workbench.deb \
	&& dpkg -i mysql-workbench.deb \
	&& rm mysql-workbench.deb


RUN 
COPY sudoers /etc/sudoers


ENTRYPOINT ["/entrypoint.sh"]

#RUN wget -q -O WebStorm.tar.gz https://download-cf.jetbrains.com/webstorm/WebStorm-2020.2.2.tar.gz && \
#  tar xfz WebStorm.tar.gz && \
#  rm *.tar.gz && \
#  mv WebStorm* webstorm && \
#  ln -s /devtoolbox/webstorm/bin/webstorm.sh /sbin/webstorm
