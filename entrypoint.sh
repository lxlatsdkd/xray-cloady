#!/bin/sh
# Generates /etc/xray/config.json from env vars at container start,
# so the UUID never has to be baked into the image or the repo.
set -e

UUID="${UUID:-}"
WS_PATH="${WS_PATH:-/ray}"

if [ -z "$UUID" ]; then
  echo "UUID env var is required" >&2
  exit 1
fi

mkdir -p /etc/xray
cat > /etc/xray/config.json <<EOF
{
  "log": {"loglevel": "warning"},
  "inbounds": [
    {
      "port": 3000,
      "protocol": "vless",
      "settings": {
        "clients": [{"id": "$UUID", "flow": ""}],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {"path": "$WS_PATH"}
      }
    }
  ],
  "outbounds": [{"protocol": "freedom", "tag": "direct"}]
}
EOF

exec /usr/local/bin/xray run -c /etc/xray/config.json
