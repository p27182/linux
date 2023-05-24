#!/bin/bash
#place discord webhook in root dir
URL=`cat discord.wh`

while read line;
do
#  if [[ "$line" == *"pam_unix(sshd:session): session opened for user"* ]];
  if [[ "$line" == *"Accepted password for"* ]];
  then
     curl -H "Content-Type: application/json" -d '{"username": "PVE", "content":"'"🚨 \`${line}\`"'"}' "$URL";
  fi
done

#dont forget to add to /etc/rsyslog.conf:
# module(load="omprog")
# action(type="omprog" binary="/path/to/notify.sh")
