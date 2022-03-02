wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf 

ip address add 172.20.10.12/24 dev wlan0

ip route add default via 172.20.10.1 

echo search lan > /etc/resolv.conf
echo nameserver 8.8.8.8 >> /etc/resolv.conf