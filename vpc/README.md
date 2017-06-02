# Ansible VPC

A recipe for creating a VPC. The play book does the following:

* Create a VPC
* Create public subnets
* Create private subnets
* Create nat gateway for private subnets.

## Running the playbook

Before running the playbook override the 'defaults' variables in 'vars' as shown

```bash
ansible-playbook vpc.yml
```
