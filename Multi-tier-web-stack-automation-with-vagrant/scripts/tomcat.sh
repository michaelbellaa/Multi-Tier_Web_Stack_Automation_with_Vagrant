#!/bin/bash
sudo -i
yum install epel-release -y
dnf -y install java-11-openjdk java-11-openjdk-devel
dnf install git maven wget -y
cd /tmp/
wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.75/bin/apache-tomcat-9.0.75.tar.gz
tar xzvf apache-tomcat-9.0.75.tar.gz
useradd --home-dir /usr/local/tomcat --shell /sbin/nologin tomcat
cp -r /tmp/apache-tomcat-9.0.75/* /usr/local/tomcat/
chown -R tomcat.tomcat /usr/local/tomcat
cat <<Eof > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat
After=network.target
[Service]
User=tomcat
WorkingDirectory=/usr/local/tomcat
Environment=JRE_HOME=/usr/lib/jvm/jre
Environment=JAVA_HOME=/usr/lib/jvm/jre
Environment=CATALINA_HOME=/usr/local/tomcat
Environment=CATALINE_BASE=/usr/local/tomcat
ExecStart=/usr/local/tomcat/bin/catalina.sh run
ExecStop=/usr/local/tomcat/bin/shutdown.sh
SyslogIdentifier=tomcat-%i
[Install]
WantedBy=multi-user.target
Eof
systemctl daemon-reload
systemctl enable --now tomcat
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mvn install
systemctl stop tomcat
dnf remove java-17-openjdk java-17-openjdk-headless -y
rm /usr/local/tomcat/webapps/ROOT -rf
cp target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war
chown tomcat:tomcat /usr/local/tomcat -R
systemctl start tomcat