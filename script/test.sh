## CPU Vulnerability Scan
wget https://raw.githubusercontent.com/speed47/spectre-meltdown-checker/master/spectre-meltdown-checker.sh
bash spectre-meltdown-checker.sh >> cpuvuln.log

## SpeedTest
wget https://raw.github.com/blackdotsh/curl-speedtest/master/speedtest.sh
bash speedtest.sh >> netspeed.log

## HardDrive Test
dd if=/dev/zero of=/tmp/test1.img bs=1M count=1024 oflag=dsync 2>> hdwrite.log
dd if=/dev/zero of=/tmp/test2.img bs=512 count=1000 oflag=dsync 2>> hdlatency.log
hdparm -t /dev/${lsblk|grep /$|cut -d" " -f1} >> hdparam.log

#apt install -y apache2-utils
#ab -n 10000 -k -H "Accept-Encoding: gzip,deflate" -c 100 https://
