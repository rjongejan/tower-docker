FROM ubuntu:trusty
MAINTAINER Ruben J. Jongejan <ruben.jongejan@gmail.com>
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y wget


RUN wget http://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-3.0.3.tar.gz && \
    tar xvf ansible-tower-setup-3.0.3.tar.gz
COPY inventory /ansible-tower-setup-3.0.3/


RUN cd ansible-tower-setup-3.0.3 && \
    sed -i '20s/.*/  when: false/' roles/config_dynamic/tasks/main.yml && \
    ./setup.sh && \
    rm -rf /ansible-tower-setup-*

COPY config.yml /
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
