# -p 53:53/tcp -p 53:53/udp: plain DNS
# -p 67:67/udp -p 68:68/tcp -p 68:68/udp: add if you intend to use AdGuard Home as a DHCP server.
# DHCP Server docker run --name adguardhome --network host ...
# -p 80:80/tcp -p 443:443/tcp -p 443:443/udp -p 3000:3000/tcp: add if you are going to use AdGuard Home's admin panel as well as run AdGuard Home as an HTTPS/DNS-over-HTTPS server.
# -p 853:853/tcp: add if you are going to run AdGuard Home as a DNS-over-TLS server.
# -p 853:853/udp: add if you are going to run AdGuard Home as a DNS-over-QUIC server.
# -p 5443:5443/tcp -p 5443:5443/udp: add if you are going to run AdGuard Home as a DNSCrypt server.
# -p 6060:6060/tcp: debugging profiles.

docker run --name adguardhome \
    --restart always \
    -v /docker/adguard/work:/opt/adguardhome/work \
    -v /docker/adguard/conf:/opt/adguardhome/conf \
    -p 53:53/tcp -p 53:53/udp\
    -p 67:67/udp -p 68:68/udp\
    -p 80:80/tcp -p 443:443/tcp -p 443:443/udp -p 3000:3000/tcp\
    -p 853:853/tcp\
    -p 853:853/udp\
    -p 5443:5443/tcp -p 5443:5443/udp\
    -p 6060:6060/tcp\
    -d adguard/adguardhome


# If you try to run AdGuardHome on a system where the resolved daemon is started, docker will fail to bind on port 53, because resolved daemon is listening on 127.0.0.53:53. Here's how you can disable DNSStubListener on your machine:
# 
# Deactivate DNSStubListener and update the DNS server address. Create a new file, /etc/systemd/resolved.conf.d/adguardhome.conf (creating the /etc/systemd/resolved.conf.d directory if needed) and add the following content to it:
# 
# [Resolve]
# DNS=127.0.0.1
# DNSStubListener=no
# Specifying 127.0.0.1 as the DNS server address is necessary because otherwise the nameserver will be 127.0.0.53 which doesn't work without DNSStubListener.
# 
# Activate a new resolv.conf file:
# 
# mv /etc/resolv.conf /etc/resolv.conf.backup
# ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf
# Stop DNSStubListener:
# 
# systemctl reload-or-restart systemd-resolved
