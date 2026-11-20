#!/usr/bin/env bash
set -euo pipefail
export DEBIAN_FRONTEND=noninteractive

# If the URL on zabbix.com/download differs, change only this line
ZBX_REPO_URL="https://repo.zabbix.com/zabbix/8.0/release/debian/pool/main/z/zabbix-release/zabbix-release_latest_8.0+debian13_all.deb"

echo "==> Installing prerequisites"
apt-get update
apt-get install -y wget ca-certificates

echo "==> Adding the official Zabbix 8.0 repository"
wget -O /tmp/zabbix-release.deb "$ZBX_REPO_URL"
dpkg -i /tmp/zabbix-release.deb
apt-get update

echo "==> Installing Zabbix Agent 2"
apt-get install -y zabbix-agent2

echo "==> Enabling the service"
systemctl enable zabbix-agent2

echo "==> Installed version:"
zabbix_agent2 --version

echo "==> Package source:"
apt-cache policy zabbix-agent2