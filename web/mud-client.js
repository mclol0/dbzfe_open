/* ===================================
   Dragon Ball Z Telnet Web Client
   =================================== */

class TelnetClient {
    constructor() {
        this.socket = null;
        this.isConnected = false;
        this.reconnectAttempts = 0;
        this.maxReconnectAttempts = 3;
        this.commandHistory = [];
        this.historyIndex = -1;
        this.currentLine = '';
        this.telnetOptions = new Map();
        
        // Initialize map renderer
        this.mapRenderer = null;
        
        // Auto-look feature for map updates
        this.autoLookEnabled = false; // Disabled by default
        this.autoLookInterval = null;
        this.autoLookFrequency = 3000; // 3 seconds
        this.pendingAutoLook = false;
        this.autoLookSuppressNext = false;
        
        // Telnet protocol constants
        this.IAC = 255;  // Interpret As Command
        this.DONT = 254;
        this.DO = 253;
        this.WONT = 252;
        this.WILL = 251;
        this.SB = 250;   // Subnegotiation Begin
        this.SE = 240;   // Subnegotiation End
        
        this.initializeElements();
        this.bindEvents();
        this.loadSettings();
        this.initializeMapRenderer();
    }

    initializeElements() {
        // Get DOM elements
        this.connectBtn = document.getElementById('connectBtn');
        this.disconnectBtn = document.getElementById('disconnectBtn');
        this.connectionStatus = document.getElementById('connectionStatus');
        this.serverHost = document.getElementById('serverHost');
        this.serverPort = document.getElementById('serverPort');
        this.serverAddress = document.getElementById('serverAddress');
        this.updateServerBtn = document.getElementById('updateServer');
        this.terminal = document.getElementById('terminal');
        this.output = document.getElementById('output');
        this.commandInput = document.getElementById('commandInput');
        this.clearTerminalBtn = document.getElementById('clearTerminal');
        this.fullscreenTerminalBtn = document.getElementById('fullscreenTerminal');
        this.quickCmdBtns = document.querySelectorAll('.quick-cmd');
        this.autoLookBtn = document.getElementById('autoLookBtn');
    }

    bindEvents() {
        // Connection buttons
        this.connectBtn.addEventListener('click', () => this.connect());
        this.disconnectBtn.addEventListener('click', () => this.disconnect());
        this.updateServerBtn.addEventListener('click', () => this.updateServerInfo());

        // Command input
        this.commandInput.addEventListener('keydown', (e) => this.handleKeyDown(e));
        this.commandInput.addEventListener('input', (e) => this.handleInput(e));

        // Terminal actions
        this.clearTerminalBtn.addEventListener('click', () => this.clearTerminal());
        this.fullscreenTerminalBtn.addEventListener('click', () => this.toggleFullscreen());

        // Auto-look toggle
        if (this.autoLookBtn) {
            this.autoLookBtn.addEventListener('click', () => this.toggleAutoLook());
        }

        // Quick commands
        this.quickCmdBtns.forEach(btn => {
            btn.addEventListener('click', () => {
                const command = btn.getAttribute('data-cmd');
                this.sendCommand(command);
            });
        });

        // Window events
        window.addEventListener('beforeunload', () => this.disconnect());
        window.addEventListener('resize', () => this.scrollToBottom());
    }

    loadSettings() {
        const savedHost = localStorage.getItem('telnetHost');
        const savedPort = localStorage.getItem('telnetPort');
        const savedAutoLook = localStorage.getItem('autoLookEnabled');
        
        if (savedHost) this.serverHost.value = savedHost;
        if (savedPort) this.serverPort.value = savedPort;
        if (savedAutoLook !== null) this.autoLookEnabled = savedAutoLook === 'true';
        
        this.updateServerInfo();
        this.updateAutoLookButton();
    }

    saveSettings() {
        localStorage.setItem('telnetHost', this.serverHost.value);
        localStorage.setItem('telnetPort', this.serverPort.value);
    }

    updateServerInfo() {
        const host = this.serverHost.value || 'dbzfe.com';
        const port = this.serverPort.value || '4000';
        this.serverAddress.textContent = `${host}:${port}`;
        this.saveSettings();
    }

    connect() {
        if (this.isConnected) {
            this.addToOutput('Already connected!', 'warning');
            return;
        }

        const host = this.serverHost.value || 'dbzfe.com';
        const port = this.serverPort.value || '4000';
        
        this.updateConnectionStatus('🟡 Connecting...', 'connecting');
        this.addToOutput(`Attempting telnet connection to ${host}:${port}...`, 'info');

        // Check if we're on HTTPS and need secure WebSocket
        const protocol = window.location.protocol === 'https:' ? 'wss:' : 'ws:';
        const wsUrl = `${protocol}//${host}:${port}`;
        
        try {
            this.socket = new WebSocket(wsUrl);
            this.socket.binaryType = 'arraybuffer';

            this.socket.onopen = () => this.onConnect();
            this.socket.onmessage = (event) => this.onMessage(event);
            this.socket.onclose = (event) => this.onDisconnect(event);
            this.socket.onerror = (error) => this.onError(error);

            // Connection timeout
            setTimeout(() => {
                if (!this.isConnected) {
                    this.addToOutput('Direct telnet connection failed.', 'warning');
                    this.showTelnetHelp();
                }
            }, 5000);

        } catch (error) {
            this.onError(error);
            this.showTelnetHelp();
        }
    }

