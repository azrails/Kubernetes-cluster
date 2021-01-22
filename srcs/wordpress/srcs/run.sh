#!/bin/sh
mv ./var/www/wordpress/wp-config-sample.php ./var/www/wordpress/wp-config.php
sed -i "s/wp_/${WP_DB_TABLE_PREFIX}/"          /var/www/wordpress/wp-config.php
sed -i "s/database_name_here/${WP_DB_NAME}/"   /var/www/wordpress/wp-config.php
sed -i "s/password_here/${WP_DB_PASSWD}/"      /var/www/wordpress/wp-config.php
sed -i "s/username_here/${WP_DB_USER}/"       /var/www/wordpress/wp-config.php
sed -i "s/localhost/${WP_DB_HOST}/"            /var/www/wordpress/wp-config.php
TRIES=15
while :
do
    sleep 1
    wp core is-installed 2>&1 | (grep "Error establishing a database connection")
    if [[ $? = 0 ]]
    then
        TRIES=$((TRIES-1))
        echo $TRIES
        if [[ $TRIES = 0 ]]
        then
            echo "Could not connect to database !"
            exit 1
        fi
    else
        echo "Connection to database OK!"
        break
    fi
done
wp core is-installed
if [[ $? = 0 ]]
then
    echo "Wordpress installed"
else
    wp core install --url=http://192.168.99.200:5050 --title="wordpress" --admin_user=wsallei --admin_password=wsallei --admin_email=wsallei@example.com --skip-email
    wp user create editor       editor@example.com      --role=editor       --user_pass=editor1
    wp user create author       author@example.com      --role=author       --user_pass=author1
    wp user create contributor  contributor@example.com --role=contributor  --user_pass=contributor1
    wp user create subscriber   subscriber@example.com  --role=subscriber   --user_pass=subscriber1
    wp theme install twentytwentyone
    wp theme activate twentytwentyone
    wp option update blogdescription "hello"
fi
/usr/sbin/php-fpm7
nginx -g 'daemon off;'