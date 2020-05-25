#install the open source version of Java

sudo apt update
sudo apt-get install -y openjdk-8-jre-headless apt-transport-https uuid-runtime dirmngr

#install Elastic Search
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# run the commands below to add Elasticsearch GPG key by importing it…
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -

# add Elastic Search package repository to Ubuntu
sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" > /etc/apt/sources.list.d/elastic-6.x.list'

#install Elastic Search
sudo apt update
sudo apt install -y elasticsearch

# commands below to make sure it automatically starts up when the server boots up and start it immediately
sudo systemctl start elasticsearch.service
sudo systemctl enable elasticsearch.service

# Install Mongo DB
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

#Install Mongo DB
sudo apt update
sudo apt install -y mongodb-org


sudo systemctl stop mongod.service
sudo systemctl enable mongod.service
sudo systemctl start mongod.service


#Install GrayLog

cd /tmp
wget https://packages.graylog2.org/repo/packages/graylog-3.0-repository_latest.deb
sudo dpkg -i graylog-3.0-repository_latest.deb
sudo apt update
sudo apt install -y graylog-server

#replace config file with our own config file
cd /etc/graylog/server
pwd
sudo rm -f server.conf
wget "https://raw.githubusercontent.com/burhanudinarshad/sri/master/graylog/server.conf"

systemctl stop graylog-server
systemctl daemon-reload
sudo systemctl enable graylog-server
sudo systemctl start graylog-server

