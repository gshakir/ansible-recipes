# AWS ELBV2 via Ansible
AWS ELBV2 is an application load balancer that have several advantages over the classic load balancer. An application
load balancer supports path and host based routing and routing requests to multiple services and so on. 

## Goal

The recipe creates a single application load balancer to serve all HTTP requests
by using:

* A default target group to handle all HTTP request that does not match any
  rules.
* Each target group/rule is tied to its own respective Auto scaling group and launch
  configuration
* Then each rule is tied its own respective target group.

In this [recipe blueprint](/elbv2/roles/elbv2/defaults/main.yml), all
non-matching requests get routed to Auto scaling group 'asg1' with launch 
configuration 'lc1'. The HTTP requests that match the path '/img/' go 
to Auto scaling group 'asg2' with launch configuration 'lc2'. 
And finally the HTTP request that match *host* 'blog.gulamshakir.com' 
get routed to Auto scaling group 'asg3' with launch configuration 'lc3'

To test out the recipe, it is already seeded with a ruby HTTP server that echoes
back the request.

```bash
curl <elb url>
```

You should get the output as 'lc1: /'

And calling:

```bash
curl <elb url>/img/foo
```

You should get the output as 'lc2: /img/foo'

## Recipe Details

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
