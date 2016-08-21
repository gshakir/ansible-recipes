#!/bin/sh

# Put the snapshot repository
#
curl "ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/_all?pretty=true" 

# List all snapshots in 'my_backup' repository
#
curl "ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/my_backup/_all?pretty=true" 

#curl "ec2-user@ec2-52-72-241-99.compute-1.amazonaws.com:9200/_stats"
#curl "ec2-user@ec2-52-72-241-99.compute-1.amazonaws.com:9200/_stats/indices"
#curl "ec2-user@ec2-52-72-241-99.compute-1.amazonaws.com:9200/_aliases"

# Save a snapshot
#
# curl -X PUT "ec2-user@ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/my_backup/snapshot_1?wait_for_completion=true"  

# Restore a snapshot
# curl -X POST "ec2-user@ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/my_backup/snapshot_1/_restore"
# POST /_snapshot/my_backup/snapshot_1/_restore

