From ubuntu:16.04

RUN apt-get update -y

RUN apt-get install wget curl bzip2 software-properties-common apt-transport-https -y 

RUN apt-get install gcc python -y 

RUN apt-get install perl pkg-config libglib2.0-dev libpcap-dev gtk2.0 -y

RUN apt-get update && apt-get install -y \ 
    ettercap-text-only \
    net-tools \
    netcat \
    nmap \
    git \
    chromium-browser \
    build-essential \
    iputils-ping \
    sudo \ 
    sslstrip \
    gedit \
    python-twisted-web \
    python-scapy \
    dsniff \ 
    iptables 

RUN git clone https://github.com/websploit/websploit.git

RUN git clone https://gitlab.com/fredericopissarra/t50.git
RUN cd t50 && make && make install

RUN git clone https://github.com/zanyarjamal/xerxes.git
RUN cd xerxes && gcc xerxes.c -o xerxes

RUN curl -L 'https://go.microsoft.com/fwlink/?LinkID=760868' -o "${VSC_DEB_FILE}" && \
    dpkg -i -R "${VSC_DEB_FILE}" || echo "\n Will force install of missing Visual Studio Code dependencies...\n" && \
    apt-get -y -f install 

ARG HOST_UID=1000
ARG HOST_GID=1000

ENV HOST_UID ${HOST_UID}
ENV HOST_GID ${HOST_GID}

RUN useradd --create-home --uid ${HOST_UID} --groups sudo --shell /bin/bash hackalab \
    && echo "hackalab ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/hackalab \
    && chmod 0440 /etc/sudoers.d/hackalab


ENV HOME /home/hackalab

USER hackalab
WORKDIR /home/hackalab

CMD bash

