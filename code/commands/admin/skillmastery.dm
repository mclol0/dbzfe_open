Command/Wiz
    skillmastery
        name = "skillmastery"
        immCommand = 1
        immReq = 3
        format = "~skillmastery; any;"
        helpDescription = "Enable or disable the skill mastery system."

        command(mob/user, arg) {
            if(!istext(arg)) {
                send("Usage: ~skillmastery <on|off|status>", user)
                return
            }
            
            var/lc = lowertext(arg)
            if(lc == "on") {
                game.settings.skillMasteryEnabled = TRUE
                send("Skill mastery system is now ENABLED.", user)
            } else if(lc == "off") {
                game.settings.skillMasteryEnabled = FALSE
                send("Skill mastery system is now DISABLED.", user)
            } else if(lc == "status") {
                var/status = game.settings.skillMasteryEnabled ? "ENABLED" : "DISABLED"
                send("Skill mastery system is currently [status].", user)
            } else {
                send("Usage: skillmastery <on|off|status>", user)
            }
        } 