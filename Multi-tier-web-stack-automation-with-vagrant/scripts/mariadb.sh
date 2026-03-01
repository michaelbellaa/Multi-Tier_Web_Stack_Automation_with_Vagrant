#!/bin/bash
sudo -i
yum install expect git mariadb-server -y
systemctl start mariadb
systemctl enable mariadb
expect <<Eof
spawn mysql_secure_installation
expect "Enter current password for root (enter for none):"
send "\r"
expect "Switch to unix_socket authentication [Y/n]"
send "y\r"
expect "Change the root password? [Y/n]"
send "y\r"
expect "New password:"
send "admin123\r"
expect "Re-enter new password:"
send "admin123\r"
expect "Remove anonymous users? [Y/n]"
send "y\r"
expect "Disallow root login remotely? [Y/n]"
send "y\r"
expect "Remove test database and access to it? [Y/n]"
send "y\r"
expect "Reload privilege tables now? [Y/n]"
send "y\r" 
Eof
mysql -u root -padmin123 << mysql_script
create database accounts;
grant all privileges on accounts.* TO 'admin'@'%' identified by 'admin123';
FLUSH PRIVILEGES;
mysql_script
git clone -b main https://github.com/hkhcoder/vprofile-project.git
cd vprofile-project
mysql -u root -padmin123 accounts < src/main/resources/db_backup.sql
systemctl restart mariadb