    onConnect() {
        this.isConnected = true;
        this.reconnectAttempts = 0;
        this.updateConnectionStatus('🟢 Connected', 'connected');
        this.commandInput.disabled = false;
        this.commandInput.focus();
        
        this.connectBtn.style.display = 'none';
        this.disconnectBtn.style.display = 'inline-flex';
        
        this.addToOutput('Telnet connection established!', 'success');
        this.addToOutput('Welcome to Dragon Ball Z: Fighter\'s Edition!', 'success');
        
        // Send initial telnet negotiation
        this.initializeTelnet();
        
        // Start auto-look for map updates
        this.startAutoLook();
    }

    initializeTelnet() {
        // Send basic telnet options
        this.sendTelnetCommand([this.IAC, this.WILL, 1]);  // Echo
        this.sendTelnetCommand([this.IAC, this.WILL, 3]);  // Suppress Go Ahead
        this.sendTelnetCommand([this.IAC, this.DO, 31]);   // Window Size
    }

    onMessage(event) {
        let data;
        
        if (event.data instanceof ArrayBuffer) {
            data = new Uint8Array(event.data);
        } else {
            // Convert string to bytes for telnet protocol handling
            data = new TextEncoder().encode(event.data);
        }
        
        this.processTelnetData(data);
    }

    processTelnetData(data) {
        let output = '';
        let i = 0;
        
        while (i < data.length) {
            if (data[i] === this.IAC && i + 1 < data.length) {
                // Handle telnet commands
                i = this.handleTelnetCommand(data, i);
            } else {
                // Regular character
                const char = String.fromCharCode(data[i]);
                output += char;
                i++;
            }
        }
        
        if (output.length > 0) {
            this.addGameOutput(output);
        }
    }

    handleTelnetCommand(data, index) {
        if (index + 2 >= data.length) return index + 1;
        
        const command = data[index + 1];
        const option = data[index + 2];
        
        switch (command) {
            case this.WILL:
                // Server will do option
                this.sendTelnetCommand([this.IAC, this.DO, option]);
                break;
            case this.WONT:
                // Server won't do option
                this.sendTelnetCommand([this.IAC, this.DONT, option]);
                break;
            case this.DO:
                // Server wants us to do option
                this.sendTelnetCommand([this.IAC, this.WILL, option]);
                break;
            case this.DONT:
                // Server doesn't want us to do option
                this.sendTelnetCommand([this.IAC, this.WONT, option]);
                break;
        }
        
        return index + 3;
    }

    sendTelnetCommand(bytes) {
        if (this.socket && this.isConnected) {
            const buffer = new Uint8Array(bytes);
            this.socket.send(buffer.buffer);
        }
    }

    onDisconnect(event) {
        this.isConnected = false;
        this.socket = null;
        
        // Stop auto-look
        this.stopAutoLook();
        
        this.updateConnectionStatus('🔴 Disconnected', 'disconnected');
        this.commandInput.disabled = true;
        
        this.connectBtn.style.display = 'inline-flex';
        this.disconnectBtn.style.display = 'none';
        
        if (event && event.code !== 1000) {
            // Provide specific error information
            let errorMsg = `Connection lost (${event.code}`;
            if (event.reason) {
                errorMsg += `: ${event.reason}`;
            }
            errorMsg += ')';
            
            this.addToOutput(errorMsg, 'warning');
            
            // Explain common error codes
            if (event.code === 1006) {
                this.addToOutput('Error 1006: Abnormal closure - server may be unreachable or not speaking WebSocket protocol', 'info');
                this.addToOutput('This is normal for direct MUD connections - a WebSocket bridge is required.', 'info');
            } else if (event.code === 1015) {
                this.addToOutput('Error 1015: SSL certificate error - check certificate configuration', 'info');
            }
            
            this.showTelnetHelp();
        } else {
            this.addToOutput('Disconnected from server.', 'info');
        }
    }

    startAutoLook() {
        if (!this.autoLookEnabled) return;
        
        this.stopAutoLook(); // Clear any existing timer
        
        console.log('🗺️ Starting auto-look every', this.autoLookFrequency / 1000, 'seconds');
        
        this.autoLookInterval = setInterval(() => {
            if (this.isConnected && this.autoLookEnabled) {
                this.sendAutoLook();
            }
        }, this.autoLookFrequency);
    }

