FROM debian:11
RUN apt update -y
RUN apt upgrade -y
RUN apt install wget -y \
unzip -y \
apache2 -y \
php php-mysql php-xml php-curl php-imap php-ldap php-zip php-mbstring php-gd php-intl -y \
ntp -y
ADD php.ini /etc/php/7.4/apache2/php.ini
RUN wget -P /var/www/html https://gestsup.fr/downloads/versions/current/version/gestsup_3.2.25.zip
RUN unzip /var/www/html/gestsup_3.2.25.zip -d /var/www/html
RUN rm /var/www/html/gestsup_3.2.25.zip /var/www/html/index.html
RUN adduser gestsup --ingroup www-data
RUN chown -R gestsup:www-data /var/www/html/
RUN find /var/www/html/ -type d -exec chmod 750 {} \;
RUN find /var/www/html/ -type f -exec chmod 640 {} \;
RUN chmod 770 -R /var/www/html/upload
RUN chmod 770 -R /var/www/html/images/model
RUN chmod 770 -R /var/www/html/backup
RUN chmod 770 -R /var/www/html/_SQL
RUN chmod 660 /var/www/html/connect.php

VOLUME [ "/var/www/html" ]
EXPOSE 80
