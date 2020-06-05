# Following Alarms will be created:

## EC2 
  1. CPU Utilization 
  2. Status Check Failed 
## RDS
 1. CPU Utilization 
 2. FreeStorageTooLow
 3. FreeableMemoryTooLow
 4. DiskQueueDepthTooHigh
 
 
 Please use following command:
 
 aws cloudformation deploy --template-file .\alarms.json --stack-name <Name of stack> --parameter-overrides email=<Email ID on which Notifications will be sent> DBInstanceIdentifier=<DB Instance identifier on which RDS alerts will be applied> ec2ID=<Instance ID of EC2 on which alerts are to be applied>
