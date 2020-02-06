#!/bin/bash
rm /etc/apache2/conf-enabled/ig-aliases.conf
systemctl reload apache2
while IFS= read -r line
do
  URL="https://cms.integreat-app.de/$line"
  echo $URL
  wget "$URL" -O /var/www/ig-cache/$line.json
done < /var/www/ig-cache/urls.txt
chown -R www-data:www-data /var/www/ig-cache
ln -s /etc/apache2/conf-available/ig-aliases.conf /etc/apache2/conf-enabled/ig-aliases.conf
systemctl reload apache2

