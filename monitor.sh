iw phy phy0 interface add mon0 type monitor
iw dev wlan0 del
ifconfig mon0 up
iw dev mon0 set freq 2462
tcpdump -i mon0 -n