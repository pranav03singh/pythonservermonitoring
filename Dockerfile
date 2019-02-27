FROM openjdk:18
ENV DEBIAN_FRONTEND noninteractive

ENV HOME /home/ubuntu
RUN ln -sf /bin/bash /bin/sh && useradd -ms /bin/bash ubuntu
WORKDIR $HOME

COPY actionservice-1.0-SNAPSHOT/ $HOME/Action
COPY run /usr/local/bin/run
COPY actionservice.keytab /etc/security/keytabs/actionservice.keytab
COPY krb5.conf /etc/krb5.conf

RUN chmod +x /usr/local/bin/run && \
    mkdir -p /home/ubuntu/Keyfiles && \
    chown -R ubuntu:ubuntu /home/ubuntu/Keyfiles && \
    chown -R ubuntu:ubuntu /usr/local/bin/run && \
    chown -R ubuntu:ubuntu $HOME/Action && \
    chown -R ubuntu:ubuntu /etc/security/keytabs/actionservice.keytab && \ 
    chown -R ubuntu:ubuntu /etc/krb5.conf && \
    cp -rf /etc/krb5.conf /home/ubuntu/Keyfiles && \
    chown -R ubuntu:ubuntu /home/ubuntu/Keyfiles && \
    chown -R ubuntu:ubuntu /tmp/*

HEALTHCHECK CMD netstat -tulpn | grep -w 9000 || exit 1

USER ubuntu

CMD ["/usr/local/bin/run"]

