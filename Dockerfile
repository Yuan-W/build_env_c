FROM ubuntu:14.04
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
RUN apt-get install -y bc subversion cpio

RUN apt-get install -y adduser; \
    adduser builder --disabled-password --gecos ""; \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers; \
    sed -i "s|^#force_color_prompt=.*|force_color_prompt=yes|" /home/builder/.bashrc;

RUN unlink /bin/sh && ln -s /bin/bash /bin/sh

COPY mmake /usr/bin

ADD colormake /usr/share/colormake

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales

RUN locale-gen "en_US.UTF-8"

RUN dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8

ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8   

RUN ln -s /lib/x86_64-linux-gnu/libncursesw.so.5  /lib/x86_64-linux-gnu/libncursesw.so.6

USER builder

ENTRYPOINT ["/run.sh"]

COPY --chown=builder run.sh /

RUN chmod +x /run.sh
