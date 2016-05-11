FROM fedora:23
MAINTAINER "Frank Lemanschik" <frank@dspeed.eu>
# Patched by Eliezer Croitoru <eliezer@ngtech.co.il>

RUN dnf -y update && dnf clean all

# A repo where we can find recent Cockpit builds for F21
# ADD cockpit-preview.repo /etc/yum.repos.d/
RUN dnf -y install cockpit && dnf clean all 

# And the stuff that starts the container
#RUN mkdir -p /container
#ADD cockpit-container-bridge /container/cockpit-bridge
#ADD cockpit-container-daemon /container/cockpitd
#ADD cockpit-container-run /container/cockpit-run
#RUN chmod +x /container/*

RUN echo "root:mypasswd" | chpasswd

RUN mkdir -p /container
ADD start.sh /container/start.sh
RUN chmod 755 /container/*
#RUN rmdir /var/run/docker.sock

#ADD start.sh
#RUN chmod +x /start.sh

EXPOSE 9090
VOLUME /var/run/docker.sock

#/usr/libexec/cockpit-ws
ENTRYPOINT ["/container/start.sh"]
