#!/usr/bin/env bash
# Set up the web servers for the deployment of web_static
apt update
apt -y install nginx
mkdir -p /data/web_static/releases/test
mkdir -p /data/web_static/shared/
echo "Fake file" > /data/web_static/releases/test/index.html
rm -rf /data/web_static/current
ln -sT /data/web_static/releases/test /data/web_static/current
chown -R "ubuntu":"ubuntu" /data/
sed -i '/server_name _;/a \\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t\tautoindex off;\n\t}' /etc/nginx/sites-available/default
service nginx restart
