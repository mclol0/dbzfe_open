Command/Public
	tell
		name = "tell"
		format = "~tell; !searc(mob@players)|~searc(mob@players); any";
		syntax = list("player", "message")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = TRUE;
		helpDescription = "Send a private message to another player if both you and the player are wearing a scouter."
		cancelsPushups = FALSE;

		command(mob/user, mob/m, text) {
			text=ktext.limitText(text,MAX_CHAT_CHARACTERS);

			if(!user.channels.Find("SCOUTER")){
				send("You have your scouter disabled!",user)
				return
			}

			if(user && m){
				if(user == m){
					send("You're weird...",user)
					return
				}

				if(!istype(user.equipment[EYE],/obj/item) && user.race != ANDROID && user.race != REMORT_ANDROID && (user.race != SPIRIT || !user.hasSkill("telekinesis"))){
					send("You don't have a scouter equiped!",user)
					return FALSE;
				}

				if(!istype(m.equipment[EYE],/obj/item) && m.race != ANDROID && user.race != REMORT_ANDROID && (m.race != SPIRIT || !m.hasSkill("telekinesis"))){
					send("They don't have a scouter equiped!",user)
					return FALSE;
				}

				if(ktext.len(text) > 0){
					if(user.hasSkill("telekinesis" || m.hasSkill("telekinesis"))) {
						send("{mYou beam to {M[m.name]{m, '{W[rStrip_Escapes(text)]{m'{x",user)
					} else {
						send("{DYou tell [m.raceColor(m.name)]{D, '{W[rStrip_Escapes(text)]{D'{x",user)						
					}
					
					if(m.channels.Find("SCOUTER")) {
						if(!user.hasSkill("telekinesis") && !m.hasSkill("telekinesis")) {
							send("{D({GSCOUTER{D){x [user.raceColor(user.name)]{D, '{G[rStrip_Escapes(text)]{D'{x",m)
						} else {
							send("{D({MTELEKINESIS{D){x [user.raceColor(user.name)]{D, '{M[rStrip_Escapes(text)]{D'{x",m)
						}

						m.lastTell = user
					}
				}
				else{
					send("You can't have a blank message!",user)
				}
			}else{
				syntax(user,src);
			}
		}
