#!/bin/bash

# Quick fix for Dragon Ball Z WebSocket Bridge SSL issues
# This script fixes the SSL certificate problem when the service is already running

echo "🐉 Dragon Ball Z: Fighter's Edition - WebSocket SSL Fix"
echo "======================================================"

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

echo -e "${BLUE}🔧 Fixing SSL certificate configuration...${NC}"

# Step 1: Create certificate directory and generate certificate
CERT_DIR="/home/ubuntu/dbzfe"
CERT_FILE="$CERT_DIR/self.pem"

echo -e "${YELLOW}📁 Creating certificate directory...${NC}"
mkdir -p "$CERT_DIR"

# Check if certificate already exists
if [ -f "$CERT_FILE" ]; then
    echo -e "${YELLOW}⚠️  Certificate already exists at $CERT_FILE${NC}"
    read -p "Do you want to regenerate it? (y/N): " regen_cert
    if [[ ! $regen_cert =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}Using existing certificate...${NC}"
    else
        rm -f "$CERT_FILE"
    fi
fi

# Generate certificate if it doesn't exist
if [ ! -f "$CERT_FILE" ]; then
    echo -e "${BLUE}🔐 Generating SSL certificate...${NC}"
    
    # Try Let's Encrypt first if certbot is available
    if command -v certbot >/dev/null 2>&1; then
        echo -e "${YELLOW}📋 Certbot found. Do you want to use Let's Encrypt? (y/N): ${NC}"
        read -p "Enter choice: " use_letsencrypt
        
        if [[ $use_letsencrypt =~ ^[Yy]$ ]]; then
            read -p "Enter your domain name (e.g., dbzfe.com): " domain_name
            if [ ! -z "$domain_name" ]; then
                echo -e "${BLUE}🌐 Attempting Let's Encrypt certificate for $domain_name...${NC}"
                certbot certonly --standalone -d "$domain_name" --non-interactive --agree-tos --email admin@"$domain_name"
                
                if [ $? -eq 0 ]; then
                    echo -e "${GREEN}✅ Let's Encrypt certificate obtained!${NC}"
                    cat "/etc/letsencrypt/live/$domain_name/fullchain.pem" "/etc/letsencrypt/live/$domain_name/privkey.pem" > "$CERT_FILE"
                else
                    echo -e "${RED}❌ Let's Encrypt failed, using self-signed certificate...${NC}"
                    use_letsencrypt="n"
                fi
            else
                use_letsencrypt="n"
            fi
        fi
    else
        use_letsencrypt="n"
    fi
    
    # Generate self-signed certificate if Let's Encrypt wasn't used or failed
    if [[ ! $use_letsencrypt =~ ^[Yy]$ ]]; then
        echo -e "${BLUE}🔧 Generating self-signed certificate...${NC}"
        openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
            -subj "/C=US/ST=State/L=City/O=DragonBallZ/CN=dbzfe.com" \
            -keyout /tmp/self.key -out /tmp/self.crt
        
        # Combine cert and key for websockify
        cat /tmp/self.crt /tmp/self.key > "$CERT_FILE"
        rm /tmp/self.key /tmp/self.crt
        
        echo -e "${GREEN}✅ Self-signed certificate created${NC}"
    fi
    
    # Set proper permissions
    chown websocket:websocket "$CERT_FILE" 2>/dev/null || chown nobody:nogroup "$CERT_FILE"
    chmod 600 "$CERT_FILE"
fi

# Step 2: Update systemd service
echo -e "${BLUE}⚙️  Updating systemd service configuration...${NC}"

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
ExecStart=/usr/local/bin/websockify --cert=$CERT_FILE 8080 dbzfe.com:4000
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

# Security hardening
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true

[Install]
WantedBy=multi-user.target
EOF

# Step 3: Reload and restart service
echo -e "${BLUE}🔄 Reloading systemd and restarting service...${NC}"
systemctl daemon-reload

# Stop the old service (might be named websockify.service)
systemctl stop websockify.service 2>/dev/null
systemctl stop dbzfe-websocket.service 2>/dev/null

# Enable and start the service
systemctl enable dbzfe-websocket.service
systemctl start dbzfe-websocket.service

# Check status
sleep 2
if systemctl is-active --quiet dbzfe-websocket.service; then
    echo -e "${GREEN}✅ WebSocket bridge service is running with SSL!${NC}"
    echo -e "${GREEN}📊 Service Status:${NC}"
    systemctl status dbzfe-websocket.service --no-pager -l
else
    echo -e "${RED}❌ Service failed to start. Checking logs...${NC}"
    journalctl -u dbzfe-websocket.service --no-pager -l --since "1 minute ago"
    exit 1
fi

# Step 4: Test connection
echo -e "${BLUE}🧪 Testing WebSocket connection...${NC}"
echo "Testing SSL WebSocket connection to wss://dbzfe.com:8080..."

# Create a simple test
cat > /tmp/test_websocket.js << 'EOF'
const WebSocket = require('ws');

console.log('Testing WebSocket SSL connection...');
const ws = new WebSocket('wss://dbzfe.com:8080', {
    rejectUnauthorized: false // Accept self-signed certificates
});

ws.on('open', function open() {
    console.log('✅ SSL WebSocket connection successful!');
    ws.close();
    process.exit(0);
});

ws.on('error', function error(err) {
    console.log('❌ WebSocket connection failed:', err.message);
    process.exit(1);
});

ws.on('close', function close(code) {
    if (code !== 1000) {
        console.log('❌ Connection closed with code:', code);
        process.exit(1);
    }
});

// Timeout after 5 seconds
setTimeout(() => {
    console.log('❌ Connection timeout');
    ws.close();
    process.exit(1);
}, 5000);
EOF

if command -v node >/dev/null 2>&1; then
    cd /tmp && npm install ws --silent 2>/dev/null && node test_websocket.js
    rm -f test_websocket.js package*.json
    rm -rf node_modules
else
    echo -e "${YELLOW}⚠️  Node.js not found, skipping WebSocket test${NC}"
fi

echo ""
echo -e "${GREEN}🎉 SSL Fix Complete!${NC}"
echo ""
echo -e "${YELLOW}📋 What was fixed:${NC}"
echo "   • Created SSL certificate at: $CERT_FILE"
echo "   • Updated systemd service with SSL support"
echo "   • Restarted WebSocket bridge service"
echo ""
echo -e "${YELLOW}🔗 Connection Details:${NC}"
echo "   • Secure WebSocket: wss://dbzfe.com:8080"
echo "   • Target MUD Server: dbzfe.com:4000"
echo "   • Certificate: $([ -f "$CERT_FILE" ] && echo "Present" || echo "Missing")"
echo ""
echo -e "${YELLOW}🛠️  Management Commands:${NC}"
echo "   • Check status: sudo systemctl status dbzfe-websocket"
echo "   • View logs: sudo journalctl -u dbzfe-websocket -f"
echo "   • Restart: sudo systemctl restart dbzfe-websocket"
echo ""
echo -e "${GREEN}🎮 Your players can now connect via the web client!${NC}" 