#!/bin/bash

# Simple WebSocket Fix - Run as Root (temporary solution)
# This eliminates all permission issues for testing

echo "🐉 Dragon Ball Z: Simple WebSocket Fix"
echo "====================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run as root: sudo $0"
    exit 1
fi

echo "🔧 Creating simple root-based WebSocket service..."

# Stop any existing services
systemctl stop websockify.service 2>/dev/null
systemctl stop dbzfe-websocket.service 2>/dev/null

# Create certificate in /etc/ssl (standard location)
CERT_FILE="/etc/ssl/dbzfe.pem"

if [ ! -f "$CERT_FILE" ]; then
    echo "🔐 Creating SSL certificate..."
    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
        -subj "/C=US/ST=State/L=City/O=DragonBallZ/CN=dbzfe.com" \
        -keyout /tmp/dbzfe.key -out /tmp/dbzfe.crt
    
    cat /tmp/dbzfe.crt /tmp/dbzfe.key > "$CERT_FILE"
    chmod 600 "$CERT_FILE"
    rm /tmp/dbzfe.key /tmp/dbzfe.crt
    echo "✅ Certificate created at $CERT_FILE"
fi

# Create simple systemd service running as root
cat > /etc/systemd/system/dbzfe-websocket.service << EOF
[Unit]
Description=Dragon Ball Z WebSocket Bridge (Root)
After=network.target

[Service]
Type=simple
User=root
Group=root
ExecStart=/usr/local/bin/websockify --cert=$CERT_FILE 8080 dbzfe.com:4000
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF

# Reload and start
systemctl daemon-reload
systemctl enable dbzfe-websocket.service
systemctl start dbzfe-websocket.service

echo "🔄 Waiting for service to start..."
sleep 3

if systemctl is-active --quiet dbzfe-websocket.service; then
    echo "✅ WebSocket bridge is running!"
    echo "📊 Service Status:"
    systemctl status dbzfe-websocket.service --no-pager --lines=5
    echo ""
    echo "🎮 Test connection at: wss://dbzfe.com:8080"
    echo "📋 Check logs with: sudo journalctl -u dbzfe-websocket -f"
else
    echo "❌ Service failed. Checking logs:"
    journalctl -u dbzfe-websocket.service --no-pager --lines=10 --since "1 minute ago"
fi 