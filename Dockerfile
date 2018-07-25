FROM ubuntu:18.04
LABEL description="Make wrapper for c build environment"
LABEL maintainer="yw.johnny@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV TERM=xterm-color

WORKDIR /src

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -qqy gcc make g++ libc6-dev libc6:i386 libncurses5:i386 libstdc++6:i386 build-essential automake autoconf bison flex mawk texinfo
RUN apt-get install -qqy lib32z1 lib32z1-dev libncurses5-dev  libssl-dev libpcap-dev
RUN apt-get install -qqy ncurses-term
RUN apt-get install -y bc subversion

RUN apt-get install -y adduser; \
    adduser builder --disabled-password --gecos ""; \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; \
    sed -i "s|^#force_color_prompt=.*|force_color_prompt=yes|" /home/builder/.bashrc;

RUN unlink /bin/sh && ln -s /bin/bash /bin/sh

USER builder

ENTRYPOINT ["/run.sh"]

COPY --chown=builder run.sh /

RUN chmod +x /run.sh
