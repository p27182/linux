#!/bin/bash

# check if rsyslog exists
if systemctl is-active --quiet rsyslog; then
  echo "✅  [RSYSLOG CHK] active"
else
  echo "❌ [RSYSLOG CHK] not running or not installed"
  exit 1
fi

GRUB_FILE="/etc/default/grub"
KEY="GRUB_CMDLINE_LINUX"
NEW_VALUE="apparmor=0"
BACKUP_FILE="${GRUB_FILE}.bak"
skip=0

# create backup if not already present
if [ -e "$BACKUP_FILE" ]; then
  echo "❌ [APPARMOR DISABLE] Backup already exists at $BACKUP_FILE, skipping grub edit, you can manually add GRUB_CMDLINE_LINUX=apparmor=0"
  skip=1
else
  cp "$GRUB_FILE" "$BACKUP_FILE"
  echo "✅ [APPARMOR DISABLE] Backup created at $BACKUP_FILE"
fi

if [[ $skip != 1 ]];
then
        # extract the current line
        current_line=$(grep "^$KEY=" "$GRUB_FILE")

        # check if the new value is already present
        if [[ "$current_line" == *"$NEW_VALUE"* ]]; then
                echo "✅ [APPARMOR DISABLE] $NEW_VALUE already present in $KEY"
                skip=1
        fi
        if [[ $skip != 1 ]];
        then
                # build updated line
                updated_line=$(echo "$current_line" | sed -E "s/\"$/ $NEW_VALUE\"/")

                # apply change
                sed -i "s|^$KEY=.*|$updated_line|" "$GRUB_FILE"
                echo "✅ [APPARMOR DISABLE] Added $NEW_VALUE to $KEY"

                update-grub
        fi
fi

# create directories and download shit
mkdir /home/syslog
wget https://raw.githubusercontent.com/p27182/linux/refs/heads/main/notify.sh -O /home/syslog/notify.sh
chmod +x /home/syslog/notify.sh
read -p "[WEBHOOK] paste discord webhook URL: " url
echo "$url" > /home/syslog/discord.wh
echo "✅ [WEBHOOK] url saved to /home/syslog/discord.wh"
chown -R syslog:syslog /home/syslog
chmod 600 /home/syslog/discord.wh

# edit rsyslog shit
CONFIG_LINE='module(load="omprog")'
if ! grep -Fq "$CONFIG_LINE" /etc/rsyslog.conf; then
  echo "$CONFIG_LINE" | tee -a /etc/rsyslog.conf
  echo "✅ [RSYSLOG.CONF EDIT] Added omprog load to /etc/rsyslog.conf"
else
  echo "ℹ️  [RSYSLOG.CONF EDIT] omprog load already present in /etc/rsyslog.conf"
fi

CONFIG_LINE='auth,authpriv.* action(type="omprog" binary="/home/syslog/notify.sh")'
if ! grep -Fq "$CONFIG_LINE" /etc/rsyslog.conf; then
  echo "$CONFIG_LINE" | tee -a /etc/rsyslog.conf
  echo "✅ [RSYSLOG.CONF EDIT] Added omprog rule to /etc/rsyslog.conf"
else
  echo "ℹ️  [RSYSLOG.CONF EDIT] omprog rule already present in /etc/rsyslog.conf"
fi

echo "⚠️  REBOOT to apply changes"
