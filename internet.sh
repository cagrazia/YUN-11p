# vi /etc/wpa_supplicant.conf
wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf 
ip address add 172.20.10.9/24 dev wlan0
ip route add default via 172.20.10.1
vi /etc/resolv.conf

iptables -A INPUT -p tcp --dport 22 --source 192.168.10.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP