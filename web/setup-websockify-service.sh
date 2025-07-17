#!/bin/bash

# Dragon Ball Z: Fighter's Edition WebSocket Bridge Setup Script
# This script sets up websockify as a systemd service for your MUD

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
SERVICE_NAME="websockify-dbzfe"
SERVICE_USER="websockify"
SERVICE_GROUP="websockify"
WEBSOCKIFY_DIR="/opt/websockify"
WEBSOCKIFY_PORT="8080"
MUD_HOST="dbzfe.com"
MUD_PORT="4000"
DOMAIN="dbzfe.com"

echo -e "${BLUE}╔══════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║          Dragon Ball Z: Fighter's Edition                       ║${NC}"
echo -e "${BLUE}║            WebSocket Bridge Service Setup                       ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════════════════╝${NC}"
echo

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}This script must be run as root (use sudo)${NC}"
   exit 1
fi

# Function to print step headers
print_step() {
    echo -e "\n${GREEN}🔧 $1${NC}"
    echo "----------------------------------------"
}

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Step 1: Install dependencies
print_step "Installing dependencies"

if command_exists apt-get; then
    # Debian/Ubuntu
    apt-get update
    apt-get install -y python3 python3-pip python3-venv nginx certbot python3-certbot-nginx
elif command_exists yum; then
    # CentOS/RHEL
    yum update -y
    yum install -y python3 python3-pip nginx certbot python3-certbot-nginx
elif command_exists dnf; then
    # Fedora
    dnf update -y
    dnf install -y python3 python3-pip nginx certbot python3-certbot-nginx
else
    echo -e "${RED}Unsupported package manager. Please install python3, pip, nginx, and certbot manually.${NC}"
    exit 1
fi

# Step 2: Create service user
print_step "Creating service user and directories"

if ! id "$SERVICE_USER" &>/dev/null; then
    useradd --system --no-create-home --shell /bin/false $SERVICE_USER
    echo -e "${GREEN}Created user: $SERVICE_USER${NC}"
else
    echo -e "${YELLOW}User $SERVICE_USER already exists${NC}"
fi

# Create directories
mkdir -p $WEBSOCKIFY_DIR/{web,logs}
mkdir -p /etc/ssl/certs /etc/ssl/private

# Step 3: Install websockify
print_step "Installing websockify"

pip3 install websockify

