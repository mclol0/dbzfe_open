# 🐉 Dragon Ball Z: Fighter's Edition WebSocket Bridge

This repository contains the complete setup for enabling browser-based connections to your Dragon Ball Z MUD server using a WebSocket-to-Telnet bridge.

## 📋 Overview

The WebSocket bridge allows players to connect to your telnet-based MUD directly from their web browser, eliminating the need to download separate MUD clients for casual play.

**Architecture:**
```
Browser (WebSocket) → WebSocket Bridge → MUD Server (Telnet)
     HTTPS/WSS            Port 8080        dbzfe.com:4000
```

## 🚀 Quick Setup

### 1. Run the Setup Script
```bash
# Make the script executable
chmod +x setup-websockify-service.sh

# Run as root (it will install dependencies)
sudo ./setup-websockify-service.sh
```

The script will:
- ✅ Install all dependencies (websockify, nginx, certbot)
- ✅ Create a dedicated service user
- ✅ Set up SSL certificates (Let's Encrypt or self-signed)
- ✅ Configure the systemd service
- ✅ Configure firewall rules
- ✅ Start the service automatically

### 2. Update Your Website
Add this script to your MUD client page:
```html
<script src="update-mud-client-config.js"></script>
```

Or include it after your existing `mud-client.js`:
```html
<script src="mud-client.js"></script>
<script src="update-mud-client-config.js"></script>
```

### 3. Test the Connection
```bash
# Check service status
dbzfe-websocket status

# Test the WebSocket bridge
dbzfe-websocket test

# View live logs
dbzfe-websocket logs
```

## 📁 Files Included

| File | Description |
|------|-------------|
| `websockify-dbzfe.service` | Systemd service definition |
| `setup-websockify-service.sh` | Complete automated setup script |
| `update-mud-client-config.js` | Updates existing MUD client to use bridge |
| `README.md` | This documentation |

## 🔧 Service Management

The setup creates a convenient management command:

```bash
# Start the bridge service
dbzfe-websocket start

# Stop the bridge service
dbzfe-websocket stop

# Restart the bridge service
dbzfe-websocket restart

# Check service status
dbzfe-websocket status

# View live logs
dbzfe-websocket logs

# Test WebSocket connection
dbzfe-websocket test
```

## ⚙️ Configuration

### Default Configuration
- **WebSocket Port:** 8080 (SSL/TLS only)
- **Target MUD:** dbzfe.com:4000
- **Service User:** websockify
- **Working Directory:** /opt/websockify
- **SSL Certificates:** /etc/ssl/certs/dbzfe.crt, /etc/ssl/private/dbzfe.key

### Customization
Edit the variables at the top of `setup-websockify-service.sh`:
```bash
WEBSOCKIFY_PORT="8080"
MUD_HOST="dbzfe.com"
MUD_PORT="4000"
DOMAIN="dbzfe.com"
```

### Client Configuration
Edit `update-mud-client-config.js`:
```javascript
const WEBSOCKET_CONFIG = {
    domain: 'your-domain.com',
    websocketPort: 8080,
    mudHost: 'dbzfe.com',
    mudPort: 4000,
    useSecure: window.location.protocol === 'https:'
};
```

## 🔒 Security Features

The service includes comprehensive security hardening:

- **SSL/TLS Only:** All WebSocket connections are encrypted
- **User Isolation:** Runs as dedicated non-privileged user
- **System Protection:** Limited file system access
- **Network Restrictions:** IP filtering for additional security
- **Process Limits:** Resource usage constraints
- **Automatic Restarts:** Service auto-recovery on failure

## 🌐 SSL Certificate Options

### Option 1: Let's Encrypt (Recommended)
- Free SSL certificates
- Automatic renewal
- Trusted by all browsers
- Choose this option during setup

### Option 2: Self-Signed (Testing)
- Quick setup for development
- Browser warnings (expected)
- No automatic renewal needed

### Option 3: Custom Certificates
- Use your own SSL certificates
- Place files at specified paths
- Full control over certificate management

## 🔍 Troubleshooting

### Service Won't Start
```bash
# Check service status
systemctl status websockify-dbzfe

# View detailed logs
journalctl -u websockify-dbzfe -f

# Check if port is available
netstat -tlnp | grep 8080
```

### SSL Certificate Issues
```bash
# Verify certificate files exist
ls -la /etc/ssl/certs/dbzfe.crt /etc/ssl/private/dbzfe.key

# Test certificate validity
openssl x509 -in /etc/ssl/certs/dbzfe.crt -text -noout

# Renew Let's Encrypt certificate
certbot renew
```

### Connection Problems
```bash
# Test MUD server directly
telnet dbzfe.com 4000

# Test WebSocket bridge
wscat -c wss://your-domain:8080

# Check firewall
ufw status
firewall-cmd --list-ports
```

### Common Issues

| Problem | Solution |
|---------|----------|
| "Connection refused" | Check if service is running: `dbzfe-websocket status` |
| "SSL certificate error" | Verify certificate files and paths |
| "Port already in use" | Change WEBSOCKIFY_PORT or stop conflicting service |
| "Permission denied" | Check file ownership: `chown -R websockify:websockify /opt/websockify` |

## 🔄 Maintenance

### Log Rotation
Logs are handled by systemd journal. Configure retention:
```bash
# Edit journal configuration
sudo systemctl edit systemd-journald

# Add these lines:
[Journal]
MaxRetentionSec=30day
MaxFileSec=100M
```

### Certificate Renewal
For Let's Encrypt certificates:
```bash
# Test renewal
certbot renew --dry-run

# Set up automatic renewal (usually done by package manager)
systemctl enable certbot.timer
```

### Updates
To update websockify:
```bash
pip3 install --upgrade websockify
systemctl restart websockify-dbzfe
```

## 📊 Monitoring

### Service Health Check
```bash
# Quick health check
curl -k https://your-domain:8080

# Detailed status
dbzfe-websocket status
```

### Performance Monitoring
```bash
# Monitor resource usage
systemctl status websockify-dbzfe

# View connection statistics
journalctl -u websockify-dbzfe | grep -i "connection"

# Network monitoring
netstat -an | grep 8080
```

## 🆘 Support

If you encounter issues:

1. **Check the logs:** `dbzfe-websocket logs`
2. **Verify configuration:** Review service file and certificates
3. **Test connectivity:** Use the built-in test command
4. **Join Discord:** Ask for help in the community
5. **File an issue:** Report bugs or request features

## 📚 Additional Resources

- [Websockify Documentation](https://github.com/novnc/websockify)
- [Let's Encrypt Documentation](https://letsencrypt.org/docs/)
- [Systemd Service Documentation](https://www.freedesktop.org/software/systemd/man/systemd.service.html)

---

## 🎮 For Players

Once the bridge is set up, players can:

1. Visit your Dragon Ball Z website
2. Navigate to the "Play Now" page
3. Click "Connect to Game"
4. Play directly in their browser!

No downloads, no configuration - just instant access to your MUD server! 🐉⚡ 