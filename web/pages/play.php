<div class="play-container">
    <div class="play-header">
        <h1>🐉 Enter the Dragon Ball Z Universe</h1>
        <p>Connect directly to the game server and begin your adventure!</p>
    </div>
    
    <div class="connection-panel">
        <div class="connection-status">
            <span class="status-indicator" id="connectionStatus">🔴 Disconnected</span>
            <div class="connection-controls">
                <button id="connectBtn" class="connect-btn">
                    <i class="fas fa-play"></i> Connect to Game
                </button>
                <button id="disconnectBtn" class="disconnect-btn" style="display: none;">
                    <i class="fas fa-stop"></i> Disconnect
                </button>
            </div>
        </div>
        
        <div class="server-info">
            <div class="server-details">
                <span class="server-label">Server:</span>
                <span class="server-address" id="serverAddress">dbzfe.com:4000</span>
            </div>
            <div class="connection-settings">
                <input type="text" id="serverHost" placeholder="Server Host" value="dbzfe.com">
                <input type="number" id="serverPort" placeholder="Port" value="4000" min="1" max="65535">
                <button id="updateServer" class="update-btn">Update</button>
            </div>
        </div>
    </div>
    
    <div class="terminal-container">
        <div class="terminal-header">
            <div class="terminal-controls">
                <span class="control-dot control-red"></span>
                <span class="control-dot control-yellow"></span>
                <span class="control-dot control-green"></span>
            </div>
            <div class="terminal-title">Dragon Ball Z: Fighter's Edition Terminal</div>
            <div class="terminal-actions">
                <button id="clearTerminal" class="action-btn" title="Clear Terminal">
                    <i class="fas fa-trash"></i>
                </button>
                <button id="fullscreenTerminal" class="action-btn" title="Fullscreen">
                    <i class="fas fa-expand"></i>
                </button>
            </div>
        </div>
        
        <div class="game-layout">
            <div class="terminal-section">
                <div class="terminal" id="terminal">
                    <div class="terminal-output" id="output">
                        <div class="welcome-message">
                            <pre>
╔══════════════════════════════════════════════════════════════════╗
║                🐉 DRAGON BALL Z: FIGHTER'S EDITION 🐉                ║
║                                                                  ║
║                    Web Terminal Client v1.0                     ║
║                                                                  ║
║                 Click "Connect to Game" to begin!               ║
╚══════════════════════════════════════════════════════════════════╝
                            </pre>
                        </div>
                    </div>
                    <div class="terminal-input-line">
                        <span class="terminal-prompt">></span>
                        <input type="text" id="commandInput" class="terminal-input" placeholder="Enter command..." autocomplete="off" disabled>
                    </div>
                </div>
            </div>
            
            <div class="minimap-section">
                <div class="minimap-header">
                    <h4>🗺️ World Map</h4>
                    <div class="minimap-controls">
                        <button id="autoLookBtn" class="minimap-btn auto-look-btn disabled" title="Toggle Auto-Map Updates">🗺️ Auto: OFF</button>
                        <button id="minimapFullscreen" class="minimap-btn" title="Fullscreen Map">🔍</button>
                    </div>
                </div>
                <div class="minimap-container">
                    <canvas id="minimapCanvas" width="300" height="250"></canvas>
                </div>
                <div class="minimap-info">
                    <div class="location-display">
                        <span id="minimapLocation">Location: Unknown</span>
                        <span id="minimapCoords">Coords: 0, 0</span>
                    </div>
                </div>
                <div class="minimap-legend">
                    <div class="legend-grid">
                        <span class="legend-item"><span class="terrain-mini plains"></span>Plains</span>
                        <span class="legend-item"><span class="terrain-mini water"></span>Water</span>
                        <span class="legend-item"><span class="terrain-mini river"></span>River</span>
                        <span class="legend-item"><span class="terrain-mini mountain"></span>Mountain</span>
                        <span class="legend-item"><span class="terrain-mini tree"></span>Tree</span>
                        <span class="legend-item"><span class="terrain-mini sand"></span>Sand</span>
                        <span class="legend-item"><span class="terrain-mini safe"></span>Safe Zone</span>
                        <span class="legend-item"><span class="terrain-mini building"></span>Building</span>
                        <span class="legend-item"><span class="terrain-mini road"></span>Road</span>
                        <span class="legend-item"><span class="terrain-mini special"></span>Special</span>
                        <span class="legend-item"><span class="terrain-mini exit"></span>Exit</span>
                        <span class="legend-item"><span class="terrain-mini player"></span>You</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="quick-commands">
        <h3>Quick Commands</h3>
        <div class="command-buttons">
            <button class="quick-cmd" data-cmd="look">Look</button>
            <button class="quick-cmd" data-cmd="look" title="Refresh Map">🗺️ Map</button>
            <button class="quick-cmd" data-cmd="who">Who</button>
            <button class="quick-cmd" data-cmd="score">Score</button>
            <button class="quick-cmd" data-cmd="inventory">Inventory</button>
            <button class="quick-cmd" data-cmd="help">Help</button>
            <button class="quick-cmd" data-cmd="quit">Quit</button>
        </div>
    </div>
