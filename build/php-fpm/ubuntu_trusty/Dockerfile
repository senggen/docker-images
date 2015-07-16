FROM ubuntu:trusty
MAINTAINER Alexander Reece <alreece45@gmail.com>

# Build packages first
COPY ./debian_wheezy/packages.sh /build/packages.sh
RUN /build/packages.sh

COPY ./debian_wheezy/service /build/php-fpm
RUN /build/php-fpm/setup.sh

RUN apt-get install -y openssh-server supervisor
RUN mkdir -p /var/run/sshd
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisord.conf

EXPOSE 9000 22

CMD ["/usr/bin/supervisord"]
