From ubuntu:16.04

RUN apt-get update -y

RUN apt-get install wget bzip2 -y 

RUN apt-get install gcc python -y 

RUN apt-get install perl pkg-config libglib2.0-dev libpcap-dev gtk2.0 -y

RUN apt-get update && apt-get install -y \ 
    ettercap-graphical \
    net-tools \
    netcat \
    nmap \
    git \
    chromium-browser \
    ettercap-text-only \
    build-essential \
    iputils-ping \
    sudo \ 
    iptables 
    
RUN git clone https://gitlab.com/fredericopissarra/t50.git
RUN cd t50 && make && make install

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

CMD ["/bin/bash"]

