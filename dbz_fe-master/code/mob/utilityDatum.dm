atkDatum
	utility
		var
			passive = FALSE
			staBonus = 0
			strBonus = 0

			//For Shyouken
			comboExtendChance = 0
			duration = 0

		getHelp(Command/Technique/cRef) {
			var/list/buffer = list()

			buffer += "\n[capFirstL(name)] Details:\n"
			buffer += "<al2></a><al17>Technique Type</a>: Utility"

			if (cost > 0) {
				var/costStr = costUsesDistance ? "[cost]% Stamina + 1% Stamina per room to target" : "[cost]% Stamina"
				buffer += "\n<al2></a><al17>Cost</a>: [costStr]"
			}

			if (cdTime > 0) {
				var/cooldownStr = cdTime > 0 ? cdTime/10 : 0
				buffer += "\n<al2></a><al17>Cooldown</a>: [cooldownStr]s"
			}

			if (staBonus > 0) {
				buffer += "\n<al2></a><al17>Stamina Bonus</a>: [staBonus]"
			}

			if (strBonus > 0) {
				buffer += "\n<al2></a><al17>Strength Bonus</a>: [strBonus]"
			}

			if (comboExtendChance > 0) {
				buffer += "\n\nThis skill increases your chances of extending melee combos\n"
				buffer += "\n<al2></a><al17>Extend Chance</a>: [comboExtendChance]%"
			}

			if (duration) {
				buffer += "\n\nThis skill will be active for a limited time after activation\n"
				buffer += "\n<al2></a><al17>Duration</a>: [duration/10]s"
			}

			if (passive) {
				buffer += "\n\nThis is a {GPASSIVE{x {Cskill. Once acquired, it's effects will be applied automatically."
			}

			return implodetext(buffer, "")
		}

		proc/createHealHelp(var/atkDatum/skill) {
			var/list/buffer = list()

			buffer += "This skill will {mRECOVER{x {Cyour target a maximum of {R[skill.maxRestoreStacks]{x {Ctimes per use):"
			buffer += "\n<al2></a><al17>Cost</a>: [skill.cost]% Stamina"
			if (skill.cdTime > 0) {
				var/cooldownStr = skill.cdTime > 0 ? skill.cdTime/10 : 0
				buffer += "\n<al2></a><al17>Cooldown</a>: [cooldownStr/10]s"
			}

			if (skill.enMinRestore > 0)
				var/maxRestore = skill.enMaxRestore > 0
				buffer += "\n<al2></a><al17>[maxRestore ? "Min " : ""]Energy Restore</a>: [skill.enMinRestore]% each time"

				if (maxRestore)
					buffer += "\n<al2></a><al17>Max Energy Restore</a>: [skill.enMaxRestore]% each time"

			if (skill.staMinRestore > 0)
				var/maxRestore = skill.staMaxRestore > 0
				buffer += "\n<al2></a><al17>[maxRestore ? "Min " : ""]Stamina Restore</a>: [skill.staMinRestore]% each time"

				if (maxRestore)
					buffer += "\n<al2></a><al17>Max Stamina Restore</a>: [skill.staMaxRestore]% each time"

			if ((skill.enMinRestore || skill.staMinRestore) && skill.maxRestoreStacks > 0)
				buffer += "\n<al2></a><al17>Recovery Interval</a>: [skill.healDelay/10]s"

			return implodetext(buffer, "")
		}