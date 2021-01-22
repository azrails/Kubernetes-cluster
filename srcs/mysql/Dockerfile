From	alpine:3.12.0

RUN		apk update && apk upgrade
RUN 	apk add mariadb mariadb-client
RUN 	mkdir -p /run/mysqld && mkfifo /run/mysqld/mysqld.sock && chown -R root /run/mysqld && chown -R mysql:mysql /run/mysqld

VOLUME 	/var/lib/mysql
COPY	srcs/run.sh ./
COPY	srcs/initdb.sh ./
EXPOSE 	3306

ENTRYPOINT	sh run.sh
