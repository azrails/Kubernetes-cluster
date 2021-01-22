From	alpine:3.12.0

RUN		apk update && apk upgrade
RUN		apk add nginx openssh openssl

RUN 	echo "root:root" | chpasswd
RUN 	adduser -D -g 'www' www
RUN 	mkdir /var/www/luls
RUN 	chown -R www:www /var/lib/nginx
RUN 	chown -R www:www /var/www/luls
RUN 	mkdir -p /run/nginx

RUN 	openssl req -newkey rsa:4096 -x509 -sha256 -days 360 \
		-nodes -keyout /etc/ssl/luls.key -out /etc/ssl/luls.crt \
		-subj "/C=RU/ST=Moscow/L=Moscow/O=School/OU=IT Department/CN=luls"
RUN 	adduser -D usr
RUN 	echo "usr:pas" | chpasswd
RUN 	ssh-keygen -A
RUN 	echo "SSH on nginx" > etc/motd

COPY	srcs/sshd_config /etc/ssh
COPY	srcs/nginx.conf /etc/nginx
COPY	srcs/index.html /var/www/luls
COPY	srcs/run.sh ./

#port 22 - ssh , 80 - http, 443 -https
EXPOSE	22 80 443

ENTRYPOINT	sh run.sh