# Create a simple web directory for websockify
cat > $WEBSOCKIFY_DIR/web/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Dragon Ball Z: Fighter's Edition WebSocket Bridge</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            background: #1a1a2e; 
            color: #ffffff; 
            text-align: center; 
            padding: 2rem; 
        }
        .container { 
            max-width: 600px; 
            margin: 0 auto; 
            background: rgba(255, 107, 26, 0.1); 
            padding: 2rem; 
            border-radius: 10px; 
            border: 1px solid #ff6b1a; 
        }
        h1 { color: #ff6b1a; }
        .status { color: #44ff44; font-weight: bold; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐉 Dragon Ball Z: Fighter's Edition</h1>
        <h2>WebSocket Bridge</h2>
        <p class="status">Service is running!</p>
        <p>This WebSocket-to-Telnet bridge enables browser-based connections to the MUD server.</p>
        <p><strong>Target:</strong> dbzfe.com:4000</p>
        <p><strong>WebSocket Port:</strong> 8080</p>
    </div>
</body>
</html>
EOF

# Set ownership
chown -R $SERVICE_USER:$SERVICE_GROUP $WEBSOCKIFY_DIR

# SSL Certificate Setup
echo "🔐 Setting up SSL certificates..."
CERT_DIR="/home/ubuntu/dbzfe"
CERT_FILE="$CERT_DIR/self.pem"

# Create certificate directory
sudo mkdir -p "$CERT_DIR"

if command -v certbot >/dev/null 2>&1; then
    echo "📋 Certbot found. Attempting Let's Encrypt certificate..."
    read -p "Enter your domain name (e.g., dbzfe.com): " DOMAIN_NAME
    
    if [ ! -z "$DOMAIN_NAME" ]; then
        # Try to get Let's Encrypt certificate
        sudo certbot certonly --standalone -d "$DOMAIN_NAME" --non-interactive --agree-tos --email admin@"$DOMAIN_NAME" 2>/dev/null
        
        if [ $? -eq 0 ]; then
            echo "✅ Let's Encrypt certificate obtained successfully!"
            # Combine cert and key for websockify
            sudo cat "/etc/letsencrypt/live/$DOMAIN_NAME/fullchain.pem" "/etc/letsencrypt/live/$DOMAIN_NAME/privkey.pem" > "$CERT_FILE"
            sudo chown websocket:websocket "$CERT_FILE"
            sudo chmod 600 "$CERT_FILE"
            USE_SSL=true
        else
            echo "⚠️  Let's Encrypt failed, falling back to self-signed certificate..."
            USE_SSL=false
        fi
    else
        echo "⚠️  No domain provided, using self-signed certificate..."
        USE_SSL=false
    fi
else
    echo "📋 Certbot not found, using self-signed certificate..."
    USE_SSL=false
fi

# Generate self-signed certificate if Let's Encrypt failed or wasn't available
if [ "$USE_SSL" != "true" ]; then
    echo "🔧 Generating self-signed SSL certificate..."
    sudo openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 \
        -subj "/C=US/ST=State/L=City/O=Organization/CN=dbzfe.com" \
        -keyout /tmp/self.key -out /tmp/self.crt
    
    # Combine cert and key for websockify
    sudo cat /tmp/self.crt /tmp/self.key > "$CERT_FILE"
    sudo chown websocket:websocket "$CERT_FILE"
    sudo chmod 600 "$CERT_FILE"
    sudo rm /tmp/self.key /tmp/self.crt
    
    echo "✅ Self-signed certificate created at $CERT_FILE"
fi

# Step 5: Create systemd service
print_step "Creating systemd service"

# Create service file with dynamic configuration
cat > /etc/systemd/system/$SERVICE_NAME.service << EOF
[Unit]
Description=WebSocket to Telnet Bridge for Dragon Ball Z: Fighter's Edition
Documentation=https://github.com/novnc/websockify
After=network.target
Wants=network.target

[Service]
Type=simple
User=$SERVICE_USER
Group=$SERVICE_GROUP
WorkingDirectory=$WEBSOCKIFY_DIR
ExecStart=/usr/local/bin/websockify --cert=/home/ubuntu/dbzfe/self.pem 8080 dbzfe.com:4000
ExecReload=/bin/kill -HUP \$MAINPID
Restart=always
RestartSec=5
StartLimitInterval=60
StartLimitBurst=3

# Security settings
NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=strict
ProtectHome=true
ReadWritePaths=$WEBSOCKIFY_DIR/logs
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectControlGroups=true

# Logging
StandardOutput=journal
StandardError=journal
SyslogIdentifier=$SERVICE_NAME

[Install]
WantedBy=multi-user.target
EOF

# Step 6: Configure firewall
print_step "Configuring firewall"

if command_exists ufw; then
    ufw allow $WEBSOCKIFY_PORT/tcp
    echo -e "${GREEN}UFW firewall rule added for port $WEBSOCKIFY_PORT${NC}"
elif command_exists firewall-cmd; then
    firewall-cmd --permanent --add-port=$WEBSOCKIFY_PORT/tcp
    firewall-cmd --reload
    echo -e "${GREEN}Firewalld rule added for port $WEBSOCKIFY_PORT${NC}"
fi

# Step 7: Enable and start service
print_step "Starting service"

systemctl daemon-reload
systemctl enable $SERVICE_NAME
systemctl start $SERVICE_NAME

# Wait a moment for service to start
sleep 2

# Check service status
if systemctl is-active --quiet $SERVICE_NAME; then
    echo -e "${GREEN}✅ Service started successfully!${NC}"
else
    echo -e "${RED}❌ Service failed to start. Check logs with: journalctl -u $SERVICE_NAME${NC}"
    exit 1
fi

# Step 8: Create management script
print_step "Creating management script"

cat > /usr/local/bin/dbzfe-websocket << 'EOF'
#!/bin/bash

SERVICE_NAME="websockify-dbzfe"
WEBSOCKIFY_PORT="8080"

case "$1" in
    start)
        echo "Starting Dragon Ball Z WebSocket bridge..."
        systemctl start $SERVICE_NAME
        ;;
    stop)
        echo "Stopping Dragon Ball Z WebSocket bridge..."
        systemctl stop $SERVICE_NAME
        ;;
    restart)
        echo "Restarting Dragon Ball Z WebSocket bridge..."
        systemctl restart $SERVICE_NAME
        ;;
    status)
        systemctl status $SERVICE_NAME
        ;;
    logs)
        journalctl -u $SERVICE_NAME -f
        ;;
    test)
        echo "Testing WebSocket connection..."
        if command -v wscat >/dev/null 2>&1; then
            wscat -c wss://localhost:$WEBSOCKIFY_PORT
        else
            echo "Install wscat for testing: npm install -g wscat"
            echo "Or test in browser at: https://your-domain:$WEBSOCKIFY_PORT"
        fi
        ;;
    *)
        echo "Dragon Ball Z: Fighter's Edition WebSocket Bridge Manager"
        echo "Usage: $0 {start|stop|restart|status|logs|test}"
        echo
        echo "Commands:"
        echo "  start    - Start the WebSocket bridge service"
        echo "  stop     - Stop the WebSocket bridge service"
        echo "  restart  - Restart the WebSocket bridge service"
        echo "  status   - Show service status"
        echo "  logs     - Show live service logs"
        echo "  test     - Test WebSocket connection"
        exit 1
        ;;