    stopAutoLook() {
        if (this.autoLookInterval) {
            clearInterval(this.autoLookInterval);
            this.autoLookInterval = null;
            console.log('🗺️ Auto-look stopped');
        }
    }

    sendAutoLook() {
        if (!this.isConnected || this.pendingAutoLook) return;
        
        this.pendingAutoLook = true;
        this.autoLookSuppressNext = true;
        
        // Send look command as binary data
        if (this.socket) {
            const data = 'look\r\n';
            const encoder = new TextEncoder();
            const binaryData = encoder.encode(data);
            this.socket.send(binaryData.buffer);
            
            console.log('🗺️ Auto-look command sent (will suppress output)');
            
            // Reset pending flag after a delay
            setTimeout(() => {
                this.pendingAutoLook = false;
            }, 1000);
        }
    }

    toggleAutoLook() {
        this.autoLookEnabled = !this.autoLookEnabled;
        
        if (this.autoLookEnabled && this.isConnected) {
            this.startAutoLook();
            this.addToOutput('🗺️ Auto-map updates enabled', 'info');
        } else {
            this.stopAutoLook();
            this.addToOutput('🗺️ Auto-map updates disabled', 'info');
        }
        
        // Update UI button
        this.updateAutoLookButton();
        
        // Save setting
        localStorage.setItem('autoLookEnabled', this.autoLookEnabled);
    }

    onError(error) {
        console.error('Telnet connection error:', error);
        this.addToOutput('Connection error occurred.', 'error');
        
        // Provide specific guidance for WebSocket errors
        this.addToOutput('WebSocket connection failed - this is expected without a bridge.', 'warning');
        this.showTelnetHelp();
    }

    disconnect() {
        if (this.socket) {
            this.socket.close(1000, 'User disconnected');
        }
    }

    sendCommand(command) {
        if (!command && command !== '') return;

        // Add to command history
        if (this.commandHistory[this.commandHistory.length - 1] !== command) {
            this.commandHistory.push(command);
            if (this.commandHistory.length > 100) {
                this.commandHistory.shift();
            }
        }
        this.historyIndex = this.commandHistory.length;

        // Display command in terminal
        this.addToOutput(`> ${command}`, 'command');

        // Send to server with telnet line ending AS BINARY DATA
        if (this.isConnected && this.socket) {
            const data = command + '\r\n';
            // Convert to binary data to avoid "Text frames are not supported" error
            const encoder = new TextEncoder();
            const binaryData = encoder.encode(data);
            this.socket.send(binaryData.buffer);
        } else {
            this.addToOutput('Not connected to server.', 'error');
        }

        // Clear input
        this.commandInput.value = '';
    }

    handleKeyDown(e) {
        switch (e.key) {
            case 'Enter':
                e.preventDefault();
                this.sendCommand(this.commandInput.value);
                break;
            case 'ArrowUp':
                e.preventDefault();
                this.navigateHistory(-1);
                break;
            case 'ArrowDown':
                e.preventDefault();
                this.navigateHistory(1);
                break;
            case 'Tab':
                e.preventDefault();
                // Could implement command completion here
                break;
            case 'Escape':
                e.preventDefault();
                this.commandInput.value = '';
                break;
        }
    }

    handleInput(e) {
        // Handle real-time character input if needed
    }

    navigateHistory(direction) {
        if (this.commandHistory.length === 0) return;

        this.historyIndex += direction;
        
        if (this.historyIndex < 0) {
            this.historyIndex = 0;
        } else if (this.historyIndex >= this.commandHistory.length) {
            this.historyIndex = this.commandHistory.length;
            this.commandInput.value = '';
            return;
        }

        this.commandInput.value = this.commandHistory[this.historyIndex] || '';
    }

    addGameOutput(text) {
        // Check if this text contains map data BEFORE processing colors
        // This ensures the map parser gets clean text
        this.checkForMapData(text);
        
        // Check if we should suppress this output (auto-look response)
        if (this.autoLookSuppressNext && this.isMapOutput(text)) {
            console.log('🗺️ Suppressing auto-look output from terminal (map data processed)');
            this.autoLookSuppressNext = false;
            return; // Don't display in terminal, but map data was already processed
        }
        
        // Reset suppression flag if we get non-map output
        if (this.autoLookSuppressNext && !this.isMapOutput(text)) {
            this.autoLookSuppressNext = false;
        }
        
        // Process MUD-specific formatting (colors, etc.)
        text = this.processMudText(text);
        
        this.addToOutput(text, 'game');
    }

    processMudText(text) {
        // Handle common MUD text processing
        // Remove carriage returns, handle line breaks properly
        text = text.replace(/\r\n/g, '\n').replace(/\r/g, '\n');
        
        // Fix character encoding issues - convert blocks and special chars
        text = this.fixCharacterEncoding(text);
        
        // Handle ANSI color codes
        text = this.convertAnsiColors(text);
        
        return text;
    }

