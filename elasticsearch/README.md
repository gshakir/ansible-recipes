# ansible-elasticsearch

A recipe for an ElasticSearch cluster with backup and restore scripts. The
playbook roles do the following:

* Ensure or create a EC2 Role that your cluster will assume when it comes up.
* Create a ES node designated as an 'es-client', which will get an public ip or
  a host name.
* Create one or more 'es-nodes' that will be part of the ES cluster.
* Install Elastic search on the cluster along with the head, cloud plugin.
* Finally assign a Elastic IP to the 'esclient' node.

## Running the playbook

Before running make sure you have a bucket to store your elastic search backups.
Then in the the "group_vars/all" file , fill the details of your aws resources like vpc, subnet, key pair, s3 bucket for backup. Then run the command

```bash
ansible-playbook main.yml
```

##  Creating a ES backup

First make sure the es cluster is running and then create snapshot repo (one time only) and then create the ES backup

```bash

curl -v -H 'Content-Type: application/json' -X PUT -d '{ "type": "s3", "settings": { "bucket": "my-elasticsearch-backups" } }' ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/my_backup

curl -X PUT "ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/my_backup/snapshot_1?wait_for_completion=true"

```

## Restoring from backup

If you would like to restore a backup on your new cluster, do the following:

```bash

curl -X POST "ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/my_backup/snapshot_1/_restore"

```

