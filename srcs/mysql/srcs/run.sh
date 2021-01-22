chown -R 755 /var/lib/mysql
sed -i 's/^skip-networking/#&/' /etc/my.cnf.d/mariadb-server.cnf
mariadb-install-db --user=mysql --datadir=/var/lib/mysql
sh initdb.sh & 
/usr/bin/mysqld_safe --datadir="/var/lib/mysql"

