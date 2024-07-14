atkDatum
	utility
		heal
			name = "heal"
			heal = TRUE

			New(){
			}

			getHelp() {
				var/helpStr
				var/atkDatum/kaio_heal = new /atkDatum/kaio_heal
				var/atkDatum/namek_heal = new /atkDatum/namek_heal

				helpStr += "\nKaio ([createHealHelp(kaio_heal)]"
				helpStr += "\n\nNamek ([createHealHelp(namek_heal)]"

				return helpStr
			}