# Ansible VPC

A recipe for creating a VPC. The play book does the following:

* Create a VPC
    * Creation of the VPC is idempotent when re-running the playbook as long as
      the name and the CIDR block doesn't change. This behavior can be changed
      by overriding the 'multi_ok' variable.
* Create public subnets
    * Public subnets are usually provisioned only for load balancers (ELB) and NAT
      Gateways, unless there is a need for a publicly accessible EC2 instance.
* Create private subnets
    * Private subnets are where your applications will reside. If your private
      instances need internet access, then you may choose to provide a NAT
      Gateway or provision those instances in public subnet. The cost of NAT
      Gateway could be a factor here.
* Create NAT Gateway for private subnets.
    * This is optional and is only needed if your instances in private subnets
      need internet access.

## Running the playbook

Before running the playbook override the 'defaults' variables in 'vars' as shown

```bash
ansible-playbook vpc.yml
```

## Customizing the script

The playbook has 2 sets of variables. The variables in the 'default' are some
sensible defaults and starting point. You may choose to accept them or
selectively override them under 'vars'. For example, the option to create NAT
gateway is off and you can turn it on under 'vars'. In Ansible, the 'default'
variables are of the lowest priority.
