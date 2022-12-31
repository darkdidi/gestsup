FROM debian:11
RUN apt update -y && apt upgrade -y && apt install wget apache2 mariadb-server php php-{mysql,xml,curl,imap,ldap,zip,mbstring,gd,intl} unzip ntp -y
RUN mariadb -u root
RUN CREATE USER 'gestsup'@'localhost' IDENTIFIED BY 'gestsup';
RUN GRANT ALL PRIVILEGES ON *.* TO 'gestsup'@'localhost';
RUN FLUSH PRIVILEGES;
RUN exit
ADD php.ini /etc/php/7.4/apache2/php.ini
RUN wget -P /var/www/html https://gestsup.fr/downloads/versions/current/version/gestsup_3.2.25.zip
RUN unzip /var/www/html/gestsup_3.2.25.zip -d /var/www/html
RUN rm /var/www/html/gestsup_3.2.25.zip /var/www/html/index.html
RUN useradd gestsup --ingroup www-data
RUN chown -R gestsup:www-data /var/www/html/
RUN find /var/www/html/ -type d -exec chmod 750 {} \;
RUN find /var/www/html/ -type f -exec chmod 640 {} \;
RUN chmod 770 -R /var/www/html/upload
RUN chmod 770 -R /var/www/html/images/model
RUN chmod 770 -R /var/www/html/backup
RUN chmod 770 -R /var/www/html/_SQL
RUN chmod 660 /var/www/html/connect.php

EXPOSE 80