#!/bin/bash

# Fix WebSocket Bridge Permission Issues for Dragon Ball Z
# This script resolves SSL certificate permission errors

echo "🐉 Dragon Ball Z: Fighter's Edition - Permission Fix"
echo "=================================================="

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "❌ Please run as root: sudo $0"
    exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔧 Fixing SSL certificate permissions...${NC}"

# Certificate location
CERT_DIR="/home/ubuntu/dbzfe"
CERT_FILE="$CERT_DIR/self.pem"

# Step 1: Check if certificate exists
if [ ! -f "$CERT_FILE" ]; then
    echo -e "${RED}❌ Certificate not found at $CERT_FILE${NC}"
    echo -e "${YELLOW}Regenerating certificate...${NC}"
    
    mkdir -p "$CERT_DIR"
    openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
        -subj "/C=US/ST=State/L=City/O=DragonBallZ/CN=dbzfe.com" \
        -keyout /tmp/self.key -out /tmp/self.crt
    
    cat /tmp/self.crt /tmp/self.key > "$CERT_FILE"
    rm /tmp/self.key /tmp/self.crt
    
    echo -e "${GREEN}✅ Certificate regenerated${NC}"
fi

# Step 2: Create websocket user if it doesn't exist
if ! id "websocket" &>/dev/null; then
    echo -e "${YELLOW}📋 Creating websocket user...${NC}"
    useradd --system --no-create-home --shell /bin/false websocket
    echo -e "${GREEN}✅ Websocket user created${NC}"
else
    echo -e "${BLUE}📋 Websocket user already exists${NC}"
fi

# Step 3: Fix ownership and permissions
echo -e "${BLUE}🔐 Setting proper permissions...${NC}"

# Make certificate directory accessible
chown -R websocket:websocket "$CERT_DIR"
chmod 755 "$CERT_DIR"
chmod 600 "$CERT_FILE"

# Ensure the websocket user can access parent directories
chmod 755 /home/ubuntu
chmod 755 /home

# Create websocket home directory if needed
if [ ! -d "/home/websocket" ]; then
    mkdir -p /home/websocket
    chown websocket:websocket /home/websocket
    chmod 755 /home/websocket
fi

echo -e "${GREEN}✅ Permissions fixed${NC}"

# Step 4: Update systemd service with better configuration
echo -e "${BLUE}⚙️  Updating systemd service...${NC}"

cat > /etc/systemd/system/dbzfe-websocket.service << EOF
[Unit]
Description=WebSocket Bridge for Dragon Ball Z MUD
After=network.target
Wants=network.target

[Service]
Type=simple
User=websocket
Group=websocket
WorkingDirectory=/home/websocket

# Use full path and add verbose logging
ExecStart=/usr/local/bin/websockify --verbose --cert=$CERT_FILE 8080 dbzfe.com:4000

Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

# Security settings (less restrictive for debugging)
NoNewPrivileges=true
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

# Step 5: Alternative - create certificate in a more accessible location
echo -e "${BLUE}🔄 Creating alternative certificate location...${NC}"

ALT_CERT_DIR="/etc/websockify"
ALT_CERT_FILE="$ALT_CERT_DIR/server.pem"

mkdir -p "$ALT_CERT_DIR"
cp "$CERT_FILE" "$ALT_CERT_FILE"
chown websocket:websocket "$ALT_CERT_FILE"
chmod 600 "$ALT_CERT_FILE"
chmod 755 "$ALT_CERT_DIR"

# Update service to use alternative location
cat > /etc/systemd/system/dbzfe-websocket.service << EOF
[Unit]
Description=WebSocket Bridge for Dragon Ball Z MUD
After=network.target
Wants=network.target

[Service]
Type=simple
User=websocket
Group=websocket
WorkingDirectory=/home/websocket

# Use alternative certificate location
ExecStart=/usr/local/bin/websockify --verbose --cert=$ALT_CERT_FILE 8080 dbzfe.com:4000

Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

# Minimal security restrictions for now
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
EOF

echo -e "${GREEN}✅ Alternative certificate location created: $ALT_CERT_FILE${NC}"

# Step 6: Restart services
echo -e "${BLUE}🔄 Restarting services...${NC}"

systemctl daemon-reload

# Stop all websocket services
systemctl stop websockify.service 2>/dev/null
systemctl stop dbzfe-websocket.service 2>/dev/null

# Start the new service
systemctl enable dbzfe-websocket.service
systemctl start dbzfe-websocket.service

# Wait and check status
sleep 3

if systemctl is-active --quiet dbzfe-websocket.service; then
    echo -e "${GREEN}✅ Service restarted successfully!${NC}"
    echo -e "${GREEN}📊 Service Status:${NC}"
    systemctl status dbzfe-websocket.service --no-pager --lines=10
else
    echo -e "${RED}❌ Service failed to start. Checking logs...${NC}"
    journalctl -u dbzfe-websocket.service --no-pager --lines=20 --since "1 minute ago"
fi

# Step 7: Show diagnostic information
echo ""
echo -e "${BLUE}🔍 Diagnostic Information:${NC}"
echo "Certificate file: $ALT_CERT_FILE"
echo "Certificate permissions: $(ls -la $ALT_CERT_FILE 2>/dev/null || echo 'Not found')"
echo "Websocket user: $(id websocket 2>/dev/null || echo 'Not found')"
echo "Service user: $(systemctl show dbzfe-websocket.service -p User --value 2>/dev/null || echo 'Unknown')"

echo ""
echo -e "${YELLOW}📋 Next Steps:${NC}"
echo "1. Check logs: sudo journalctl -u dbzfe-websocket -f"
echo "2. Test connection: Open your website and try connecting"
echo "3. If still issues, try running service as root temporarily"

echo ""
echo -e "${GREEN}🎮 Permission fix complete!${NC}" 