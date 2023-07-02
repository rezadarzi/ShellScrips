#!/bin/bash
useradd -m -U -d /opt/tomcat -s /bin/false tomcat
cd /tmp
wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.49/bin/apache-tomcat-8.5.49.zip
unzip apache-tomcat-*.zip
mkdir -p /opt/tomcat
mv apache-tomcat-8.5.50 /opt/tomcat/
ln -s /opt/tomcat/apache-tomcat-8.5.50 /opt/tomcat/latest
chown -R tomcat: /opt/tomcat
sh -c 'chmod +x /opt/tomcat/latest/bin/*.sh'
##---------------------------------------------------------
touch /etc/systemd/system/tomcat.service
cat << EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat 8.5 servlet container
After=network.target
[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/java/jdk1.8.0_231-amd64"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat/latest"
Environment="CATALINA_HOME=/opt/tomcat/latest"
Environment="CATALINA_PID=/opt/tomcat/latest/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC"

ExecStart=/opt/tomcat/latest/bin/startup.sh
ExecStop=/opt/tomcat/latest/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF
#-----------------------------------------------------------
systemctl daemon-reload ; systemctl restart tomcat ; systemctl enable tomcat
