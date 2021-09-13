sudo ln -s /usr/bin/python3 /usr/bin/python

wget -O /tmp/speedtest-cli https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py
chmod +x /tmp/speedtest-cli

/tmp/speedtest-cli
