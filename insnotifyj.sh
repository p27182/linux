wget https://raw.githubusercontent.com/p27182/linux/refs/heads/main/notifyj.service -O /etc/systemd/system/notifyj.service
wget https://raw.githubusercontent.com/p27182/linux/refs/heads/main/notifyj.sh -O /root/notifyj.sh
chmod 700 /root/notifyj.sh
systemctl daemon-reload
systemctl enable --now notifyj.service
read -p "[WEBHOOK] paste discord webhook URL: " url
echo "$url" > /root/discord.wh
echo "[WEBHOOK] url saved to /root/discord.wh"
chmod 600 /root/discord.wh
