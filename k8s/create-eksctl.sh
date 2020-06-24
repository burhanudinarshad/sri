#STACK_NAME=wptest20-newvpc-PW3NQ45KQFEC
#Vpc_ID=$(aws cloudformation describe-stacks --stack-name "$STACK_NAME" --query "Stacks[0].Outputs[?OutputKey=='Vpc'].OutputValue" --output text)

AWS_REGION=us-east-1
CLUSTER_NAME=ca-gov-wpaas
Vpc_ID=vpc-0ad46e470cf6793ec


############   get WEB Subnet IDs #################################################################################
websubnet_eus1a=$(aws ec2 describe-subnets --filters "Name=vpc-id,Values=$Vpc_ID" "Name=availability-zone,Values=us-east-1a" \
"Name=availability-zone,Values=us-east-1a" "Name=tag:Name,Values=WebSubnet*" \
--query "Subnets[0].SubnetId" --output text)

websubnet_eus1b=$(aws ec2 describe-subnets \
--filters "Name=vpc-id,Values=$Vpc_ID" "Name=availability-zone,Values=us-east-1b" \
 "Name=tag:Name,Values=WebSubnet*" \
--query "Subnets[0].SubnetId" --output text)

websubnet_eus1c=$(aws ec2 describe-subnets \
--filters "Name=vpc-id,Values=$Vpc_ID" "Name=availability-zone,Values=us-east-1c" "Name=tag:Name,Values=WebSubnet*" \
--query "Subnets[0].SubnetId" --output text)

##############get Public Subnet IDs ####################################################################################
publicsubnet_eus1a=$(aws ec2 describe-subnets \
--filters "Name=vpc-id,Values=$Vpc_ID" "Name=availability-zone,Values=us-east-1a" "Name=tag:Name,Values=PublicSubnet*" \
--query "Subnets[0].SubnetId" --output text)

publicsubnet_eus1b=$(aws ec2 describe-subnets \
--filters "Name=vpc-id,Values=$Vpc_ID" "Name=availability-zone,Values=us-east-1b" "Name=tag:Name,Values=PublicSubnet*" \
--query "Subnets[0].SubnetId" --output text)

publicsubnet_eus1c=$(aws ec2 describe-subnets \
--filters "Name=vpc-id,Values=$Vpc_ID" "Name=availability-zone,Values=us-east-1c" "Name=tag:Name,Values=PublicSubnet*" \
--query "Subnets[0].SubnetId" --output text)

echo "websubnet_eus1a $websubnet_eus1a"
echo "websubnet_eus1b $websubnet_eus1b"
echo "websubnet_eus1c $websubnet_eus1c"


echo "publicsubnet_eus1a $publicsubnet_eus1a"
echo "publicsubnet_eus1b $publicsubnet_eus1b"
echo "publicsubnet_eus1c $publicsubnet_eus1c"


#----------------------Create Cluster with managed node groups 

cat > pp-cluster.yaml <<-EOF
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: $CLUSTER_NAME-eks
  region: $AWS_REGION

vpc:
  subnets:
    public:
      us-east-1a: { id: $publicsubnet_eus1a }
      us-east-1b: { id: $publicsubnet_eus1b }
      us-east-1c: { id: $publicsubnet_eus1c }
    private:
      us-east-1a: { id: $websubnet_eus1a }
      us-east-1b: { id: $websubnet_eus1b }
      us-east-1c: { id: $websubnet_eus1c }

managedNodeGroups:
  - name: managed-external-ng-1
    instanceType: t2.micro
    minSize: 2
    maxSize: 4
    desiredCapacity: 2
    volumeSize: 20
    ssh:
      allow: false
      sourceSecurityGroupIds: $websecuritygroup
    labels: {role: external}
    tags:
      nodegroup-role: worker
    iam:
      withAddonPolicies:
        externalDNS: true
        certManager: true
  
nodeGroups:
  - name: internal-ng-1
    instanceType: t2.micro
    desiredCapacity: 3
    privateNetworking: true
    ssh:
      allow: false  
    labels: {role: internal}   
EOF

################ create EKS Cluster using EKSCTL
 eksctl create cluster -f pp-cluster.yaml
