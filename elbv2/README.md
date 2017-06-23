# AWS ELBV2 via Ansible
AWS ELBV2 is an application load balancer that have several advantages over the classic load balancer. An application
load balancer supports path and host based routing and routing requests to multiple services and so on. The application
balancer works by creating 'target groups' for each routing rules and then connecting the target groups to either auto scaling
groups or instances directly. This recipe will connect the load balancer target groups to auto scaling groups and thereby
connect the instances behind the auto scaling groups.

The recipe works as following:

* Define the application load balancer structure
  * There is a [default structure](/elbv2/roles/elbv2/defaults/main.yml) that can be used as an starting point. Define additional rules
     or remove that are already defined.
* Define target groups
  * You can define one or more target groups here. Note that a default target group is required for rules that do not match
    other target groups. Once the target groups are created, set the target group ARN facts for the subsequent tasks.
* Define auto scaling groups and wire them to the target groups
  * By using a auto scaling group to connect with target group, you are free to change the instance types and benefit from other
    advantages. Once the auto scaling groups are created, you can use the auto scaling ARNs and the target group ARNs to
    wire them up using the command 'aws autoscaling attach-load-balancer-target-groups' .
* Create the ELBV2 load balancer
  * Surprisingly, the step to create a load balancer comes last. In this step, you define the load balancer and its listeners.
    Then you wire up the listeners with the default target group and then any additional target groups that were defined.
    
## Running the playbook
Before running the playbook override the 'vars' variables

```bash
ansible-playbook elbv2.yml
```

## Run a curl command to verify
This recipe includes a sample ruby webserver that echoes the http request, you can test the recipe by running the 
following command:

```bash
curl <elb url>
```
