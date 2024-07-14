atkDatum
	utility
		materialize
			name = "materialize"

			New(){
			}

			getHelp(Command/Technique/cRef) {
				var/list/mBuf = list()

				mBuf += "\n\nDepending on the materalized object, this skill grants different bonuses:\n"
				mBuf += "<al2></a><al17>Sword</a>: +[DEMON_SWORD_BONUS] Strength + Slash and Stab skills\n"
				mBuf += "<al2></a><al17>Shield</a>: +[DEMON_SHIELD_BONUS] Armor\n"
				mBuf += "<al2></a><al17>Whip</a>: Lure Skill\n"

				var/helpStr = ..()
				helpStr += implodetext(mBuf, "")
				return helpStr
			}