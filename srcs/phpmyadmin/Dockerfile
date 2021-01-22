From	alpine:3.12.0

RUN		apk update && apk upgrade
RUN 	apk add wget tar php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session nginx
RUN 	wget --output-document=phpmyadmin.tar.gz http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN 	mkdir -p /run/nginx
RUN 	mkdir -p /var/www/ && mkdir -p /var/www/phpmyadmin
RUN		tar -zxvf phpmyadmin.tar.gz --strip 1 -C /var/www/phpmyadmin
RUN		rm -rf phpmyadmin.tar.gz

COPY 	/srcs/config.inc.php /var/www/phpmyadmin
COPY 	/srcs/nginx.conf /etc/nginx
COPY 	/srcs/run.sh ./

EXPOSE	5000

ENTRYPOINT	sh run.sh