    fixCharacterEncoding(text) {
        // Fix only the most problematic display characters that appear as blocks
        // Don't touch ANSI codes or other valid characters
        const charMap = {
            // Only replace actual display problems, not functional characters
            '□': '~',  // Generic box -> tilde (if it's actually a display block)
            '■': '*',  // Solid box -> asterisk (if it's actually a display block)
            '\u00A0': ' ',  // Non-breaking space -> regular space
        };

        // Apply only essential character replacements
        for (const [bad, good] of Object.entries(charMap)) {
            text = text.replace(new RegExp(bad, 'g'), good);
        }

        // Don't do aggressive Unicode filtering - let ANSI codes through
        return text;
    }

    addToOutput(text, type = 'normal') {
        const line = document.createElement('div');
        line.className = `output-line ${type}`;
        
        switch (type) {
            case 'command':
                line.style.color = '#ffff00';
                line.style.fontWeight = 'bold';
                break;
            case 'game':
                line.style.color = '#00ff00';
                line.style.whiteSpace = 'pre-wrap';
                break;
            case 'info':
                line.style.color = '#00ffff';
                break;
            case 'warning':
                line.style.color = '#ffaa00';
                break;
            case 'error':
                line.style.color = '#ff4444';
                break;
            case 'success':
                line.style.color = '#44ff44';
                line.style.fontWeight = 'bold';
                break;
            case 'help':
                line.style.color = '#ffd700';
                line.style.whiteSpace = 'pre-wrap';
                line.style.fontFamily = 'monospace';
                break;
            default:
                line.style.color = '#00ff00';
        }

        // For game content, allow HTML (for ANSI colors), for others escape HTML
        if (type === 'game' || type === 'help') {
            line.innerHTML = text;
        } else {
            line.innerHTML = this.escapeHtml(text);
        }
        
        this.output.appendChild(line);
        this.scrollToBottom();
        
        // Limit output lines
        while (this.output.children.length > 1000) {
            this.output.removeChild(this.output.firstChild);
        }
    }