</div>

<style>
.play-container {
    max-width: 1400px;
    margin: 0 auto;
    padding: 2rem;
}

.play-header {
    text-align: center;
    margin-bottom: 2rem;
}

.play-header h1 {
    font-size: 2.5rem;
    color: var(--primary-orange);
    text-shadow: 0 0 15px rgba(255, 107, 26, 0.6);
    margin-bottom: 1rem;
}

.play-header p {
    font-size: 1.2rem;
    color: var(--text-gray);
}

.connection-panel {
    background: rgba(20, 20, 30, 0.9);
    border: 1px solid var(--primary-orange);
    border-radius: 12px;
    padding: 1.5rem;
    margin-bottom: 2rem;
}

.connection-status {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
}

.status-indicator {
    font-size: 1.1rem;
    font-weight: 600;
    padding: 0.5rem 1rem;
    background: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
}

.connection-controls {
    display: flex;
    gap: 1rem;
}

.connect-btn, .disconnect-btn {
    padding: 0.8rem 1.5rem;
    border: none;
    border-radius: 8px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

.connect-btn {
    background: linear-gradient(135deg, #4caf50, #45a049);
    color: white;
}

.connect-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(76, 175, 80, 0.4);
}

.disconnect-btn {
    background: linear-gradient(135deg, #f44336, #da190b);
    color: white;
}

.disconnect-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(244, 67, 54, 0.4);
}

.server-info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    flex-wrap: wrap;
    gap: 1rem;
}

.server-details {
    color: var(--text-gray);
}

.server-label {
    font-weight: 600;
    margin-right: 0.5rem;
}

.server-address {
    color: var(--accent-gold);
    font-family: 'Courier New', monospace;
}

