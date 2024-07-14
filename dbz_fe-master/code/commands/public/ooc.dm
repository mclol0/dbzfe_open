Command/Public
	ooc
		name = "ooc"
		format = "~ooc; any";
		syntax = list("message")
		canAlwaysUSE = TRUE;
		canUseWhileRESTING = TRUE;
		helpDescription = "Send a message on the OOC channel."
		cancelsPushups = FALSE;

		command(mob/user, text) {
			text=ktext.limitText(text,MAX_CHAT_CHARACTERS);

			var/newName = user.invisible ? "Someone" : user.name;

			if(!user.channels.Find("OOC")){
				send("You have OOC disabled!",user)
				return
			}

			if(ktext.len(text) > 0){
				for(var/mob/Player/m in game.players){
					if(m.channels.Find("OOC") && !m.in_npc_menu){
						send("{y\[{x{YOOC{x{y\]{x [user.raceColor(newName)]{y, '{x{Y[rStrip_Escapes(text)]{x{y'{x",m,TRUE)
					}
				}

				game.logOOC(user.raceColor(newName),rStrip_Escapes(text))
			}
			else{
				send("You can't have a blank message!",user,TRUE)
			}
		}