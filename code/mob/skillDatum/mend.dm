atkDatum
	utility
		mend
			name = "mend"
			heal = TRUE

			New(){
			}

			getHelp() {
				var/helpStr
				var/atkDatum/genie_heal = new /atkDatum/genie_heal

				helpStr += "\nGenie ([createHealHelp(genie_heal)]"

				return helpStr
			}