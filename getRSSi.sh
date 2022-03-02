MAC=a8:40:41:1a:0e:98
for i in `seq 1 100`; do
	sleep 1
	iw dev wlan0 station get "$MAC" | sed -nre "s@\s*signal:\s*@@p"
done