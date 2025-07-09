#!/bin/bash
# echo $(date) ran >> /home/syslog/notify.log

URL=`cat /home/syslog/discord.wh`

while read line; do
#  if [[ "$line" == *"pam_unix(sshd:session): session opened for user"* ]];
  # echo evaluating! >> /home/syslog/notify.log
  # echo URL="$URL" >> /home/syslog/notify.log
  if [[ "$line" == *"Accepted password for"* || "$line" == *"Failed password"* || "$line" == *"login:session"* || "$line" == *"uthentication failure"* ]];
  then
    curl -H "Content-Type: application/json" -d '{"username": "logbot", "content":"'"🚨 \`${line}\`"'"}' "$URL";
    # echo curled! >> /home/syslog/notify.log
  else
    # echo "exiting..." >> /home/syslog/notify.log
    exit 0
  fi
done

# echo $(date) done >> /home/syslog/done.log

#dont forget to add to /etc/rsyslog.conf (or in rsyslog.d dir):
# module(load="omprog")
# action(type="omprog" binary="/home/syslog/notify.sh")

# NOTE apparmor has to be disabled
# sudo /etc/default/grub
#       GRUB_CMDLINE_LINUX="apparmor=0"
# sudo update-grub
# sudo reboot
# sudo mkdir /home/syslog
# sudo chown -R syslog:syslog /home/syslog
