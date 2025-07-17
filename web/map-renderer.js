/* ===================================
   Dragon Ball Z MUD Map Renderer
   Converts ASCII maps to graphical display
   =================================== */

class MudMapRenderer {
    constructor() {
        this.mapData = [];
        this.canvas = null;
        this.ctx = null;
        this.tileSize = 16;
        this.playerPosition = { x: 0, y: 0 };
        this.isVisible = false;
        
        // Define terrain types based on actual DBZ MUD source code
        // Format: character -> {color, name, description, planet}
        this.terrainTypes = {
            // === BASIC TERRAIN (Universal) ===
            '.': { color: '#2d5a2d', name: 'Plains', char: '.', desc: 'Grassy plains' },
            '~': { color: '#1e3a8a', name: 'Water', char: '~', desc: 'Deep water' },
            '"': { color: '#8b4513', name: 'River', char: '"', desc: 'Flowing river' },
            '*': { color: '#ff6b1a', name: 'Special', char: '*', desc: 'Special location' },
            ' ': { color: '#000000', name: 'Void', char: ' ', desc: 'Empty space' },
            'X': { color: '#ff0000', name: 'Player', char: 'X', desc: 'Your location' },
            
            // === EARTH TERRAIN ===
            // Earth grass: {g.{x (green dot)
            'g.': { color: '#00ff00', name: 'Earth Grass', char: '.', desc: 'Lush Earth grasslands' },
            // Earth water: {b~{x (blue tilde)  
            'b~': { color: '#0000ff', name: 'Earth Water', char: '~', desc: 'Earth ocean water' },
            // Earth river: {C"{x (cyan quote)
            'C"': { color: '#00ffff', name: 'Earth River', char: '"', desc: 'Earth river system' },
            // Earth mountain: {g^{x (green caret)
            'g^': { color: '#008000', name: 'Earth Mountain', char: '^', desc: 'Earth mountain range' },
            // Earth sand: {y.{x (yellow dot)
            'y.': { color: '#ffff00', name: 'Earth Sand', char: '.', desc: 'Earth desert sand' },
            // Earth safe zone: {Y'{x (bright yellow apostrophe)
            "Y'": { color: '#ffff66', name: 'Safe Zone', char: "'", desc: 'Protected safe area' },
            // Earth clouds: {W~{x (white tilde)
            'W~': { color: '#ffffff', name: 'Clouds', char: '~', desc: 'Sky clouds' },
            // Earth snow mountain: {W^{x (white caret)
            'W^': { color: '#ffffff', name: 'Snow Mountain', char: '^', desc: 'Snow-capped peaks' },
            
            // === NAMEK TERRAIN ===
            // Namek grass: {C.{x (cyan dot)
            'C.': { color: '#00ffff', name: 'Namek Grass', char: '.', desc: 'Cyan Namekian grasslands' },
            // Namek water: {g~{x (green tilde)
            'g~': { color: '#00ff00', name: 'Namek Water', char: '~', desc: 'Green Namekian seas' },
            // Namek tree: {g@{x (green at symbol)
            'g@': { color: '#00ff00', name: 'Namek Tree', char: '@', desc: 'Large Namekian tree' },
            // Namek tree base: {y|{x (yellow pipe)
            'y|': { color: '#ffff00', name: 'Tree Base', char: '|', desc: 'Namekian tree trunk' },
            // Namek mountain: {y^{x (yellow caret)
            'y^': { color: '#ffff00', name: 'Namek Mountain', char: '^', desc: 'Yellow Namekian peaks' },
            // Namek safe zone: {Y.{x (bright yellow dot)
            'Y.': { color: '#ffff66', name: 'Namek Safe Zone', char: '.', desc: 'Namekian safe area' },
            
            // === VEGETA TERRAIN ===
            // Vegeta ground: {y'{x (yellow apostrophe)
            "y'": { color: '#ffff00', name: 'Vegeta Ground', char: "'", desc: 'Saiyan homeworld terrain' },
            // Vegeta water: {r~{x (red tilde)
            'r~': { color: '#ff0000', name: 'Vegeta Water', char: '~', desc: 'Red Saiyan seas' },
            // Vegeta river: {M"{x (bright magenta quote)
            'M"': { color: '#ff00ff', name: 'Vegeta River', char: '"', desc: 'Vegeta river system' },
            // Vegeta mountain: {r^{x (red caret)
            'r^': { color: '#ff0000', name: 'Vegeta Mountain', char: '^', desc: 'Red Saiyan mountains' },
            
            // === FRIEZA PLANET TERRAIN ===
            // Frieza sand: {w.{x (white dot)
            'w.': { color: '#ffffff', name: 'Ice Sand', char: '.', desc: 'Frozen ice particles' },
            // Frieza grass: {W,{x (bright white comma)
            'W,': { color: '#ffffff', name: 'Ice Grass', char: ',', desc: 'Frozen vegetation' },
            // Frieza water: {m~{x (magenta tilde)
            'm~': { color: '#ff00ff', name: 'Ice Water', char: '~', desc: 'Frigid purple seas' },
            // Frieza river: {M~{x (bright magenta tilde)
            'M~': { color: '#ff66ff', name: 'Ice River', char: '~', desc: 'Frozen river system' },
            // Frieza mountain: {r^{x (red caret)
            // 'r^' already defined above for Vegeta
            
            // === KAISHIN TERRAIN ===
            // Kaishin water: {m~{x (magenta tilde)
            // 'm~' already defined above for Frieza
            // Kaishin mountain: {c^{x (cyan caret)
            'c^': { color: '#00ffff', name: 'Kaishin Mountain', char: '^', desc: 'Sacred realm peaks' },
            // Kaishin grass: {C,{x (cyan comma)
            'C,': { color: '#00ffff', name: 'Kaishin Grass', char: ',', desc: 'Divine realm vegetation' },
            // Kaishin flowers: {M@{x (bright magenta at symbol)
            'M@': { color: '#ff66ff', name: 'Sacred Flowers', char: '@', desc: 'Divine flowers' },
            // Kaishin fruit: {Ro{x (bright red o)
            'Ro': { color: '#ff6666', name: 'Kai Fruit', char: 'o', desc: 'Sacred fruit trees' },
            
            // === ARLIA TERRAIN ===
            // Arlia ground: {y,{x (yellow comma)
            'y,': { color: '#ffff00', name: 'Arlia Ground', char: ',', desc: 'Arlian desert terrain' },
            // Arlia water: {r~{x (red tilde) - same as Vegeta
            // Arlia mountain: {y^{x (yellow caret) - same as Namek
            
            // === SPACE TERRAIN ===
            // Space: various colored dots and stars
            'Y*': { color: '#ffff00', name: 'Yellow Star', char: '*', desc: 'Distant yellow star' },
            'B*': { color: '#0000ff', name: 'Blue Star', char: '*', desc: 'Distant blue star' },
            'R*': { color: '#ff0000', name: 'Red Star', char: '*', desc: 'Distant red star' },
            'W*': { color: '#ffffff', name: 'White Star', char: '*', desc: 'Bright white star' },
            'W.': { color: '#ffffff', name: 'Space Dust', char: '.', desc: 'Cosmic dust' },
            
            // === SPECIAL BUILDINGS ===
            // Arena: {RA{x (bright red A)
            'RA': { color: '#ff6666', name: 'Arena', char: 'A', desc: 'Fighting arena' },
            // Gero Lab: {RL{x (bright red L)
            'RL': { color: '#ff6666', name: 'Dr. Gero Lab', char: 'L', desc: 'Android laboratory' },
            // Korin Tower: {YH{x (bright yellow H)
            'YH': { color: '#ffff66', name: 'Korin Tower', char: 'H', desc: 'Sacred tower' },
            // HBTC: {C%{x (cyan percent)
            'C%': { color: '#00ffff', name: 'HBTC', char: '%', desc: 'Hyperbolic Time Chamber' },
            // Exit: {RE{x (bright red E)
            'RE': { color: '#ff6666', name: 'Exit', char: 'E', desc: 'Area exit' },
            
            // === ROADS AND STRUCTURES ===
            // King Kai road: {W#{x (white hash)
            'W#': { color: '#ffffff', name: 'Sacred Road', char: '#', desc: 'King Kai planet road' },
            // Sidewalk: | (pipe)
            '|': { color: '#808080', name: 'Wall/Pillar', char: '|', desc: 'Structural wall' },
            '_': { color: '#808080', name: 'Floor/Path', char: '_', desc: 'Walkway or floor' },
            '-': { color: '#808080', name: 'Bridge/Path', char: '-', desc: 'Bridge or pathway' },
            
            // === NUMERIC EXITS (Coordinates) ===
            '1': { color: '#ffd700', name: 'Exit North', char: '1', desc: 'Northern exit' },
            '2': { color: '#ffd700', name: 'Exit South', char: '2', desc: 'Southern exit' },
            '3': { color: '#ffd700', name: 'Exit East', char: '3', desc: 'Eastern exit' },
            '4': { color: '#ffd700', name: 'Exit West', char: '4', desc: 'Western exit' },
            '5': { color: '#ffd700', name: 'Exit NE', char: '5', desc: 'Northeast exit' },
            '6': { color: '#ffd700', name: 'Exit NW', char: '6', desc: 'Northwest exit' },
            '7': { color: '#ffd700', name: 'Exit SE', char: '7', desc: 'Southeast exit' },
            '8': { color: '#ffd700', name: 'Exit SW', char: '8', desc: 'Southwest exit' },
            '9': { color: '#ffd700', name: 'Exit Up', char: '9', desc: 'Upward exit' },
            '0': { color: '#ffd700', name: 'Exit Down', char: '0', desc: 'Downward exit' },
            
            // === FALLBACK CHARACTERS ===
            // Default mappings for common characters when color codes aren't detected
            '^': { color: '#8b4513', name: 'Mountain', char: '^', desc: 'Mountain peak' },
            '@': { color: '#228b22', name: 'Tree', char: '@', desc: 'Large tree' },
            ',': { color: '#daa520', name: 'Ground', char: ',', desc: 'Rough terrain' },
            '#': { color: '#696969', name: 'Wall/Road', char: '#', desc: 'Solid structure' },
            '%': { color: '#4169e1', name: 'Special Area', char: '%', desc: 'Unique location' },
            'o': { color: '#ff4500', name: 'Object', char: 'o', desc: 'Special object' },
            'L': { color: '#dc143c', name: 'Building', char: 'L', desc: 'Large building' },
            'H': { color: '#daa520', name: 'Tower', char: 'H', desc: 'High structure' },
            'A': { color: '#dc143c', name: 'Arena', char: 'A', desc: 'Combat area' },
            'E': { color: '#dc143c', name: 'Exit', char: 'E', desc: 'Area exit' }
        };
        
        this.initializeMapDisplay();
    }

