########Instal Prometheus 

export RELEASE="2.2.1"
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-amd64.tar.gz
sudo tar xvf prometheus-${RELEASE}.linux-amd64.tar.gz

# Change to the newly created directory from file extractions.
cd prometheus-${RELEASE}.linux-amd64/

# Create Prometheus system group
sudo groupadd --system prometheus
sudo grep prometheus /etc/group
sudo prometheus:x:999:

# Create Prometheus system user
sudo useradd -s /sbin/nologin -r -g prometheus prometheus
sudo id prometheus
sudo uid=999(prometheus) gid=999(prometheus) groups=999(prometheus)

#Create configuration and data directories for Prometheus

sudo mkdir -p /etc/prometheus/{rules,rules.d,files_sd}  /var/lib/prometheus

#Copy Prometheus binary files to a directory in your $PATH
sudo cp prometheus promtool /usr/local/bin/
sudo ls /usr/local/bin/
sudo prometheus promtool

#Copy consoles and console_libraries to configuration files directory
sudo cp -r consoles/ console_libraries/ /etc/prometheus/

#Create systemd unit file
sudo cd /etc/systemd/system/
sudo wget "https://raw.githubusercontent.com/burhanudinarshad/sri/master/prometheus.service"

sudo cd etc/prometheus/
sudo wget "https://raw.githubusercontent.com/burhanudinarshad/sri/master/prometheus.yml"

# Change directory permissions to Prometheus user and group
sudo chown -R prometheus:prometheus /etc/prometheus/  /var/lib/prometheus/
sudo chmod -R 775 /etc/prometheus/ /var/lib/prometheus/

# Start and enable Prometheus service
sudo systemctl start prometheus
sudo systemctl enable prometheus

#check Status 
systemctl status prometheus