esac
EOF

chmod +x /usr/local/bin/dbzfe-websocket

# Step 9: Summary
print_step "Setup Complete!"

echo -e "${GREEN}✅ WebSocket bridge service has been installed and started!${NC}"
echo
echo -e "${BLUE}📋 Service Information:${NC}"
echo "  • Service Name: $SERVICE_NAME"
echo "  • WebSocket Port: $WEBSOCKIFY_PORT (SSL)"
echo "  • Target: $MUD_HOST:$MUD_PORT"
echo "  • Status Page: https://your-domain:$WEBSOCKIFY_PORT"
echo
echo -e "${BLUE}🎮 For your Dragon Ball Z website:${NC}"
echo "  Update your mud-client.js to connect to:"
echo "  wss://your-domain:$WEBSOCKIFY_PORT"
echo
echo -e "${BLUE}🔧 Management Commands:${NC}"
echo "  • Start service:    dbzfe-websocket start"
echo "  • Stop service:     dbzfe-websocket stop"
echo "  • Restart service:  dbzfe-websocket restart"
echo "  • Check status:     dbzfe-websocket status"
echo "  • View logs:        dbzfe-websocket logs"
echo "  • Test connection:  dbzfe-websocket test"
echo
echo -e "${BLUE}🔍 Troubleshooting:${NC}"
echo "  • Check logs:       journalctl -u $SERVICE_NAME"
echo "  • Check status:     systemctl status $SERVICE_NAME"
echo "  • Test telnet:      telnet $MUD_HOST $MUD_PORT"
echo
echo -e "${YELLOW}⚠️  Next Steps:${NC}"
echo "  1. Update your website to use wss://your-domain:$WEBSOCKIFY_PORT"
echo "  2. Test the connection from your browser"
echo "  3. Configure auto-renewal for Let's Encrypt (if used)"
echo
echo -e "${GREEN}🐉 Your Dragon Ball Z MUD is now ready for browser-based connections!${NC}" 