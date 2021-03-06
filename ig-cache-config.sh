#!/bin/bash
CONFPATH="/etc/apache2/conf-available/ig-aliases.conf"
rm $CONFPATH
touch $CONFPATH
echo "AddType application/json .json" >> $CONFPATH
echo "<LocationMatch ^(.*)/wp-json/(.*)$>" >> $CONFPATH
echo "        Header set Access-Control-Allow-Origin *" >> $CONFPATH
echo "</LocationMatch>" >> $CONFPATH

while IFS= read -r line
do
  mkdir -p "/var/www/ig-cache/$(dirname $line)"
  echo "Alias /$line /var/www/ig-cache/$line.json" >> $CONFPATH
done < /var/www/ig-cache/urls.txt

