#!/usr/bin/env bash
set -euo pipefail

CONF=/etc/zabbix/zabbix_agent2.conf
ZBX_SERVER="enceladus.pfsense.cz"
ZBX_METADATA="SPOS"
ZBX_HOSTNAME="${ZBX_HOSTNAME:?ZBX_HOSTNAME is not set, check your Vagrantfile}"

# Set "key=value" in the config file.
# If the key already exists (uncommented), replace it. Otherwise add it at the end.
set_param() {
  local key="$1" value="$2"
  if grep -qE "^${key}=" "$CONF"; then
    sed -i "s|^${key}=.*|${key}=${value}|" "$CONF"
  else
    echo "${key}=${value}" >> "$CONF"
  fi
}

echo "==> Writing agent configuration"
set_param Server        "$ZBX_SERVER"
set_param ServerActive  "$ZBX_SERVER"
set_param HostMetadata  "$ZBX_METADATA"
set_param Hostname      "$ZBX_HOSTNAME"

echo "==> Restarting the agent"
systemctl restart zabbix-agent2
sleep 3

echo "==> Resulting settings:"
grep -E '^(Server|ServerActive|HostMetadata|Hostname)=' "$CONF"

echo "==> Service status:"
systemctl is-active zabbix-agent2