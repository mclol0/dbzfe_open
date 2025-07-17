<div class="hero-section">
    <h1>🐉 Dragon Ball Z: Fighter's Edition</h1>
    <p class="hero-description">Looking for a Dragon Ball experience that's about more than simply watching your virtual power level increase? Dragon Ball Z: FE is a Dragon Ball Z MUD run on a completely custom codebase that uses the BYOND engine. It was built from the ground-up, and seeks to follow the inspiration started by Trenton's Dragon Ball Z: Fighter's Edition (DBZ FE) and Rcet's Dragon Ball Z: Reality (DBZ Reality).</p>
    
    <p class="gameplay-focus">Gameplay focuses on a completely interactive combat system, where your character only attacks when you give the order, and your defenses are similarly your own responsibility!</p>
</div>

<div class="features-section">
    <h2>⚡ Game Features</h2>
    
    <div class="feature-grid">
        <div class="feature-item">
            <div class="feature-icon">⚔️</div>
            <h3>Open PVP System</h3>
            <p>Restricted by max power level - no getting ganked when you wouldn't have a chance to win!</p>
        </div>
        
        <div class="feature-item">
            <div class="feature-icon">🗺️</div>
            <h3>Detailed ASCII Map</h3>
            <p>Rather than room descriptions, view a map detailing the terrain, nearby NPCs, and players</p>
        </div>
        
        <div class="feature-item">
            <div class="feature-icon">📈</div>
            <h3>No Conventional Levels</h3>
            <p>Power level increases as you fight, with a substantial bonus for killing blows</p>
        </div>
        
        <div class="feature-item">
            <div class="feature-icon">🥋</div>
            <h3>Skill-Based Combat</h3>
            <p>Dodge and parry your opponent's attacks while countering with your own feints and maneuvers</p>
        </div>
        
        <div class="feature-item">
            <div class="feature-icon">💥</div>
            <h3>Energy Attacks</h3>
            <p>Strike at your opponent from several rooms away, or unleash a devastating blast at close range</p>
        </div>
        
        <div class="feature-item">
            <div class="feature-icon">🌟</div>
            <h3>Multiple Races</h3>
            <p>Human, Saiyan, Namekian, and Android races currently playable, each with unique attacks and transformations</p>
        </div>
    </div>
</div>

<div class="cta-section">
    <h2>Ready to Begin Your Journey?</h2>
    <p>Join the ultimate Dragon Ball Z experience and test your power against warriors from across the universe!</p>
    <div class="power-meter">
        <div class="power-bar"></div>
        <span class="power-text">Power Level: OVER 9000!</span>
    </div>
    
    <div class="discord-cta">
        <h3>Join Our Community!</h3>
        <p>Connect with fellow warriors, get updates, and find training partners on our Discord server!</p>
        <a href="https://discord.gg/QynAjm2axA" target="_blank" class="discord-button">
            <i class="fab fa-discord"></i>
            <span>Join Discord Server</span>
        </a>
    </div>
</div>

<style>
.hero-section {
    text-align: center;
    margin-bottom: 3rem;
}

.hero-description {
    font-size: 1.2rem;
    margin: 2rem 0;
    color: var(--text-gray);
}

.gameplay-focus {
    font-size: 1.1rem;
    color: var(--accent-gold);
    font-weight: 600;
    font-style: italic;
}

.features-section {
    margin: 3rem 0;
}

.features-section h2 {
    text-align: center;
    margin-bottom: 2rem;
    font-size: 2.5rem;
    background: var(--gradient-fire);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}

.feature-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 2rem;
    margin-top: 2rem;
}

.feature-item {
    background: rgba(255, 107, 26, 0.1);
    border: 1px solid rgba(255, 107, 26, 0.3);
    border-radius: 12px;
    padding: 2rem;
    text-align: center;
    transition: all 0.3s ease;
    position: relative;
    overflow: hidden;
}

.feature-item::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 107, 26, 0.1), transparent);
    transition: left 0.5s ease;
}

