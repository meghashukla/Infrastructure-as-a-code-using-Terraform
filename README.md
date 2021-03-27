# Infrastructure-as-a-code-using-Terraform
# Details regarding assginment

Provision Amazon Web Services VPC using Terraform modules

We are provisioning a VPC, a private subnets, 2 public subnet, 1 private security group
and 1 public security group.
A Load balance is provisioned in a public subnet and attchached to autoscaling group.
Cloudwatch alarm is confugured for too many (threshold set ) HTTP 5XX requests on load balancer, as it can be a threat for DDOS.
The cloudwat alarm triggers the SNS and an email notifucation is sent to the subscribers.
EBS volumes are encrypted with kms.

The layout of this looks like following:

![image](https://user-images.githubusercontent.com/31190996/110502410-2f283480-8121-11eb-9751-a98a74fbf035.png)

## Why Modules?

Modules make it easier to break down the scripts into reusable pieces. These pieces can then be used to
compose infrastructure components as per requirements. Since modules are dependent on each other by exported variables, the module implementation can change anytime without affecting any dependent components.

The folder structure here is :
-Infrastructure as code using Terraform
    |
    |-modules
        |
        |-alb
        |-asg
        |-cloudwatchalarm
        |-ebs
        |-ec2
        |-kms
        |-sg
        |-sn-private
        |-sn-public
        |-sns
        |-vpc
    |-main.tf
    |-variables.tf
    |-outputs.tf
    |-provider.tf




## Executing the scripts

- Install terraform (I am using Terraform v0.14.5)
- Clone the repo
- Run `terraform init` to initialize the modules and provider
- Install aws cli and configure profile
- Create terraform as an IAM user so that you can provision resources. 
```
- Run `terraform plan` to dry-run the scripts
- If everything looks good, run `terraform apply`

