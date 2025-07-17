/* ===================================
   Dragon Ball Z MUD Client Configuration Update
   =================================== */

// Configuration for WebSocket Bridge
const WEBSOCKET_CONFIG = {
    // Change this to your domain
    domain: 'dbzfe.com',
    
    // WebSocket bridge port (configured in the service)
    websocketPort: 8080,
    
    // Original MUD server details (for display)
    mudHost: 'dbzfe.com',
    mudPort: 4000,
    
    // Use secure WebSocket for HTTPS sites
    useSecure: window.location.protocol === 'https:'
};

// Function to update the telnet client configuration
function updateTelnetClient() {
    if (window.telnetClient) {
        // Override the connect method to use WebSocket bridge
        const originalConnect = window.telnetClient.connect.bind(window.telnetClient);
        
        window.telnetClient.connect = function() {
            if (this.isConnected) {
                this.addToOutput('Already connected!', 'warning');
                return;
            }

            const protocol = WEBSOCKET_CONFIG.useSecure ? 'wss:' : 'ws:';
            const wsUrl = `${protocol}//${WEBSOCKET_CONFIG.domain}:${WEBSOCKET_CONFIG.websocketPort}`;
            
            this.updateConnectionStatus('🟡 Connecting...', 'connecting');
            this.addToOutput(`Connecting via WebSocket bridge: ${wsUrl}`, 'info');
            this.addToOutput(`Target MUD server: ${WEBSOCKET_CONFIG.mudHost}:${WEBSOCKET_CONFIG.mudPort}`, 'info');
            this.addToOutput('Note: This requires the WebSocket bridge service to be running on the server.', 'info');

            try {
                this.socket = new WebSocket(wsUrl);
                this.socket.binaryType = 'arraybuffer';

                this.socket.onopen = () => {
                    this.addToOutput('🎉 WebSocket bridge connected successfully!', 'success');
                    this.onConnect();
                };
                
                this.socket.onmessage = (event) => this.onMessage(event);
                this.socket.onclose = (event) => this.onDisconnect(event);
                
                this.socket.onerror = (error) => {
                    console.log('WebSocket Error Details:', error);
                    this.addToOutput('WebSocket bridge connection failed.', 'error');
                    this.addToOutput('This is expected if the bridge service is not set up yet.', 'warning');
                    this.onError(error);
                };

                // Connection timeout
                setTimeout(() => {
                    if (!this.isConnected) {
                        this.addToOutput('WebSocket bridge connection timeout.', 'error');
                        this.addToOutput('The bridge service may not be running or accessible.', 'warning');
                        this.showBridgeHelp();
                    }
                }, 10000);

            } catch (error) {
                this.addToOutput(`Connection exception: ${error.message}`, 'error');
                this.onError(error);
                this.showBridgeHelp();
            }
        };

        // Add bridge-specific help method
        window.telnetClient.showBridgeHelp = function() {
            this.updateConnectionStatus('🔴 Bridge Unavailable', 'disconnected');
            
            const protocol = WEBSOCKET_CONFIG.useSecure ? 'wss:' : 'ws:';
            const helpMessage = `
╔══════════════════════════════════════════════════════════════════╗
║                    WEBSOCKET BRIDGE UNAVAILABLE                  ║
║                  Dragon Ball Z: Fighter's Edition               ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  The WebSocket bridge service is not running or unreachable.    ║
║                                                                  ║
║  🔧 SERVER ADMINISTRATORS:                                       ║
║     • Run: sudo ./setup-websockify-service.sh                   ║
║     • Check service: dbzfe-websocket status                     ║
║     • View logs: dbzfe-websocket logs                           ║
║                                                                  ║
║  🌐 TRYING TO CONNECT:                                           ║
║     • WebSocket URL: ${protocol}//${WEBSOCKET_CONFIG.domain}:${WEBSOCKET_CONFIG.websocketPort}                     ║
║     • Target MUD: ${WEBSOCKET_CONFIG.mudHost}:${WEBSOCKET_CONFIG.mudPort}                                ║
║                                                                  ║
║  🎮 ALTERNATIVE CONNECTION METHODS:                              ║
║     • Use a dedicated MUD client (Mudlet, MUSHclient)           ║
║     • Connect via telnet: telnet ${WEBSOCKET_CONFIG.mudHost} ${WEBSOCKET_CONFIG.mudPort}                    ║
║     • Join Discord for support                                  ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝

Alternative connection methods:
            `;

            this.addToOutput(helpMessage, 'help');
            this.addConnectionOptions();
        };

        // Update the server info display
        window.telnetClient.updateServerInfo = function() {
            this.serverAddress.textContent = `${WEBSOCKET_CONFIG.mudHost}:${WEBSOCKET_CONFIG.mudPort} (via bridge)`;
            this.saveSettings();
        };

        // Update initial server display
        window.telnetClient.updateServerInfo();
        
        // Update welcome messages
        setTimeout(() => {
            window.telnetClient.addToOutput('Dragon Ball Z: Fighter\'s Edition WebSocket Client', 'info');
            window.telnetClient.addToOutput(`MUD Server: ${WEBSOCKET_CONFIG.mudHost}:${WEBSOCKET_CONFIG.mudPort}`, 'info');
            window.telnetClient.addToOutput(`WebSocket Bridge: ${WEBSOCKET_CONFIG.domain}:${WEBSOCKET_CONFIG.websocketPort}`, 'info');
            window.telnetClient.addToOutput('Click "Connect to Game" to connect via WebSocket bridge.', 'info');
        }, 1500);
    }
}

// Apply configuration when the page loads
document.addEventListener('DOMContentLoaded', function() {
    // Wait for telnet client to initialize
    setTimeout(updateTelnetClient, 2000);
});

// Export configuration for manual use
window.WEBSOCKET_CONFIG = WEBSOCKET_CONFIG;
window.updateTelnetClient = updateTelnetClient;

console.log('🐉 Dragon Ball Z WebSocket Bridge Configuration Loaded');
console.log('Bridge URL:', `${WEBSOCKET_CONFIG.useSecure ? 'wss' : 'ws'}://${WEBSOCKET_CONFIG.domain}:${WEBSOCKET_CONFIG.websocketPort}`);
console.log('Target MUD:', `${WEBSOCKET_CONFIG.mudHost}:${WEBSOCKET_CONFIG.mudPort}`); 