#!/bin/bash

CID=$1   # Customer ID
IP=$2    # IP of pfSense
INST=$3  # Instance

# Copy Config History
scp -p admin@${IP}:/cf/conf/backup/* /pfsense_backups/${CID}/${INST}/ 

# Copy Current Configuration
scp -p admin@${IP}:/cf/conf/config.xml /pfsense_backups/${CID}/${INST}/ 

# Update timestamp to see when the script last run
touch /pfsense_backups/${CID}/${INST}/lastrun
