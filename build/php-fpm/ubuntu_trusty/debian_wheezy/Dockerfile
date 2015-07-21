FROM debian:wheezy
MAINTAINER Alexander Reece <alreece45@gmail.com>

#RUN echo 'deb http://us.archive.ubuntu.com/ubuntu precise main universe' > /etc/apt/sources.list &&\
#	apt-get update && \
#	apt-get -y upgrade

# Build packages first
COPY ./packages.sh /build/packages.sh
RUN /build/packages.sh

COPY ./service /build/php-fpm
RUN /build/php-fpm/setup.sh

CMD ["/opt/init-php-fpm.sh"]

EXPOSE 9000
