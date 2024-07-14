atkDatum
	utility
		regeneration
			name = "regeneration"
			passive = TRUE

			New(){
			}

			getHelp() {
				var/list/buffer = list()

				buffer += "\n\nThis skill modifies the regeneration rate of the character depending on its race\n"
				buffer += "<al2></a>All Races:\n"
				buffer += "<al4></a><al17>Regen Percent</a>: [NORMAL_REGEN_PERCENT]% of Max PL\n"
				buffer += "<al4></a><al17>Regen Frequency</a>: [NORMAL_REGEN_FREQUENCY/10]s\n"
				buffer += "\n<al2></a>{gNamek{x {CValues:\n"
				buffer += "<al4></a><al17>Regen Percent</a>: [NAMEK_REGEN_PERCENT]% of Max PL\n"
				buffer += "<al4></a><al17>Regen Frequency</a>: [NAMEK_REGEN_FREQUENCY/10]s\n"
				buffer += "\n<al2></a>{MGenie{x {CValues:\n"
				buffer += "<al4></a><al17>Regen Percent</a>: [GENIE_REGEN_PERCENT]% of Max PL\n"
				buffer += "<al4></a><al17>Regen Frequency</a>: [GENIE_REGEN_FREQUENCY/10]s\n"

				var/helpStr = ..()
				return implodetext(buffer, "") + helpStr
			}