    convertAnsiColors(text) {
        // Complete Dragon Ball Z MUD color system support
        
        // Fix specific malformed sequences that appear as question marks
        // Pattern: ?(characters)? likely should be color codes around text
        text = text.replace(/\?\(/g, '\x1b[0;33m(');  // Yellow open paren
        text = text.replace(/\)\?/g, ')\x1b[0m');     // Reset after close paren
        text = text.replace(/\?\*/g, '\x1b[0;31m*'); // Red asterisk
        text = text.replace(/\*\?/g, '*\x1b[0m');    // Reset after asterisk
        text = text.replace(/\? /g, '\x1b[0m ');     // Reset before space
        text = text.replace(/ \?/g, ' \x1b[0;33m');  // Yellow after space
        
        // Handle standalone question marks that are likely color terminators
        text = text.replace(/\?:/g, '\x1b[0m:');     // Reset before colon
        text = text.replace(/:\?/g, ':\x1b[0;33m');  // Yellow after colon
        
        const ansiColors = {
            // Standard escape sequences with proper bright color support
            '\\x1b\\[0m': '</span>',  // Reset (most important - handle first)
            '\\x1b\\[1m': '<span style="font-weight: bold;">',
            '\\x1b\\[4m': '<span style="text-decoration: underline;">',
            '\\x1b\\[7m': '<span style="filter: invert(1);">',  // Reverse video
            
            // Standard colors (normal intensity)
            '\\x1b\\[0;30m': '<span style="color: #555555;">', // Black
            '\\x1b\\[0;31m': '<span style="color: #cd5c5c;">', // Red
            '\\x1b\\[0;32m': '<span style="color: #00ff00;">', // Green  
            '\\x1b\\[0;33m': '<span style="color: #ffff00;">', // Yellow
            '\\x1b\\[0;34m': '<span style="color: #6495ed;">', // Blue
            '\\x1b\\[0;35m': '<span style="color: #ff00ff;">', // Magenta
            '\\x1b\\[0;36m': '<span style="color: #00ffff;">', // Cyan
            '\\x1b\\[0;37m': '<span style="color: #ffffff;">', // White
            
            // Bright colors (bold/high intensity)
            '\\x1b\\[1;30m': '<span style="color: #808080; font-weight: bold;">', // Bright black (gray)
            '\\x1b\\[1;31m': '<span style="color: #ff6666; font-weight: bold;">', // Bright red
            '\\x1b\\[1;32m': '<span style="color: #66ff66; font-weight: bold;">', // Bright green
            '\\x1b\\[1;33m': '<span style="color: #ffff66; font-weight: bold;">', // Bright yellow
            '\\x1b\\[1;34m': '<span style="color: #6666ff; font-weight: bold;">', // Bright blue
            '\\x1b\\[1;35m': '<span style="color: #ff66ff; font-weight: bold;">', // Bright magenta
            '\\x1b\\[1;36m': '<span style="color: #66ffff; font-weight: bold;">', // Bright cyan
            '\\x1b\\[1;37m': '<span style="color: #ffffff; font-weight: bold;">', // Bright white
            
            // Simple color codes (without 0; prefix)
            '\\x1b\\[30m': '<span style="color: #555555;">', // Black
            '\\x1b\\[31m': '<span style="color: #cd5c5c;">', // Red
            '\\x1b\\[32m': '<span style="color: #00ff00;">', // Green
            '\\x1b\\[33m': '<span style="color: #ffff00;">', // Yellow
            '\\x1b\\[34m': '<span style="color: #6495ed;">', // Blue
            '\\x1b\\[35m': '<span style="color: #ff00ff;">', // Magenta
            '\\x1b\\[36m': '<span style="color: #00ffff;">', // Cyan
            '\\x1b\\[37m': '<span style="color: #ffffff;">', // White
            
            // 256-color support (Dragon Ball Z orange and others)
            '\\x1b\\[38;5;166m': '<span style="color: #ff8700;">', // Orange (DBZ color)
            '\\x1b\\[38;5;208m': '<span style="color: #ff8700;">', // Dark orange
            '\\x1b\\[38;5;202m': '<span style="color: #ff5f00;">', // Red-orange
            '\\x1b\\[38;5;214m': '<span style="color: #ffaf00;">', // Gold
            '\\x1b\\[38;5;220m': '<span style="color: #ffd700;">', // Light gold
            
            // Background colors
            '\\x1b\\[40m': '<span style="background-color: #000000;">', // Black bg
            '\\x1b\\[41m': '<span style="background-color: #cd5c5c;">', // Red bg
            '\\x1b\\[42m': '<span style="background-color: #00ff00;">', // Green bg
            '\\x1b\\[43m': '<span style="background-color: #ffff00;">', // Yellow bg
            '\\x1b\\[44m': '<span style="background-color: #6495ed;">', // Blue bg
            '\\x1b\\[45m': '<span style="background-color: #ff00ff;">', // Magenta bg
            '\\x1b\\[46m': '<span style="background-color: #00ffff;">', // Cyan bg
            '\\x1b\\[47m': '<span style="background-color: #ffffff; color: #000000;">', // White bg
            
            // Raw bracket sequences (websockify compatibility) - MOST IMPORTANT
            '\\[0m': '</span>',  // Reset - handle this first
            '\\[1m': '<span style="font-weight: bold;">',
            '\\[4m': '<span style="text-decoration: underline;">',
            '\\[7m': '<span style="filter: invert(1);">',
            
            // Standard colors (raw brackets)
            '\\[0;30m': '<span style="color: #555555;">', // Black
            '\\[0;31m': '<span style="color: #cd5c5c;">', // Red
            '\\[0;32m': '<span style="color: #00ff00;">', // Green
            '\\[0;33m': '<span style="color: #ffff00;">', // Yellow
            '\\[0;34m': '<span style="color: #6495ed;">', // Blue
            '\\[0;35m': '<span style="color: #ff00ff;">', // Magenta
            '\\[0;36m': '<span style="color: #00ffff;">', // Cyan
            '\\[0;37m': '<span style="color: #ffffff;">', // White
            
            // Bright colors (raw brackets)
            '\\[1;30m': '<span style="color: #808080; font-weight: bold;">', // Bright black
            '\\[1;31m': '<span style="color: #ff6666; font-weight: bold;">', // Bright red
            '\\[1;32m': '<span style="color: #66ff66; font-weight: bold;">', // Bright green
            '\\[1;33m': '<span style="color: #ffff66; font-weight: bold;">', // Bright yellow
            '\\[1;34m': '<span style="color: #6666ff; font-weight: bold;">', // Bright blue
            '\\[1;35m': '<span style="color: #ff66ff; font-weight: bold;">', // Bright magenta
            '\\[1;36m': '<span style="color: #66ffff; font-weight: bold;">', // Bright cyan
            '\\[1;37m': '<span style="color: #ffffff; font-weight: bold;">', // Bright white
            
            // 256-color (raw brackets)
            '\\[38;5;166m': '<span style="color: #ff8700;">', // Orange
            '\\[38;5;208m': '<span style="color: #ff8700;">', // Dark orange
            '\\[38;5;202m': '<span style="color: #ff5f00;">', // Red-orange
            '\\[38;5;214m': '<span style="color: #ffaf00;">', // Gold
            '\\[38;5;220m': '<span style="color: #ffd700;">', // Light gold
            
            // Background colors (raw brackets)
            '\\[40m': '<span style="background-color: #000000;">', // Black bg
            '\\[41m': '<span style="background-color: #cd5c5c;">', // Red bg
            '\\[42m': '<span style="background-color: #00ff00;">', // Green bg
            '\\[43m': '<span style="background-color: #ffff00; color: #000000;">', // Yellow bg
            '\\[44m': '<span style="background-color: #6495ed;">', // Blue bg
            '\\[45m': '<span style="background-color: #ff00ff;">', // Magenta bg
            '\\[46m': '<span style="background-color: #00ffff; color: #000000;">', // Cyan bg
            '\\[47m': '<span style="background-color: #ffffff; color: #000000;">', // White bg
            
            // Dragon Ball Z custom color codes (if sent raw)
            '\\{y\\}': '<span style="color: #ffff00;">', // Normal yellow
            '\\{Y\\}': '<span style="color: #ffff66; font-weight: bold;">', // Bright yellow
            '\\{r\\}': '<span style="color: #cd5c5c;">', // Normal red
            '\\{R\\}': '<span style="color: #ff6666; font-weight: bold;">', // Bright red
            '\\{g\\}': '<span style="color: #00ff00;">', // Normal green
            '\\{G\\}': '<span style="color: #66ff66; font-weight: bold;">', // Bright green
            '\\{b\\}': '<span style="color: #6495ed;">', // Normal blue
            '\\{B\\}': '<span style="color: #6666ff; font-weight: bold;">', // Bright blue
            '\\{c\\}': '<span style="color: #00ffff;">', // Normal cyan
            '\\{C\\}': '<span style="color: #66ffff; font-weight: bold;">', // Bright cyan
            '\\{m\\}': '<span style="color: #ff00ff;">', // Normal magenta
            '\\{M\\}': '<span style="color: #ff66ff; font-weight: bold;">', // Bright magenta
            '\\{d\\}': '<span style="color: #555555;">', // Normal black (dark)
            '\\{D\\}': '<span style="color: #808080; font-weight: bold;">', // Bright black (gray)
            '\\{w\\}': '<span style="color: #ffffff;">', // Normal white
            '\\{W\\}': '<span style="color: #ffffff; font-weight: bold;">', // Bright white
            '\\{o\\}': '<span style="color: #ff8700;">', // Orange (special DBZ color)
            '\\{x\\}': '</span>', // Reset
            
            // Background custom codes
            '\\^d': '<span style="background-color: #000000;">', // Black bg
            '\\^r': '<span style="background-color: #cd5c5c;">', // Red bg
            '\\^g': '<span style="background-color: #00ff00; color: #000000;">', // Green bg
            '\\^y': '<span style="background-color: #ffff00; color: #000000;">', // Yellow bg
            '\\^b': '<span style="background-color: #6495ed;">', // Blue bg
            '\\^m': '<span style="background-color: #ff00ff;">', // Magenta bg
            '\\^c': '<span style="background-color: #00ffff; color: #000000;">', // Cyan bg
            '\\^w': '<span style="background-color: #ffffff; color: #000000;">', // White bg
            '\\^u': '<span style="text-decoration: underline;">', // Underline
            '\\^7': '<span style="filter: invert(1);">', // Reverse
            '\\^n': '</span>', // Reset
        };

        // Process RESET codes FIRST (critical for termination)
        text = text.replace(/\x1b\[0m/g, '</span>');
        text = text.replace(/\[0m/g, '</span>');

        for (const [ansi, html] of Object.entries(ansiColors)) {
            text = text.replace(new RegExp(ansi, 'g'), html);
        }

        // Add missing simple color codes (without 0; prefix)
        const simpleColors = {
            '\\x1b\\[30m': '<span style="color: #555555;">', // Black
            '\\x1b\\[31m': '<span style="color: #cd5c5c;">', // Red
            '\\x1b\\[32m': '<span style="color: #00ff00;">', // Green
            '\\x1b\\[33m': '<span style="color: #ffff00;">', // Yellow
            '\\x1b\\[34m': '<span style="color: #6495ed;">', // Blue
            '\\x1b\\[35m': '<span style="color: #ff00ff;">', // Magenta
            '\\x1b\\[36m': '<span style="color: #00ffff;">', // Cyan
            '\\x1b\\[37m': '<span style="color: #ffffff;">', // White
            
            // Raw brackets simple colors
            '\\[30m': '<span style="color: #555555;">', // Black
            '\\[31m': '<span style="color: #cd5c5c;">', // Red
            '\\[32m': '<span style="color: #00ff00;">', // Green
            '\\[33m': '<span style="color: #ffff00;">', // Yellow
            '\\[34m': '<span style="color: #6495ed;">', // Blue
            '\\[35m': '<span style="color: #ff00ff;">', // Magenta
            '\\[36m': '<span style="color: #00ffff;">', // Cyan
            '\\[37m': '<span style="color: #ffffff;">', // White
        };

        for (const [ansi, html] of Object.entries(simpleColors)) {
            text = text.replace(new RegExp(ansi, 'g'), html);
        }

        // Clean up any remaining unhandled ANSI sequences to prevent question marks
        // Remove any remaining escape sequences that we haven't handled
        text = text.replace(/\x1b\[[0-9;]*[a-zA-Z]/g, '');
        text = text.replace(/\[[0-9;]*[a-zA-Z]/g, '');

        return text;
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }

    updateConnectionStatus(text, className) {
        this.connectionStatus.textContent = text;
        this.connectionStatus.className = `status-indicator ${className}`;
    }

    clearTerminal() {
        this.output.innerHTML = '';
        this.addToOutput('Terminal cleared.', 'info');
    }

    toggleFullscreen() {
        const terminalContainer = document.querySelector('.terminal-container');
        terminalContainer.classList.toggle('fullscreen');
        
        const icon = this.fullscreenTerminalBtn.querySelector('i');
        if (terminalContainer.classList.contains('fullscreen')) {
            icon.className = 'fas fa-compress';
            this.addToOutput('Entered fullscreen mode. Press ESC to exit.', 'info');
        } else {
            icon.className = 'fas fa-expand';
        }
    }

    scrollToBottom() {
        setTimeout(() => {
            this.output.scrollTop = this.output.scrollHeight;
        }, 10);
    }

    showTelnetHelp() {
        this.updateConnectionStatus('🔴 Setup Required', 'disconnected');
        
        const helpMessage = `
╔══════════════════════════════════════════════════════════════════╗
║                    TELNET CONNECTION SETUP                       ║
║                  Dragon Ball Z: Fighter's Edition               ║
╠══════════════════════════════════════════════════════════════════╣
║                                                                  ║
║  To enable browser-based telnet connections, you need to set    ║
║  up a WebSocket-to-Telnet bridge on your server.                ║
║                                                                  ║
║  🔧 SERVER SETUP (for server administrators):                   ║
║     • Install websockify: pip install websockify                ║
║     • Run bridge: websockify 8080 dbzfe.com:4000                ║
║     • Configure SSL for HTTPS sites                             ║
║                                                                  ║
║  🎮 PLAYER OPTIONS:                                              ║
║     • Use a dedicated MUD client (recommended)                  ║
║     • Connect via telnet command line                           ║
║     • Ask server admin to set up web bridge                     ║
║                                                                  ║
║  📋 CONNECTION INFO:                                             ║
║     • Host: dbzfe.com                                           ║
║     • Port: 4000                                                ║
║     • Protocol: Telnet                                          ║
║                                                                  ║
╚══════════════════════════════════════════════════════════════════╝

Choose your connection method below:
        `;

        this.addToOutput(helpMessage, 'help');
        this.addConnectionOptions();
    }

    addConnectionOptions() {
        const optionsContainer = document.createElement('div');
        optionsContainer.className = 'connection-options';
        optionsContainer.innerHTML = `
            <div style="text-align: center; margin: 2rem 0;">
                <h4 style="color: var(--primary-orange); margin-bottom: 1rem;">🎮 MUD Clients (Recommended):</h4>
                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap; margin-bottom: 2rem;">
                    <a href="https://www.mudlet.org/" target="_blank" class="option-btn">
                        <i class="fas fa-download"></i> Mudlet
                    </a>
                    <a href="https://www.gammon.com.au/mushclient/" target="_blank" class="option-btn">
                        <i class="fas fa-download"></i> MUSHclient
                    </a>
                    <a href="https://tintin.mudhalla.net/" target="_blank" class="option-btn">
                        <i class="fas fa-download"></i> TinTin++
                    </a>
                </div>
                
                <h4 style="color: var(--primary-blue); margin-bottom: 1rem;">🖥️ Command Line Telnet:</h4>
                <div style="background: rgba(0,0,0,0.4); padding: 1.5rem; border-radius: 8px; margin-bottom: 2rem;">
                    <div style="margin-bottom: 1rem;">
                        <p style="color: var(--text-gray); margin-bottom: 0.5rem;">Windows (enable telnet first):</p>
                        <code>dism /online /Enable-Feature /FeatureName:TelnetClient</code><br>
                        <code>telnet dbzfe.com 4000</code>
                    </div>
                    <div style="margin-bottom: 1rem;">
                        <p style="color: var(--text-gray); margin-bottom: 0.5rem;">Mac/Linux:</p>
                        <code>telnet dbzfe.com 4000</code>
                    </div>
                    <div>
                        <p style="color: var(--text-gray); margin-bottom: 0.5rem;">Alternative (nc/netcat):</p>
                        <code>nc dbzfe.com 4000</code>
                    </div>
                </div>
                
                <h4 style="color: #5865f2; margin-bottom: 1rem;">💬 Get Help & Support:</h4>
                <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
                    <a href="https://discord.gg/QynAjm2axA" target="_blank" class="option-btn discord-btn">
                        <i class="fab fa-discord"></i> Join Discord Community
                    </a>
                </div>
            </div>
        `;

        this.output.appendChild(optionsContainer);
        this.scrollToBottom();

        // Add CSS for option buttons
        const style = document.createElement('style');
        style.textContent = `
            .option-btn {
                display: inline-flex;
                align-items: center;
                gap: 0.5rem;
                padding: 0.8rem 1.5rem;
                background: var(--gradient-fire);
                color: var(--dark-bg);
                text-decoration: none;
                border-radius: 8px;
                font-weight: 600;
                transition: all 0.3s ease;
                margin: 0.25rem;
                font-size: 0.95rem;
            }
            .option-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 107, 26, 0.4);
            }
            .discord-btn {
                background: linear-gradient(135deg, #5865f2, #7289da) !important;
                color: white !important;
                padding: 1rem 2rem;
                font-size: 1.1rem;
            }
            .discord-btn:hover {
                box-shadow: 0 5px 15px rgba(88, 101, 242, 0.4) !important;
            }
            code {
                background: rgba(255, 107, 26, 0.2);
                padding: 0.3rem 0.6rem;
                border-radius: 4px;
                font-family: 'Courier New', monospace;
                display: inline-block;
                margin: 0.2rem;
                color: var(--accent-gold);
                border: 1px solid rgba(255, 107, 26, 0.3);
            }
        `;
        document.head.appendChild(style);
    }

    initializeMapRenderer() {
        // Initialize map renderer when on play page
        if (typeof MudMapRenderer !== 'undefined') {
            try {
                this.mapRenderer = new MudMapRenderer();
                console.log('🗺️ Map renderer initialized successfully');
                
                // Add a test method to global scope for debugging
                window.testMapRenderer = () => {
                    const testMapData = `Where: (1G) Earth (Moon Cycle: Third Quarter)
...".."........"......... [6]
......".."........".."... [5]
.......".."".....~....~.. [4]
........"............~... [3]
.......".............~~.. [2]
.........".............. [1]
........."........"...... [1]
......."."........~~..... [1]
....".....~~....~......~. [2]
..~..........~..~.~....~. [3]
..~~........~....~.....~. [4]
..~........~..~........~. [5]
..~.........~.........~.. [6]

Location: south -125.105
Nearby: Fat Buu  
Exits: north south east west nw ne sw se`;
                    
                    console.log('🧪 Testing minimap renderer with sample data');
                    this.checkForMapData(testMapData);
                    
                    // Also display a message in the terminal
                    this.addToOutput('🗺️ Sample map data loaded into minimap!', 'info');
                };
                
            } catch (error) {
                console.log('Failed to initialize map renderer:', error);
            }
        } else {
            // Try again after a delay if map renderer isn't loaded yet
            setTimeout(() => this.initializeMapRenderer(), 1000);
        }
    }

    checkForMapData(text) {
        // Detect if this output contains map data
        if (this.mapRenderer && this.isMapOutput(text)) {
            console.log('🗺️ Map data detected, rendering...');
            this.mapRenderer.parseMapData(text);
            
            // Note: Location info is now handled inside parseMapData via extractLocationInfo
            // No need to duplicate the logic here
        }
    }

    isMapOutput(text) {
        // Check if the text contains map-like patterns
        // Remove HTML tags first for better detection
        const cleanText = text.replace(/<[^>]*>/g, '');
        
        const mapIndicators = [
            // Contains coordinate patterns with brackets
            /\[\d+\]/,
            // Contains map characters (multiple dots, tildes, quotes in sequence)
            /[.~"]{8,}/,
            // Contains "Where:" with coordinates
            /Where:\s*\([^)]+\)/i,
            // Contains multiple lines with map-like patterns
            /\..*\n.*[.~"]/,
            // Look for multiple sequential map characters
            /[.]{4,}|[~]{3,}|["].*["]/
        ];
        
        return mapIndicators.some(pattern => pattern.test(cleanText));
    }

    updateAutoLookButton() {
        if (this.autoLookBtn) {
            this.autoLookBtn.textContent = this.autoLookEnabled ? '🗺️ Auto: ON' : '🗺️ Auto: OFF';
            this.autoLookBtn.className = this.autoLookEnabled ? 'minimap-btn auto-look-btn enabled' : 'minimap-btn auto-look-btn disabled';
        }
    }
}

// Initialize the Telnet client when the page loads
document.addEventListener('DOMContentLoaded', function() {
    // Only initialize if we're on the play page
    if (document.getElementById('connectBtn')) {
        window.telnetClient = new TelnetClient();
        
        // Add welcome messages
        setTimeout(() => {
            window.telnetClient.addToOutput('Dragon Ball Z: Fighter\'s Edition Telnet Client', 'info');
            window.telnetClient.addToOutput('Server: dbzfe.com:4000', 'info');
            window.telnetClient.addToOutput('Click "Connect to Game" to attempt direct connection.', 'info');
            window.telnetClient.addToOutput('If connection fails, use the alternative methods provided.', 'info');
        }, 1000);
    }
});

// Export for global access
window.TelnetClient = TelnetClient; 