    initializeMapDisplay() {
        // The minimap is now part of the page layout, so we just need to get references
        this.canvas = document.getElementById('minimapCanvas');
        if (this.canvas) {
            this.ctx = this.canvas.getContext('2d');
            this.isVisible = true; // Always visible now
            
            // Bind events
            this.bindEvents();
            
            console.log('🗺️ Minimap initialized');
        } else {
            console.log('🗺️ Minimap canvas not found, will retry...');
            // Retry after a delay if canvas isn't available yet
            setTimeout(() => this.initializeMapDisplay(), 1000);
        }
    }

    bindEvents() {
        // Fullscreen toggle for minimap
        const fullBtn = document.getElementById('minimapFullscreen');
        if (fullBtn) {
            fullBtn.addEventListener('click', () => this.toggleFullscreen());
        }
        
        // Canvas click events
        if (this.canvas) {
            this.canvas.addEventListener('click', (e) => this.onMapClick(e));
            this.canvas.addEventListener('mousemove', (e) => this.onMapHover(e));
        }
    }

    parseMapData(textOutput) {
        // Clean the text first - remove HTML tags and ANSI codes thoroughly
        let cleanText = textOutput.replace(/<[^>]*>/g, '');
        
        // Strip ANSI color codes more comprehensively
        cleanText = cleanText.replace(/\x1b\[[0-9;]*[a-zA-Z]/g, '');
        cleanText = cleanText.replace(/\[[0-9;]*[a-zA-Z]/g, '');
        cleanText = cleanText.replace(/\[[\d;]+m/g, '');
        cleanText = cleanText.replace(/\[\d+m/g, '');
        
        const lines = cleanText.split('\n');
        const mapLines = [];
        let foundMapStart = false;
        let foundMapEnd = false;
        
        console.log('🗺️ === NEW MAP PARSING SESSION ===');
        console.log('🗺️ Parsing map data from:', lines.length, 'lines');
        console.log('🗺️ Raw text sample:', textOutput.substring(0, 300) + '...');
        
        // Clear any existing map data
        this.clearMapData();
        
        for (let i = 0; i < lines.length; i++) {
            const line = lines[i].trim();
            
            // Skip empty lines
            if (!line) continue;
            
            // Skip header lines (Where: information)
            if (line.toLowerCase().includes('where:') || 
                line.toLowerCase().includes('moon cycle') ||
                line.toLowerCase().includes('day cycle')) {
                console.log('🗺️ Skipping header line:', line);
                continue;
            }
            
            // Stop processing when we hit location info or other metadata
            if (foundMapStart && (
                line.toLowerCase().includes('location:') || 
                line.toLowerCase().includes('nearby:') || 
                line.toLowerCase().includes('exits:') ||
                line.toLowerCase().includes('room name:') ||
                line.toLowerCase().includes('description:') ||
                line.match(/^[a-zA-Z\s]+:/) // General pattern for "word:"
            )) {
                console.log('🗺️ Found map end at line:', line);
                foundMapEnd = true;
                break;
            }
            
            // Look for lines that contain map data - BE MORE AGGRESSIVE
            // Include ANY line that has coordinate brackets [number]
            const hasCoordinate = /\[\d+\]/.test(line);
            
            // Also look for lines with lots of dots, tildes, or other map chars
            const hasMapChars = /[.~"^@*|,#'%oLHAE_\-]{3,}/.test(line);
            
            // Or lines that look like they contain ASCII art patterns
            const hasPatterns = /[.~"^@*|,#'%oLHAE_\-\s]{10,}/.test(line);
            
            // Accept line if it has coordinates OR looks like map data
            const isMapLine = hasCoordinate || (foundMapStart && (hasMapChars || hasPatterns));
            
            // Debug: log ALL potential map lines
            if (hasCoordinate || hasMapChars || hasPatterns) {
                console.log('🗺️ ANALYZING LINE:');
                console.log('  - Line:', line);
                console.log('  - hasCoordinate:', hasCoordinate);
                console.log('  - hasMapChars:', hasMapChars);
                console.log('  - hasPatterns:', hasPatterns);
                console.log('  - isMapLine:', isMapLine);
                console.log('  - Characters:', [...line].map(c => c === ' ' ? '␣' : c).join(''));
            }
            
            // Start detecting map when we see a line with coordinates
            if (hasCoordinate) {
                foundMapStart = true;
                console.log('🗺️ Map parsing STARTED at line:', line);
            }
            
            // Add line if it looks like a map line and we haven't found the end
            if (isMapLine && !foundMapEnd) {
                // Remove the coordinate part [6], [5], etc. and clean up
                let cleanLine = line.replace(/\s*\[\d+\]\s*$/, '');
                cleanLine = cleanLine.trim();
                
                if (cleanLine.length > 0) {
                    mapLines.push(cleanLine);
                    console.log('🗺️ MAP LINE ADDED:', cleanLine);
                    console.log('🗺️ Line length:', cleanLine.length);
                    console.log('🗺️ All characters:', [...cleanLine].map((c, i) => `${i}:'${c === ' ' ? '␣' : c}'`).join(' '));
                    console.log('🗺️ Unique chars:', [...new Set(cleanLine.split(''))].sort().join(''));
                }
            } else if (hasCoordinate) {
                console.log('🗺️ SKIPPED coordinate line (foundMapEnd?):', foundMapEnd, 'Line:', line);
            }
        }
        
        console.log('🗺️ FINAL RESULT: Found', mapLines.length, 'map lines total');
        console.log('🗺️ All collected map lines:');
        mapLines.forEach((line, i) => {
            console.log(`  ${i}: "${line}"`);
        });
        
        if (mapLines.length > 0) {
            this.processMapLines(mapLines);
            this.renderMap();
            this.showMap();
            
            // Extract location information separately 
            this.extractLocationInfo(textOutput);
        } else {
            console.log('🗺️ NO MAP DATA FOUND - debugging all lines:');
            lines.forEach((line, i) => {
                if (line.trim()) {
                    console.log(`  ${i}: "${line.trim()}"`);
                }
            });
        }
        
        console.log('🗺️ === MAP PARSING COMPLETE ===');
    }

    clearMapData() {
        // Clear existing map data to prevent artifacts
        this.mapData = [];
        console.log('🗺️ Cleared previous map data');
        
        // Clear the canvas
        if (this.ctx) {
            this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
            console.log('🗺️ Cleared canvas');
        }
    }

    extractLocationInfo(textOutput) {
        // Extract location information from the output text
        let cleanText = textOutput.replace(/<[^>]*>/g, '');
        
        // Strip ANSI color codes more thoroughly
        cleanText = cleanText.replace(/\x1b\[[0-9;]*[a-zA-Z]/g, '');
        cleanText = cleanText.replace(/\[[0-9;]*[a-zA-Z]/g, '');
        cleanText = cleanText.replace(/\[[\d;]+m/g, '');
        
        const lines = cleanText.split('\n');
        
        let location = 'Unknown';
        let coordinates = 'Unknown';
        
        for (const line of lines) {
            const cleanLine = line.trim();
            
            // Look for location information
            const locationMatch = cleanLine.match(/Location:\s*(.+)/i);
            if (locationMatch) {
                let locationText = locationMatch[1].trim();
                
                // Strip any remaining color codes from location text
                locationText = locationText.replace(/\x1b\[[0-9;]*[a-zA-Z]/g, '');
                locationText = locationText.replace(/\[[0-9;]*[a-zA-Z]/g, '');
                locationText = locationText.replace(/\[[\d;]+m/g, '');
                
                console.log('🗺️ Found location text:', locationText);
                
                // Try different coordinate patterns
                // Pattern 1: "east -112.128" (direction + coordinates)
                const coordsPattern1 = locationText.match(/([a-zA-Z\s]+)\s+(-?\d+\.?\d*)\s*\.?\s*(-?\d+\.?\d*)?/);
                if (coordsPattern1) {
                    location = coordsPattern1[1].trim();
                    if (coordsPattern1[3]) {
                        // Two coordinates found
                        coordinates = `${coordsPattern1[2]}, ${coordsPattern1[3]}`;
                    } else {
                        // Single coordinate, might be combined like -112.128
                        const singleCoord = coordsPattern1[2];
                        if (singleCoord.includes('.')) {
                            const parts = singleCoord.split('.');
                            if (parts.length === 2) {
                                coordinates = `${parts[0]}, ${parts[1]}`;
                            } else {
                                coordinates = singleCoord;
                            }
                        } else {
                            coordinates = singleCoord;
                        }
                    }
                } else {
                    // Pattern 2: Regular coordinate extraction
                    const coordsPattern2 = locationText.match(/(-?\d+\.?\d*)\s+(-?\d+\.?\d*)/);
                    if (coordsPattern2) {
                        coordinates = `${coordsPattern2[1]}, ${coordsPattern2[2]}`;
                        location = locationText.replace(/(-?\d+\.?\d*)\s+(-?\d+\.?\d*)/, '').trim();
                    } else {
                        location = locationText;
                    }
                }
                
                console.log('🗺️ Extracted location:', location, 'coordinates:', coordinates);
                break;
            }
        }
        
        // If we didn't find coordinates in location, look for them elsewhere
        if (coordinates === 'Unknown') {
            for (const line of lines) {
                const cleanLine = line.trim();
                const coordsMatch = cleanLine.match(/(-?\d+\.?\d*)\s+(-?\d+\.?\d*)/);
                if (coordsMatch && !cleanLine.toLowerCase().includes('where:')) {
                    coordinates = `${coordsMatch[1]}, ${coordsMatch[2]}`;
                    console.log('🗺️ Found coordinates elsewhere:', coordinates);
                    break;
                }
            }
        }
        
        // Clean up location name further
        location = location.replace(/\s+/g, ' ').trim();
        
        // Update the minimap info
        this.updateLocationInfo(location, coordinates);
    }

    processMapLines(mapLines) {
        this.mapData = [];
        
        console.log('🗺️ Processing', mapLines.length, 'map lines');
        
        for (let y = 0; y < mapLines.length; y++) {
            const line = mapLines[y];
            const row = [];
            
            console.log('🗺️ Processing line', y, ':', line);
            
            for (let x = 0; x < line.length; x++) {
                const char = line[x];
                
                // Try to detect terrain based on DBZ MUD patterns
                let terrain = this.detectTerrainType(char, line, x);
                
                row.push({
                    terrain: terrain,
                    x: x,
                    y: y,
                    char: char,
                    originalChar: char
                });
            }
            
            if (row.length > 0) {
                this.mapData.push(row);
            }
        }
        
        console.log('🗺️ Created map data with', this.mapData.length, 'rows and', this.mapData[0]?.length || 0, 'columns');
        
        // Try to detect player position
        this.detectPlayerPosition();
    }

    detectPlayerPosition() {
        // Try to find potential player position markers
        // In some MUDs, the player might be represented by special characters
        // or might be at a specific coordinate that we can calculate
        
        let playerFound = false;
        
        for (let y = 0; y < this.mapData.length; y++) {
            for (let x = 0; x < this.mapData[y].length; x++) {
                const tile = this.mapData[y][x];
                
                // Check for common player position indicators
                if (tile.char === 'X' || tile.char === 'P' || tile.char === '@' && tile.terrain === 'X') {
                    console.log('🗺️ Found potential player at:', x, y, 'char:', tile.char);
                    tile.terrain = 'X'; // Mark as player position
                    playerFound = true;
                }
            }
        }
        
        // If no player found, try to place player at center of map as fallback
        if (!playerFound && this.mapData.length > 0) {
            const centerY = Math.floor(this.mapData.length / 2);
            const centerX = Math.floor((this.mapData[0]?.length || 0) / 2);
            
            if (this.mapData[centerY] && this.mapData[centerY][centerX]) {
                console.log('🗺️ No player found, marking center as player position:', centerX, centerY);
                // Don't override the existing terrain, just note that player is here
                // We could add player rendering as an overlay later
            }
        }
    }

    detectTerrainType(char, line, position) {
        // Log for debugging
        if (char !== '.' && char !== ' ') {
            console.log('🗺️ Detecting terrain for char:', `'${char}'`, 'at position', position, 'in line:', line.substring(Math.max(0, position-2), position+3));
        }
        
        // Check for specific DBZ MUD terrain patterns first
        if (this.terrainTypes[char]) {
            return char;
        }
        
        // Try to detect based on common patterns
        switch (char) {
            case '.':
                // Could be plains, grass, sand, etc.
                return '.';
                
            case '~':
                // Water - all variations
                return '~';
                
            case '"':
                // Rivers - usually cyan or other colors
                return '"';
                
            case '^':
                // Mountains - very common in this MUD
                return '^';
                
            case '@':
                // Trees or special objects - important terrain
                return '@';
                
            case '*':
                // Special locations, items, important markers
                return '*';
                
            case '|':
                // Walls, pillars, tree trunks, vertical structures
                return '|';
                
            case ',':
                // Ground types, different from dots
                return ',';
                
            case '#':
                // Roads, walls, structures
                return '#';
                
            case "'":
                // Various ground types, planet-specific
                return "'";
                
            case '%':
                // Special areas like HBTC
                return '%';
                
            case 'o':
            case 'O':
                // Objects, fruits, buildings
                return 'o';
                
            case 'l':
            case 'L':
                // Buildings, labs
                return 'L';
                
            case 'h':
            case 'H':
                // Towers, high structures
                return 'H';
                
            case 'a':
            case 'A':
                // Arenas
                return 'A';
                
            case 'e':
            case 'E':
                // Exits
                return 'E';
                
            case '_':
                // Floors, walkways
                return '_';
                
            case '-':
                // Bridges, paths
                return '-';
                
            case ' ':
                // Void/empty space
                return ' ';
                
            case 'X':
            case 'P':
            case 'x':
            case 'p':
                // Player position markers
                return 'X';
                
            case '(':
            case ')':
            case '[':
            case ']':
            case '{':
            case '}':
                // Brackets and parentheses - treat as walls/structures
                return '|';
                
            case '=':
            case '+':
                // Lines and crosses - treat as roads/paths
                return '#';
                
            case '!':
                // Exclamation - special marker
                return '*';
                
            case '?':
                // Question mark - unknown/special
                return '*';
                
            case '$':
                // Dollar sign - valuable/special
                return '*';
                
            case '&':
                // Ampersand - special object
                return '*';
                
            case '/':
            case '\\':
                // Slashes - paths or walls
                return '-';
                
            case '<':
            case '>':
                // Arrows - directions or exits
                return 'E';
                
            default:
                // Check if it's a number (exit marker)
                if (/[0-9]/.test(char)) {
                    return char;
                }
                
                // Check for any other alphabetic characters
                if (/[a-zA-Z]/.test(char)) {
                    console.log('🗺️ Unknown alphabetic character:', `'${char}'`, '- treating as special');
                    return '*'; // Treat unknown letters as special locations
                }
                
                // Check for other symbols that might be terrain
                if (/[^\w\s]/.test(char)) {
                    console.log('🗺️ Unknown symbol:', `'${char}'`, '- treating as special');
                    return '*'; // Treat unknown symbols as special
                }
                
                // Unknown character - default to plains but log it
                console.log('🗺️ Completely unknown character:', `'${char}'`, 'code:', char.charCodeAt(0), '- defaulting to plains');
                return '.';
        }
    }

    renderMap() {
        if (!this.ctx || !this.mapData.length) return;
        
        console.log('🗺️ Rendering map with', this.mapData.length, 'rows');
        
        // Clear canvas
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
        
        // Calculate dimensions
        const mapWidth = this.mapData[0]?.length || 0;
        const mapHeight = this.mapData.length;
        
        console.log('🗺️ Map dimensions:', mapWidth, 'x', mapHeight);
        
        // Calculate tile size to fill the entire canvas (no black borders)
        const tileWidth = this.canvas.width / mapWidth;
        const tileHeight = this.canvas.height / mapHeight;
        
        console.log('🗺️ Calculated tile size:', tileWidth, 'x', tileHeight);
        
        // Render each tile to fill the entire canvas
        for (let y = 0; y < this.mapData.length; y++) {
            for (let x = 0; x < this.mapData[y].length; x++) {
                const tile = this.mapData[y][x];
                let terrainInfo = this.terrainTypes[tile.terrain];
                
                // Fallback if terrain type not found
                if (!terrainInfo) {
                    console.log('🗺️ Missing terrain type for:', `'${tile.terrain}'`, 'using fallback');
                    terrainInfo = {
                        color: '#666666', // Gray fallback
                        name: 'Unknown',
                        char: tile.terrain,
                        desc: 'Unknown terrain type'
                    };
                }
                
                const screenX = x * tileWidth;
                const screenY = y * tileHeight;
                
                // Draw tile background to fill entire tile area
                this.ctx.fillStyle = terrainInfo.color;
                this.ctx.fillRect(screenX, screenY, tileWidth, tileHeight);
                
                // Draw tile border for better visibility (thinner border)
                this.ctx.strokeStyle = '#222';
                this.ctx.lineWidth = 0.5;
                this.ctx.strokeRect(screenX, screenY, tileWidth, tileHeight);
                
                // Draw character/symbol if needed and tile is large enough
                if (tile.char !== '.' && tile.char !== ' ' && Math.min(tileWidth, tileHeight) > 8) {
                    // Use white text, but red for player position
                    this.ctx.fillStyle = tile.terrain === 'X' ? '#ff0000' : '#ffffff';
                    this.ctx.font = `bold ${Math.floor(Math.min(tileWidth, tileHeight) * 0.6)}px monospace`;
                    this.ctx.textAlign = 'center';
                    this.ctx.textBaseline = 'middle';
                    this.ctx.fillText(tile.char, screenX + tileWidth/2, screenY + tileHeight/2);
                }
                
                // Debug: log some tiles
                if (tile.char !== '.' && tile.char !== ' ' && x === 0) {
                    console.log(`🗺️ Rendered tile [${x},${y}]: '${tile.char}' as ${tile.terrain} with color ${terrainInfo.color}`);
                }
            }
        }
        
        // Draw player position indicator
        this.drawPlayerPosition(tileWidth, tileHeight);
        
        console.log('🗺️ Map rendered successfully - filling entire canvas');
    }

    drawPlayerPosition(tileWidth, tileHeight) {
        // In DBZ MUD, player doesn't show on map as a character
        // So we'll draw the player at the center of the map as an overlay
        
        const mapWidth = this.mapData[0]?.length || 0;
        const mapHeight = this.mapData.length;
        
        // Calculate center position
        const centerX = Math.floor(mapWidth / 2);
        const centerY = Math.floor(mapHeight / 2);
        
        const screenX = centerX * tileWidth;
        const screenY = centerY * tileHeight;
        
        console.log('🗺️ Drawing player at center:', centerX, centerY);
        
        // Draw player indicator - a red circle with white border
        const radius = Math.min(tileWidth, tileHeight) * 0.3;
        
        // Outer white ring
        this.ctx.beginPath();
        this.ctx.arc(screenX + tileWidth/2, screenY + tileHeight/2, radius + 2, 0, 2 * Math.PI);
        this.ctx.fillStyle = '#ffffff';
        this.ctx.fill();
        
        // Inner red circle
        this.ctx.beginPath();
        this.ctx.arc(screenX + tileWidth/2, screenY + tileHeight/2, radius, 0, 2 * Math.PI);
        this.ctx.fillStyle = '#ff0000';
        this.ctx.fill();
        
        // Player symbol
        if (radius > 6) {
            this.ctx.fillStyle = '#ffffff';
            this.ctx.font = `bold ${Math.floor(radius)}px monospace`;
            this.ctx.textAlign = 'center';
            this.ctx.textBaseline = 'middle';
            this.ctx.fillText('P', screenX + tileWidth/2, screenY + tileHeight/2);
        }
    }

    toggleMap() {
        // Not needed for minimap - it's always visible
        console.log('🗺️ Minimap toggle not applicable - always visible');
    }

    showMap() {
        // Minimap is always visible, so this doesn't need to do anything
        console.log('🗺️ Minimap is always visible');
    }

    centerOnPlayer() {
        // Re-render the map (centering logic can be added later)
        this.renderMap();
    }

    toggleFullscreen() {
        // Create a fullscreen overlay for the map
        let fullscreenOverlay = document.getElementById('map-fullscreen-overlay');
        
        if (!fullscreenOverlay) {
            // Create fullscreen overlay
            fullscreenOverlay = document.createElement('div');
            fullscreenOverlay.id = 'map-fullscreen-overlay';
            fullscreenOverlay.innerHTML = `
                <div class="fullscreen-map-container">
                    <div class="fullscreen-map-header">
                        <h2>🗺️ Dragon Ball Z World Map</h2>
                        <button id="exitFullscreenMap" class="exit-fullscreen-btn">✕ Close</button>
                    </div>
                    <canvas id="fullscreenMapCanvas" width="1000" height="700"></canvas>
                </div>
            `;
            
            // Add styles
            const style = document.createElement('style');
            style.textContent = `
                #map-fullscreen-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100vw;
                    height: 100vh;
                    background: rgba(0, 0, 0, 0.95);
                    z-index: 10000;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                
                .fullscreen-map-container {
                    background: #1a1a2e;
                    border: 2px solid var(--primary-orange);
                    border-radius: 12px;
                    padding: 1rem;
                    max-width: 90vw;
                    max-height: 90vh;
                }
                
                .fullscreen-map-header {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;
                    margin-bottom: 1rem;
                    color: var(--primary-orange);
                }
                
                .exit-fullscreen-btn {
                    background: #ff4444;
                    color: white;
                    border: none;
                    padding: 0.5rem 1rem;
                    border-radius: 6px;
                    cursor: pointer;
                    font-weight: bold;
                }
                
                #fullscreenMapCanvas {
                    border: 1px solid var(--primary-orange);
                    border-radius: 8px;
                    background: #000;
                }
            `;
            document.head.appendChild(style);
            
            document.body.appendChild(fullscreenOverlay);
            
            // Bind close event
            document.getElementById('exitFullscreenMap').addEventListener('click', () => {
                document.body.removeChild(fullscreenOverlay);
            });
            
            // Render map to fullscreen canvas
            const fullscreenCanvas = document.getElementById('fullscreenMapCanvas');
            const fullscreenCtx = fullscreenCanvas.getContext('2d');
            
            // Temporarily switch to fullscreen canvas for rendering
            const originalCanvas = this.canvas;
            const originalCtx = this.ctx;
            
            this.canvas = fullscreenCanvas;
            this.ctx = fullscreenCtx;
            this.renderMap();
            
            // Restore original canvas
            this.canvas = originalCanvas;
            this.ctx = originalCtx;
        }
    }

    onMapClick(event) {
        const rect = this.canvas.getBoundingClientRect();
        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;
        
        console.log(`Map clicked at: ${x}, ${y}`);
        // Could implement walking to clicked location
    }

    onMapHover(event) {
        const rect = this.canvas.getBoundingClientRect();
        const x = event.clientX - rect.left;
        const y = event.clientY - rect.top;
        
        // Calculate which tile we're hovering over with new full-canvas rendering
        if (this.mapData.length > 0) {
            const mapWidth = this.mapData[0]?.length || 0;
            const mapHeight = this.mapData.length;
            
            // Calculate tile size (same as in renderMap)
            const tileWidth = this.canvas.width / mapWidth;
            const tileHeight = this.canvas.height / mapHeight;
            
            const tileX = Math.floor(x / tileWidth);
            const tileY = Math.floor(y / tileHeight);
            
            if (tileY >= 0 && tileY < this.mapData.length && 
                tileX >= 0 && tileX < this.mapData[tileY].length) {
                
                const tile = this.mapData[tileY][tileX];
                const terrainInfo = this.terrainTypes[tile.terrain] || this.terrainTypes['.'];
                
                // Create detailed tooltip
                const tooltip = `${terrainInfo.name}\n` +
                              `Character: '${tile.char}'\n` +
                              `Coordinates: ${tileX}, ${tileY}\n` +
                              `Description: ${terrainInfo.desc || 'Unknown terrain'}`;
                
                this.canvas.title = tooltip;
            } else {
                this.canvas.title = `Map coordinates: ${Math.floor(x)}, ${Math.floor(y)}`;
            }
        } else {
            this.canvas.title = `Map coordinates: ${Math.floor(x)}, ${Math.floor(y)}`;
        }
    }

    updateLocationInfo(location, coords) {
        const locationEl = document.getElementById('minimapLocation');
        const coordsEl = document.getElementById('minimapCoords');
        
        if (locationEl) locationEl.textContent = `Location: ${location}`;
        if (coordsEl) coordsEl.textContent = `Coords: ${coords}`;
    }
}

// Export for global access
window.MudMapRenderer = MudMapRenderer; 