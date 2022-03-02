iw wlan0 set type ibss
ip link set dev wlan0 up
iw wlan0 ibss join v2x 2462

ip addr add 192.168.100.19/24 dev wlan0
route add default gw 192.168.100.19 wlan0