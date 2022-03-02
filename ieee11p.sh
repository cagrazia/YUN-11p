ip link set dev wlan0 down
iw dev wlan0 set type ocb
ip link set dev wlan0 up
iw dev wlan0 ocb join 2462 10mhz

ip addr add 192.168.109.1/24 dev wlan0
# route add default gw 192.168.100.18 wlan0