#!/bin/bash
URL=`cat /root/discord.wh`

journalctl -f -n0 | while read -r line; do
        if [[ "$line" == *"Accepted password for"* || "$line" == *"Failed password"* || "$line" == *"login:session"* || "$line" == *"uthentication failure"* || "$line" == *"isconnect"* || "$line" == *"logged out"* ]];
        then
                curl -H "Content-Type: application/json" -d '{"username": "logbot", "content":"'"🚨 \`${line}\`"'"}' "$URL";
        fi
done
