// Skill Mastery System - Main
// Handles mastery data and logic for all skills

// Mastery level names (customize as needed)
var/list/skillMastery_level_names = list(
    "Novice",
    "Beginner",
    "Adept",
    "Skilled",
    "Expert",
    "Elite",
    "Master",
    "Grandmaster"
)

// Experience thresholds for each level (adjust as needed)
var/list/skillMastery_exp_thresholds = list(
    0,      // Novice
    40,    // Beginner
    80,    // Adept
    120,    // Skilled
    160,   // Expert
    200,   // Elite
    240,   // Master
    280   // Grandmaster
)

// Color codes for each mastery level (1-based index)
var/list/skillMasteryLevelColors = list(
    "{D", // 1: Novice
    "{y", // 2: Beginner
    "{g", // 3: Adept
    "{c", // 4: Skilled
    "{B", // 5: Expert
    "{M", // 6: Elite
    "{R", // 7: Master
    "{W"  // 8: Grandmaster
)

// Fuzz percent for each mastery level
var/list/skillMasteryFuzzPercents = list(
    0.4,    // Novice: ±40%
    0.3,    // Beginner: ±30%
    0.2,    // Adept: ±20%
    0.15,   // Skilled: ±15%
    0.1,    // Expert: ±10%
    0.05,   // Elite: ±5%
    0.02,   // Master: ±2%
    0       // Grandmaster: 0%
)

// Proc to ensure the 'skillExp' column exists in the 'characters' table
proc/ensureSkillExpColumn()
    var/exists = FALSE
    var/database/query/q = _query("PRAGMA table_info(characters);")
    while(q.NextRow())
        var/list/row = q.GetRowData()
        if(lowertext(row["name"]) == "skillexp")
            exists = TRUE
            break
    if(!exists)
        _query("ALTER TABLE characters ADD COLUMN skillExp TEXT;")
        world.log << "[time2text()] Added skillExp column to characters table."
    else
        world.log << "[time2text()] skillExp column already exists in characters table." 

// Returns the current mastery level index (0-7) for given exp
proc/skillMasteryGetLevel(exp as num) {
    for(var/i = skillMastery_exp_thresholds.len, i > 0, i--)
        if(exp >= skillMastery_exp_thresholds[i])
            return i
    return 1
}

// Returns the friendly name for a given level index
proc/skillMasteryGetLevelName(level as num) {
    if(level < 1 || level > skillMastery_level_names.len)
        return "Unknown"
    return skillMastery_level_names[level]
}

// Returns the next exp threshold for a given level (or null if max)
proc/skillMasteryNextExp(level as num) {
    if(level >= skillMastery_exp_thresholds.len)
        return null
    return skillMastery_exp_thresholds[level+1]
}

// Call this to add exp to a player's skill
proc/skillMasteryGainExp(mob/player, skill as text, amount as num) {
    if(!game.settings.skillMasteryEnabled) return
    if(!player || !isnum(amount) || amount <= 0 || !istext(skill)) return
    if(player.skillExp == NULL) player.skillExp = list()
    if(player.skillExp[skill] == NULL) player.skillExp[skill] = 0
    var/oldExp = player.skillExp[skill]
    var/oldLevel = skillMasteryGetLevel(oldExp)
    var/oldNext = skillMasteryNextExp(oldLevel)
    var/oldPrev = skillMastery_exp_thresholds[oldLevel]
    var/oldProgress = (oldExp - oldPrev) / max(1, (oldNext - oldPrev))

    player.skillExp[skill] += amount
    var/newExp = player.skillExp[skill]
    var/newLevel = skillMasteryGetLevel(newExp)
    var/newNext = skillMasteryNextExp(newLevel)
    var/newPrev = skillMastery_exp_thresholds[newLevel]
    var/newProgress = (newExp - newPrev) / max(1, (newNext - newPrev))

    if(newLevel > oldLevel) {
        var/color = skillMasteryGetLevelColor(newLevel)
        send("{BYou have achieved{x [color][skillMasteryGetLevelName(newLevel)]{x {Bmastery in{x {R[skill]{x{B!{x", player)
    } else {
        // Check for crossing 25%, 50%, 75% boundaries
        var/list/milestones = list(0.25, 0.5, 0.75)
        for(var/m in milestones) {
            if(oldProgress < m && newProgress >= m) {
                send("{BYou feel more confident using {R[skill]{x.", player)
                break
            }
        }
    }
}

// Returns the player's exp for a skill
proc/skillMasteryGetExp(mob/player, skill as text) {
    if(!player || isnull(player.skillExp) || isnull(player.skillExp[skill])) return 0
    return player.skillExp[skill] 
}

proc/getPowerEstimation(mob/user, mob/target) {
    if(user.currpl > (target.currpl * game.settings.map["veryWeakModifier"])) return "{yVERY WEAK{x"
    else if(user.currpl > (target.currpl * game.settings.map["weakModifier"])) return "{yWEAK{x"
    else if(user.currpl > (target.currpl * game.settings.map["equalModifier"])) return "{BEQUAL{x"
    else if(user.currpl > (target.currpl * game.settings.map["strongModifier"])) return "{RSTRONG{x"
    else return "{rGODLIKE{x"
}

// Returns a formatted string for the target's power based on the user's sense mastery level
proc/formatSensePower(mob/user, mob/target) {
    var/power = target.currpl
    var/result = 0
    // If skill mastery is disabled, always use old system
    if(!game.settings.skillMasteryEnabled) {
        if(user.sensePL) {
            result = power
        } else {
            return getPowerEstimation(user, target)
        }
    } else {
        // If power level sensing is OFF, always use sense mastery (fuzzy number or estimation)
        if(!user.sensePL) {
            var/exp = skillMasteryGetExp(user, "sense")
            var/level = skillMasteryGetLevel(exp)
            if(!isnum(power) || power <= 0) return "an unknown power"
            if(level == 1)
                return getPowerEstimation(user, target)
            else if(level >= 2 && level <= 8)
                var/fuzz = skillMasteryFuzzPercents[level] * 100
                var/randFuzz = rand(-fuzz, fuzz) / 100
                var/delta = round(power * randFuzz)
                result = power + delta
            else
                return "{Gan unknown power{x"
        } else {
            // Power level sensing is ON
            if(user.sensePLMode == "estimation") {
                return getPowerEstimation(user, target)
            } else {
                result = power
            }
        }
    }

    if(user.shortNUM){
        return "{G[short_num(result)]{x"
    } else {
        return "{G[commafy(result)]{x"
    }
}

proc/skillMasteryGetLevelColor(level as num) {
    if(level < 1 || level > skillMasteryLevelColors.len)
        return "{x"
    return skillMasteryLevelColors[level]
}