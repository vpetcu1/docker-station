FROM ubuntu:22.04

#ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Lisbon
ENV DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

ADD entrypoint.sh /entrypoint.sh

#Generic packages
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install --no-install-recommends -y software-properties-common build-essential libpython3-dev fonts-liberation xdg-utils dbus libdbus-1-dev dbus-x11 nano pulseaudio curl wget libxext-dev sudo gpg-agent libxrender-dev libxtst-dev supervisor htop apt-transport-https wget openssh-server tzdata keyboard-configuration libvulkan1 console-setup
    
#Yarn and Node
#RUN curl -sSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add - \
#    && wget -qO- https://deb.nodesource.com/setup_12.x | sudo -E bash - \
#    && curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
#	&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list \
#	&& apt-get install --no-install-recommends -y nodejs yarn 

#JDK
#RUN apt-get install -y openjdk-11-jdk 
	
#VSCode
#RUN apt-get clean \
#	&& wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - \
#    && apt-get update && apt-get install --no-install-recommends -y software-properties-common && add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" \
#    && apt-get update \
#    && apt-get install --no-install-recommends -y code 

#Git and Git-Flow
RUN apt-get install --no-install-recommends -y git libu2f-udev apt-utils

#UBUNTU-DESKTOP
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y && sudo apt install ubuntu-mate-desktop -y -q

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



ENTRYPOINT ["/entrypoint.sh"]

#RUN wget -q -O WebStorm.tar.gz https://download-cf.jetbrains.com/webstorm/WebStorm-2020.2.2.tar.gz && \
#  tar xfz WebStorm.tar.gz && \
#  rm *.tar.gz && \
#  mv WebStorm* webstorm && \
#  ln -s /devtoolbox/webstorm/bin/webstorm.sh /sbin/webstorm
