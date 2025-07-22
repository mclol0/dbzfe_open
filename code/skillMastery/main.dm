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
    50,    // Beginner
    150,    // Adept
    300,    // Skilled
    600,   // Expert
    800,   // Elite
    1000,   // Master
    1200   // Grandmaster
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

// Returns a formatted string for the target's power based on the user's sense mastery level
proc/skillMasteryFormatSensePower(mob/user, mob/target) {
    var/exp = skillMasteryGetExp(user, "sense")
    var/level = skillMasteryGetLevel(exp)
    var/power = target.currpl
    if(!isnum(power) || power <= 0) return "an unknown power"

    var/result = ""
    if(level == 1) // Novice: qualitative only
        if(target.currpl < 1000)
            return "{yVERY WEAK{x"
        if(user.currpl > (target.currpl * game.settings.map["veryWeakModifier"])) return "{yVERY WEAK{x"
        else if(user.currpl > (target.currpl * game.settings.map["weakModifier"])) return "{yWEAK{x"
        else if(user.currpl > (target.currpl * game.settings.map["equalModifier"])) return "{BEQUAL{x"
        else if(user.currpl > (target.currpl * game.settings.map["strongModifier"])) return "{RSTRONG{x"
        else return "{rGODLIKE{x"
    else if(level == 2) // Beginner: gentle approximation
        var/rounded = max(400, round(power, 400))
        result = "[commafy(rounded)]"
    else if(level == 3) // Adept: better, but still rough
        var/rounded = max(250, round(power, 250))
        result = "[commafy(rounded)]"
    else if(level == 4) // Skilled: more accurate
        var/rounded = round(power, 100)
        result = "[commafy(rounded)]"
    else if(level == 5) // Expert: even more accurate
        var/rounded = round(power, 50)
        result = "[commafy(rounded)]"
    else if(level == 6) // Elite: very close
        var/rounded = round(power, 10)
        result = "[commafy(rounded)]"
    else if(level == 7) // Master: almost exact
        var/rounded = round(power, 5)
        result = "[commafy(rounded)]"
    else if(level == 8) // Grandmaster: closest, but never exact
        var/rounded = round(power, 1)
        result = "[commafy(rounded)]"
    else
        result = "an unknown power"

    return "{G[result]{x"
}

proc/skillMasteryGetLevelColor(level as num) {
    if(level < 1 || level > skillMasteryLevelColors.len)
        return "{x"
    return skillMasteryLevelColors[level]
}