.connection-settings {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

.connection-settings input {
    padding: 0.5rem;
    border: 1px solid rgba(255, 107, 26, 0.3);
    border-radius: 4px;
    background: rgba(0, 0, 0, 0.3);
    color: var(--text-light);
    font-size: 0.9rem;
}

.update-btn {
    padding: 0.5rem 1rem;
    background: var(--primary-orange);
    color: var(--dark-bg);
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-weight: 600;
    transition: all 0.3s ease;
}

.update-btn:hover {
    background: var(--accent-gold);
    transform: translateY(-1px);
}

.terminal-container {
    background: #000;
    border: 2px solid var(--primary-orange);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 0 30px rgba(255, 107, 26, 0.3);
    margin-bottom: 2rem;
}

.terminal-header {
    background: rgba(20, 20, 30, 0.95);
    padding: 1rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid var(--primary-orange);
}

.terminal-controls {
    display: flex;
    gap: 0.5rem;
}

.control-dot {
    width: 12px;
    height: 12px;
    border-radius: 50%;
}

.control-red { background: #ff5f57; }
.control-yellow { background: #ffbd2e; }
.control-green { background: #28ca42; }

.terminal-title {
    color: var(--accent-gold);
    font-weight: 600;
    font-family: 'Orbitron', sans-serif;
}

.terminal-actions {
    display: flex;
    gap: 0.5rem;
}

.action-btn {
    background: none;
    border: 1px solid rgba(255, 107, 26, 0.5);
    color: var(--primary-orange);
    padding: 0.3rem 0.5rem;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.3s ease;
}

.action-btn:hover {
    background: var(--primary-orange);
    color: var(--dark-bg);
}

.terminal {
    background: #000;
    color: #00ff00;
    font-family: 'Courier New', monospace;
    font-size: 14px;
    line-height: 1.4;
    height: 500px;
    display: flex;
    flex-direction: column;
}

.terminal-output {
    flex: 1;
    padding: 1rem;
    overflow-y: auto;
    scrollbar-width: thin;
    scrollbar-color: var(--primary-orange) #000;
}

.terminal-output::-webkit-scrollbar {
    width: 8px;
}

.terminal-output::-webkit-scrollbar-track {
    background: #000;
}

.terminal-output::-webkit-scrollbar-thumb {
    background: var(--primary-orange);
    border-radius: 4px;
}

.welcome-message {
    color: var(--accent-gold);
    text-align: center;
    margin: 2rem 0;
}

.terminal-input-line {
    display: flex;
    align-items: center;
    padding: 0.5rem 1rem;
    border-top: 1px solid #333;
    background: #111;
}

.terminal-prompt {
    color: var(--primary-orange);
    margin-right: 0.5rem;
    font-weight: bold;
}

.terminal-input {
    flex: 1;
    background: transparent;
    border: none;
    color: #00ff00;
    font-family: 'Courier New', monospace;
    font-size: 14px;
    outline: none;
}

.terminal-input:disabled {
    opacity: 0.5;
}

.quick-commands {
    background: rgba(20, 20, 30, 0.9);
    border: 1px solid rgba(255, 107, 26, 0.3);
    border-radius: 12px;
    padding: 1.5rem;
}

.quick-commands h3 {
    color: var(--primary-orange);
    margin-bottom: 1rem;
    font-family: 'Orbitron', sans-serif;
}

.command-buttons {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
}

.quick-cmd {
    padding: 0.5rem 1rem;
    background: rgba(255, 107, 26, 0.1);
    border: 1px solid var(--primary-orange);
    color: var(--primary-orange);
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    font-weight: 500;
}

.quick-cmd:hover {
    background: var(--primary-orange);
    color: var(--dark-bg);
    transform: translateY(-1px);
}

.terminal.fullscreen {
    position: fixed;
    top: 0;
    left: 0;
    width: 100vw;
    height: 100vh;
    z-index: 9999;
    border-radius: 0;
}

@media (max-width: 768px) {
    .play-container {
        padding: 1rem;
    }
    
    .connection-status,
    .server-info {
        flex-direction: column;
        align-items: stretch;
    }
    
    .connection-settings {
        justify-content: center;
        margin-top: 1rem;
    }
    
    .terminal {
        height: 400px;
    }
    
    .command-buttons {
        justify-content: center;
    }
}

/* Animation for connection status */
@keyframes pulse {
    0%, 100% { opacity: 1; }
    50% { opacity: 0.5; }
}

.status-connecting {
    animation: pulse 1s infinite;
}

/* Game Layout - Terminal and Minimap Side by Side */
.game-layout {
    display: flex;
    gap: 1rem;
    flex: 1;
}

.terminal-section {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.minimap-section {
    width: 320px;
    background: rgba(20, 20, 30, 0.95);
    border: 1px solid var(--primary-orange);
    border-radius: 8px;
    padding: 1rem;
    display: flex;
    flex-direction: column;
}

.minimap-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 0.5rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid rgba(255, 107, 26, 0.3);
}

.minimap-header h4 {
    color: var(--primary-orange);
    margin: 0;
    font-family: 'Orbitron', sans-serif;
    font-size: 1rem;
}

.minimap-controls {
    display: flex;
    gap: 0.25rem;
}

.minimap-btn {
    background: rgba(255, 107, 26, 0.2);
    border: 1px solid var(--primary-orange);
    color: var(--primary-orange);
    padding: 0.25rem 0.5rem;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.8rem;
    transition: all 0.3s ease;
}

.minimap-btn:hover {
    background: var(--primary-orange);
    color: var(--dark-bg);
}

.auto-look-btn.enabled {
    background: rgba(0, 255, 0, 0.2);
    border-color: #00ff00;
    color: #00ff00;
}

.auto-look-btn.enabled:hover {
    background: #00ff00;
    color: var(--dark-bg);
}

.auto-look-btn.disabled {
    background: rgba(255, 0, 0, 0.2);
    border-color: #ff0000;
    color: #ff0000;
}

.auto-look-btn.disabled:hover {
    background: #ff0000;
    color: var(--dark-bg);
}

.minimap-container {
    margin-bottom: 0.5rem;
    border: 1px solid rgba(255, 107, 26, 0.5);
    border-radius: 4px;
    overflow: hidden;
}

#minimapCanvas {
    display: block;
    width: 100%;
    height: auto;
    background: #000;
}

.minimap-info {
    margin-bottom: 0.5rem;
}

.location-display {
    background: rgba(0, 0, 0, 0.5);
    padding: 0.5rem;
    border-radius: 4px;
    font-size: 0.85rem;
}

.location-display span {
    display: block;
    margin-bottom: 0.25rem;
    font-family: 'Courier New', monospace;
    color: var(--text-light);
}

.minimap-legend {
    background: rgba(0, 0, 0, 0.5);
    padding: 0.5rem;
    border-radius: 4px;
}

.legend-grid {
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    gap: 0.25rem;
    font-size: 0.75rem;
}

.legend-item {
    display: flex;
    align-items: center;
    color: var(--text-light);
}

.terrain-mini {
    width: 10px;
    height: 10px;
    margin-right: 0.25rem;
    border: 1px solid #333;
    display: inline-block;
}

.terrain-mini.plains { background-color: #2d5a2d; }
.terrain-mini.water { background-color: #1e3a8a; }
.terrain-mini.river { background-color: #00ffff; }
.terrain-mini.mountain { background-color: #8b4513; }
.terrain-mini.tree { background-color: #228b22; }
.terrain-mini.sand { background-color: #daa520; }
.terrain-mini.safe { background-color: #ffff66; }
.terrain-mini.building { background-color: #dc143c; }
.terrain-mini.road { background-color: #696969; }
.terrain-mini.special { background-color: #ff6b1a; }
.terrain-mini.exit { background-color: #ffd700; }
.terrain-mini.player { 
    background-color: #ff0000; 
    border: 2px solid #ffffff;
    border-radius: 50%;
    position: relative;
}
.terrain-mini.player::after {
    content: 'P';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    font-size: 8px;
    font-weight: bold;
}

/* Responsive Design */
@media (max-width: 1024px) {
    .game-layout {
        flex-direction: column;
    }
    
    .minimap-section {
        width: 100%;
        order: -1; /* Show map above terminal on mobile */
    }
    
    #minimapCanvas {
        height: 200px;
    }
}

@media (max-width: 768px) {
    .minimap-section {
        padding: 0.5rem;
    }
    
    .legend-grid {
        grid-template-columns: 1fr;
    }
}
</style>

<script src="map-renderer.js"></script>
<script src="mud-client.js"></script>
<script src="update-mud-client-config.js"></script>
<script src="bridge-status-checker.js"></script>
