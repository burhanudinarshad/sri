echo "inside script"

sudo apt-get install -y apt-transport-https
sudo apt-get install -y software-properties-common wget
sudo wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

echo "get-grafana repo"
sudo add-apt-repository "deb https://packages.grafana.com/enterprise/deb stable main"

sudo apt-get update
sudo apt-get install grafana-enterprise

echo "installed-grafana repo"
sudo systemctl daemon-reload
sudo systemctl enable grafana-server.service
sudo systemctl start grafana-server
