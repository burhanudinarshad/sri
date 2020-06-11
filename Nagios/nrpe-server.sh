wget 'https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-3.2.1/nrpe-3.2.1.tar.gz'
sudo tar -xvf nrpe-3.2.1.tar.gz
cd nrpe-3.2.1
./configure --enable-command-args --with-nagios-user=nagios --with-nagios-group=nagcmd --with-ssl=/usr/bin/openssl --with-ssl-lib=/usr/lib/x86_64-linux-gnu
sudo make all
sudo make install
sudo make install-init
sudo make install-config
sudo systemctl enable nrpe.service
