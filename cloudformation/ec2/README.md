
Following Template will install Nagios, Prometheus, and Grafana


Prometheus: <IP-Address-of-EC2>:9090
  
Nagios: http:<IP-Address-of-EC2>/nagios
      For Nagios initial credentials: (you can change after first time login)
        Username: nagiosadmin 
        Password: abcd@1234
  
  
Grafana : <IP-Address-of-EC2>:9090
    For grafana initial credentials: (you can change after first time login)
        Username: admin
        Password: admin
  
  
  Command to run this template: 
  AWS CLI should be set at us-east-1 region for this template to work
  
  `aws cloudformation deploy --template-file <path where you downloaded template> --stack-name <any name you wanna give to this deployment> --parameter-overrides KeyName=<Name of keypair you created in your account in region us-east-1>`
