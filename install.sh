#!/bin/bash
#by H0lin1s5

echo "add repository"
cat <<EOF | sudo tee /etc/apt/sources.list.d/dpo-infinity0.list
deb https://people.debian.org/~infinity0/apt/ unstable contrib
deb-src https://people.debian.org/~infinity0/apt/ unstable contrib
deb https://people.debian.org/~infinity0/apt/ experimental contrib
deb-src https://people.debian.org/~infinity0/apt/ experimental contrib
# too cool for experimental
deb https://people.debian.org/~infinity0/apt/ nightly contrib
deb-src https://people.debian.org/~infinity0/apt/ nightly contrib
EOF

apt-get update
apt-get dist-upgrade -y
aptitude install apt-transport-https
apt-get install tor meek-client make gcc privoxy dnsmasq n2n -y

cat <<EOF |tee /etc/tor/torrc
AutomapHostsOnResolve 1
AutomapHostsSuffixes .exit,.onion
SocksListenAddress 0.0.0.0:9050
DNSPort 0.0.0.0:9053
UseBridges 1
ClientTransportPlugin meek exec /usr/bin/meek-client --log /var/log/tor/meek-client.log
Bridge meek 0.0.2.0:1 url=https://az668014.vo.msecnd.net/ front=ajax.aspnetcdn.com
DataDirectory /etc/tor
GeoIPFile /etc/tor/geoip
GeoIPv6File /etc/tor/geoip6
#HiddenServiceStatistics 0
PidFile /var/run/tor/tor.pid
RunAsDaemon 1
User debian-tor
ControlSocket /var/run/tor/control
ControlSocketsGroupWritable 1
CookieAuthentication 1
CookieAuthFileGroupReadable 1
CookieAuthFile /var/run/tor/control.authcookie
log notice file /var/log/tor/notices.log
EOF

cat <<EOF|tee /etc/privoxy/config
confdir /etc/privoxy
logdir /var/log/privoxy
filterfile default.filter
logfile logfile
listen-address  :8118
toggle  1
enable-remote-toggle  0
enable-remote-http-toggle  0
enable-edit-actions 0
enforce-blocks 0
buffer-limit 4096
enable-proxy-authentication-forwarding 0
forwarded-connect-retries  0
accept-intercepted-requests 1
allow-cgi-request-crunching 0
split-large-forms 0
keep-alive-timeout 5
tolerate-pipelining 1
socket-timeout 300
forward-socks5t / 127.0.0.1:9050 .
forward 192.168.*.*/ .
forward localhost/    .
EOF

sed -i -e '1i +add-heaer {name:mySin} \n \n/  \n' user.action

cat <<EOF |tee /etc/dnsmasq.conf
port=53
server=8.8.8.8
server=8.8.4.4
no-resolv
no-poll
interface=eth0
listen-address=0.0.0.0
no-hosts
addn-hosts=/etc/dnsmasq.d/hosts
log-queries
log-facility=/var/log/dnsmasq.log
conf-dir=/etc/dnsmasq.d
conf-file=/etc/dnsmasq.d/hosts
EOF

update-rc.d tor disable
update-rc.d privoxy  disable

echo "PATH=$PATH:`pwd`"
sync
reboot