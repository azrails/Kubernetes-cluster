From	alpine:3.12.0

RUN		apk update && apk upgrade
RUN 	apk add wget tar php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session nginx
RUN 	wget https://wordpress.org/latest.tar.gz 
RUN		tar -zxvf latest.tar.gz
RUN		rm -rf latest.tar.gz
RUN 	mkdir -p /run/nginx
RUN 	mkdir -p /var/www && mv wordpress /var/www
RUN 	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar  && \
    	chmod +x wp-cli.phar                                                            && \
    	mv wp-cli.phar /usr/sbin/wp

COPY 	/srcs/nginx.conf /etc/nginx
COPY 	/srcs/run.sh ./

EXPOSE	5050

ENTRYPOINT	sh run.sh