.feature-item:hover::before {
    left: 100%;
}

.feature-item:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(255, 107, 26, 0.3);
    border-color: var(--primary-orange);
}

.feature-icon {
    font-size: 3rem;
    margin-bottom: 1rem;
    filter: drop-shadow(0 0 10px rgba(255, 107, 26, 0.5));
}

.feature-item h3 {
    color: var(--primary-orange);
    margin-bottom: 1rem;
    font-family: 'Orbitron', sans-serif;
    font-size: 1.3rem;
}

.feature-item p {
    color: var(--text-gray);
    line-height: 1.6;
}

.cta-section {
    text-align: center;
    margin: 4rem 0 2rem 0;
    padding: 2rem;
    background: rgba(30, 136, 229, 0.1);
    border-radius: 15px;
    border: 1px solid rgba(30, 136, 229, 0.3);
}

.power-meter {
    margin: 2rem auto;
    width: 300px;
    position: relative;
}

.power-bar {
    width: 100%;
    height: 20px;
    background: linear-gradient(90deg, #1e88e5, #42a5f5, #64b5f6, #ffd700);
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(255, 215, 0, 0.6);
    animation: powerPulse 2s ease-in-out infinite;
}

.power-text {
    display: block;
    margin-top: 1rem;
    font-family: 'Orbitron', sans-serif;
    font-weight: 700;
    color: var(--accent-gold);
    text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
    font-size: 1.2rem;
}

@keyframes powerPulse {
    0%, 100% { box-shadow: 0 0 20px rgba(255, 215, 0, 0.6); }
    50% { box-shadow: 0 0 30px rgba(255, 215, 0, 0.9), 0 0 40px rgba(255, 107, 26, 0.4); }
}

.discord-cta {
    margin-top: 3rem;
    padding: 2rem;
    background: rgba(88, 101, 242, 0.1);
    border: 1px solid rgba(88, 101, 242, 0.3);
    border-radius: 15px;
    text-align: center;
}

.discord-cta h3 {
    color: #5865f2;
    font-family: 'Orbitron', sans-serif;
    font-size: 1.8rem;
    margin-bottom: 1rem;
    text-shadow: 0 0 10px rgba(88, 101, 242, 0.5);
}

.discord-cta p {
    color: var(--text-gray);
    margin-bottom: 2rem;
    font-size: 1.1rem;
}

.discord-button {
    display: inline-flex;
    align-items: center;
    gap: 0.8rem;
    background: linear-gradient(135deg, #5865f2 0%, #7289da 100%);
    color: white;
    text-decoration: none;
    padding: 1rem 2rem;
    border-radius: 12px;
    font-size: 1.2rem;
    font-weight: 700;
    font-family: 'Orbitron', sans-serif;
    transition: all 0.3s ease;
    box-shadow: 0 4px 15px rgba(88, 101, 242, 0.3);
    position: relative;
    overflow: hidden;
}

.discord-button::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
    transition: left 0.5s ease;
}

.discord-button:hover {
    transform: translateY(-3px) scale(1.05);
    box-shadow: 0 8px 25px rgba(88, 101, 242, 0.5), 0 0 30px rgba(88, 101, 242, 0.3);
    background: linear-gradient(135deg, #4752c4 0%, #5b6ecd 100%);
}

.discord-button:hover::before {
    left: 100%;
}

.discord-button i {
    font-size: 1.5rem;
    filter: drop-shadow(0 0 8px rgba(255, 255, 255, 0.3));
}

.discord-button:active {
    transform: translateY(-1px) scale(1.02);
}

@media (max-width: 768px) {
    .feature-grid {
        grid-template-columns: 1fr;
        gap: 1.5rem;
    }
    
    .feature-item {
        padding: 1.5rem;
    }
    
    .power-meter {
        width: 250px;
    }
    
    .discord-cta {
        margin-top: 2rem;
        padding: 1.5rem;
    }
    
    .discord-button {
        padding: 0.8rem 1.5rem;
        font-size: 1.1rem;
    }
}
</style>