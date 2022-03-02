# YUN-11p (please visualize this readme in raw text)
Tutorial to configure a YUN rev2 (with LEDE kernel update) and run IEEE 802.11p network

#############################################################################
# SUPERQUICK ALL IN ONE (hypothesis, TFTP server running on mac.. commands: #
#                                                                           #
# sudo launchctl load -F /System/Library/LaunchDaemons/tftp.plist           #
# sudo launchctl start com.apple.tftpd                                      #
#                                                                           #
# in /private/tf <tab> there are the files                                  #
# in other words, the folder /private/tftpboot/ should contain the three    #
# opewrt*.bin files available in this repo                                  #
#############################################################################

# if you are on another OS there is a guide to run TFTP server here:
# https://docs.arduino.cc/tutorials/yun-rev2/YunUBootReflash
  
####################
# SERIAL INFERFACE #
####################

# connect the YUN to your mac through USB port
  
# attach to serial monitor -> hard reboot button YUN -> type "and" to 
# move into the uBOOT system (microcontroller) 

# config the PC-MAC IP to 192.168.1.2

setenv serverip 192.168.1.2;
setenv ipaddr 192.168.1.1;
tftp 0x80060000 openwrt-ar71xx-generic-linino-u-boot.bin;

erase 0x9f000000 +0x40000;
cp.b $fileaddr 0x9f000000 $filesize;
erase 0x9f040000 +0x10000;

tftp 0x80060000 openwrt-ar71xx-generic-yun-16M-kernel.bin;

erase 0x9fEa0000 +0x140000;
cp.b $fileaddr 0x9fea0000 $filesize;

tftp 0x80060000 openwrt-ar71xx-generic-yun-16M-rootfs-squashfs.bin;

erase 0x9f050000 +0xE50000;
cp.b $fileaddr 0x9f050000 $filesize;

bootm 0x9fea0000;


####################
#    WAIT reboot.  #
####################

ifconfig eth1 192.168.1.1


####################
#    ON TERMINAL   #
####################

ssh-keygen -R 192.168.1.1
ssh root@192.168.1.1


#####################
#  Insert LEDE USB  #
#####################

# the USB should contain the lede*.bin file of this repo

run-sysupgrade /mnt/sda1/lede <tab>


####################
#    WAIT reboot.  #
####################

ssh-keygen -R 192.168.1.1
ssh root@192.168.1.1

##############
#   PROVA    #
##############

df -h /



##########################
#    INSTALL EXTRA PKG   #
#   GIVE INTERNET AGAIN  #
##########################

# you can share internet to the YUN in different ways
# here we use to connect to a known Wi-Fi (SSID, PW and IP available)
  
vi /etc/wpa_supplicant.conf

- >
network={
   ssid="ThePingInTheNorth"
   psk="WinterIsRouting"
}

wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf 

ip address add 172.20.10.3/24 dev wlan0

ip route add default via 172.20.10.1

vi /etc/resolv.conf 

- > edit nameserver as 8.8.8.8


opkg update
opkg install iperf
opkg install tcpdump
opkg install arp-scan
opkg install ncat
opkg install openssl-util

opkg install ethtool
opkg install usbutils
opkg install pciutils

##################################
#   Change BR-LAN to X network   #
##################################

vi /etc/config/network

config interface 'lan'
        option type 'bridge'
        option ifname 'eth1'
        option proto 'static'
        option ipaddr '192.168.X.1'
        option netmask '255.255.255.0'
        option ip6assign '60'

