#!/bin/sh
# Setup PHP
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

sed -i "s/;cgi.fix_pathinfo=0/cgi.fix_pathinfo=1/" /etc/php5/fpm/php.ini
sed -i "s#^max_execution_time = .*#max_execution_time = 300#g" /etc/php5/fpm/php.ini
sed -i "s#^doc_root =.*#doc_root = /var/www/html/#g" /etc/php5/fpm/php.ini
echo "open_basedir = /var/www/html/" >> /etc/php5/fpm/php.ini

# Configure PHP-FPM to start as a service
cp -a /build/php-fpm/init.sh /opt/init-php-fpm.sh
chmod +x /opt/init-php-fpm.sh
php5enmod mcrypt

# Ensure the mode is correct on the unix socket
sed -i 's#;listen.mode = 0660#listen.mode = 0666#g' /etc/php5/fpm/pool.d/www.conf
sed -i -e "s/;pm\s*=\s*static/pm = dynamic/g" /etc/php5/fpm/pool.d/www.conf
# min_spare_servers ≤ start_servers ≤ max_spare_servers ≤ max_children
sed -i "s#^pm.min_spare_servers = .*#pm.min_spare_servers = 5#g" /etc/php5/fpm/pool.d/www.conf
sed -i "s#^pm.start_servers = .*#pm.start_servers  = 20#g" /etc/php5/fpm/pool.d/www.conf
sed -i "s#^pm.max_spare_servers = .*#pm.max_spare_servers = 35#g" /etc/php5/fpm/pool.d/www.conf
sed -i "s#^pm.max_children = .*#pm.max_children = 35#g" /etc/php5/fpm/pool.d/www.conf
sed -i "s#^pm.max_requests = .*#pm.max_requests = 10000#g" /etc/php5/fpm/pool.d/www.conf

sed -i '/^listen /c \
listen = 127.0.0.1:9000' /etc/php5/fpm/pool.d/www.conf 
echo "request_terminate_timeout = 0" >> /etc/php5/fpm/pool.d/www.conf
