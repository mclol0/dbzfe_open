/* ===================================
   Dragon Ball Z WebSocket Bridge Status Checker
   =================================== */

function checkBridgeStatus() {
    console.log('🐉 Dragon Ball Z WebSocket Bridge Status Check');
    console.log('================================================');
    
    const domain = 'dbzfe.com';
    const bridgePort = 8080;
    const mudPort = 4000;
    const useSecure = window.location.protocol === 'https:';
    const protocol = useSecure ? 'wss:' : 'ws:';
    
    console.log(`Website Protocol: ${window.location.protocol}`);
    console.log(`WebSocket Protocol: ${protocol}`);
    console.log(`Bridge URL: ${protocol}//${domain}:${bridgePort}`);
    console.log(`Target MUD: ${domain}:${mudPort}`);
    console.log('');
    
    // Test bridge connection
    console.log('Testing WebSocket bridge connection...');
    const bridgeSocket = new WebSocket(`${protocol}//${domain}:${bridgePort}`);
    
    bridgeSocket.onopen = () => {
        console.log('✅ SUCCESS: WebSocket bridge is working!');
        console.log('🎮 Players can now connect directly from the browser.');
        bridgeSocket.close();
    };
    
    bridgeSocket.onerror = (error) => {
        console.log('❌ FAILED: WebSocket bridge connection failed');
        console.log('⚠️  This means the bridge service is not set up yet.');
        console.log('');
        console.log('🔧 TO FIX:');
        console.log('1. Run on your server: sudo ./setup-websockify-service.sh');
        console.log('2. Or manually: websockify 8080 dbzfe.com:4000');
        console.log('3. Ensure port 8080 is open in firewall');
        console.log('4. For HTTPS sites, ensure SSL certificates are configured');
        console.log('');
        console.log('🎮 ALTERNATIVES FOR PLAYERS:');
        console.log('• Download Mudlet: https://www.mudlet.org/');
        console.log('• Use telnet: telnet dbzfe.com 4000');
        console.log('• Join Discord: https://discord.gg/QynAjm2axA');
    };
    
    bridgeSocket.onclose = (event) => {
        if (event.code !== 1000) {
            console.log(`❌ Bridge closed with code: ${event.code}`);
            if (event.code === 1006) {
                console.log('💡 Code 1006 = Service not reachable (normal if not set up)');
            }
        }
    };
    
    // Timeout check
    setTimeout(() => {
        if (bridgeSocket.readyState === WebSocket.CONNECTING) {
            console.log('⏰ Connection timeout - bridge service not responding');
            bridgeSocket.close();
        }
    }, 5000);
}

// Auto-run status check when script loads
if (typeof window !== 'undefined') {
    // Run check after page loads
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', () => {
            setTimeout(checkBridgeStatus, 1000);
        });
    } else {
        setTimeout(checkBridgeStatus, 1000);
    }
}

// Export for manual use
window.checkBridgeStatus = checkBridgeStatus;

// Add helpful console commands
console.log('🔧 Bridge Status Commands Available:');
console.log('• checkBridgeStatus() - Test bridge connection');
console.log('• WEBSOCKET_CONFIG - View current configuration');
console.log('• updateTelnetClient() - Reload client configuration'); 