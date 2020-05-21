# Instalation Steps


# Pre-Req: 
OS: Ubuntu 18.04 
-
OS Firewall: Remove all Ubuntu firewall rules. 
-
User: Root User should run the scripts
-

# Allow following ports in NSG:
        Service - Port
        Nagios - 80
        Prometheus - 9090
        Grafana - 3000
        GrayLog - 9000

# Steps to run the scripts 

## For Nagios: https://raw.githubusercontent.com/burhanudinarshad/sri/master/nagios.sh
## For Prometheu: https://raw.githubusercontent.com/burhanudinarshad/sri/master/prometheus.sh
## For Grafana: https://raw.githubusercontent.com/burhanudinarshad/sri/master/Grafana.sh
## For GrayLog: https://raw.githubusercontent.com/burhanudinarshad/sri/master/graylog.sh

this command will copy script to Ubuntu host
`wget "<URL of script >" `

Run the script by following command.
`./<script name.sh>` 
