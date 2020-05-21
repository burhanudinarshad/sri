########Instal Prometheus 

sudo su -
export RELEASE="2.2.1"
wget https://github.com/prometheus/prometheus/releases/download/v${RELEASE}/prometheus-${RELEASE}.linux-amd64.tar.gz
tar xvf prometheus-${RELEASE}.linux-amd64.tar.gz

# Change to the newly created directory from file extractions.
cd prometheus-${RELEASE}.linux-amd64/

# Create Prometheus system group
groupadd --system prometheus
grep prometheus /etc/group
prometheus:x:999:

# Create Prometheus system user
useradd -s /sbin/nologin -r -g prometheus prometheus
id prometheus
uid=999(prometheus) gid=999(prometheus) groups=999(prometheus)

#Create configuration and data directories for Prometheus

mkdir -p /etc/prometheus/{rules,rules.d,files_sd}  /var/lib/prometheus

#Copy Prometheus binary files to a directory in your $PATH
cp prometheus promtool /usr/local/bin/
ls /usr/local/bin/
prometheus promtool

#Copy consoles and console_libraries to configuration files directory
cp -r consoles/ console_libraries/ /etc/prometheus/

#Create systemd unit file
cd /etc/systemd/system/
wget "https://raw.githubusercontent.com/burhanudinarshad/sri/master/prometheus.service"

cd etc/prometheus/
wget "https://raw.githubusercontent.com/burhanudinarshad/sri/master/prometheus.yml"

# Change directory permissions to Prometheus user and group
chown -R prometheus:prometheus /etc/prometheus/  /var/lib/prometheus/
chmod -R 775 /etc/prometheus/ /var/lib/prometheus/

# Start and enable Prometheus service
systemctl start prometheus
systemctl enable prometheus

#check Status 
systemctl status prometheus
