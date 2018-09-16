FROM ubuntu:bionic
MAINTAINER Toni Michel <tm@kungf.ooo>
# Remove SUID programs
RUN for i in `find / -perm +6000 -type f 2>/dev/null`; do chmod a-s $i; done

RUN     apt-get update && \
        apt-get install -y net-tools && \
        apt-get install -y tinc && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc

ENTRYPOINT [ "/usr/sbin/tinc" ]
CMD [ "start", "-D", "-U", "nobody" ]
