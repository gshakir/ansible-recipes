#!/bin/sh

# Example
# ./register-snapshot-repo.sh ec2-user@ec2-52-72-241-99.compute-1.amazonaws.com:9200/_snapshot/my_backup

# Put the snapshot repository
#
#curl  -H 'Content-Type: application/json' -X PUT -d "{ "type": "s3", "settings": { "bucket": "$2" } }" "$1" --trace /tmp/curlx
curl -v -H 'Content-Type: application/json' -X PUT -d '{ "type": "s3", "settings": { "bucket": "gulam-shakir-com-elasticsearch-backups" } }' "$1"

