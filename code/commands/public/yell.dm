Command/Public
	yell
		name = "yell"
		format = "~yell; any";
		syntax = list("message")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = TRUE;
		_maxDistance = 6;
		cancelsPushups = FALSE;

		getDescription() {
			return "Yell a message to people in your vecinity. This will be heard up to [_maxDistance] rooms away from you."
		}

		command(mob/user, text) {
			text=ktext.limitText(text,MAX_CHAT_CHARACTERS);

			var/newName = user.invisible ? "Someone" : user.name;

			if(ktext.len(text) > 0){
				if(user:spacePod && (user in user:spacePod:passengers)){
					send("You yell loudly but no one can hear you!",user)
					return;
				}

				send("{RYou yell, '{x{W[rStrip_Escapes(text)]{x{R'{x",user)

				for(var/mob/A in user.getMobiles(user.y+SMAP_TOP,user.y-SMAP_BOT,user.x-SMAP_LEFT,user.x+SMAP_RIGHT)){
					if(!A.in_npc_menu){
						if(a_get_dist(user,A) <= (_maxDistance + A.superHearing())){
							if(A.superHearing() && a_get_dist(user,A) > _maxDistance){
								send("{D\[{x{GSuper Hearing{x{D\]{x {R[newName] yells, '{x{W[rStrip_Escapes(text)]{x{R'{x",A,TRUE)
							}else{
								send("{R[newName] yells, '{x{W[rStrip_Escapes(text)]{x{R'{x",A,TRUE)
							}
						}
					}
				}
			}
			else{
				send("You can't have a blank message!",user)
			}
		}