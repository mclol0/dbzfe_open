Command/Public
	say
		name = "say"
		format = "~say; any";
		syntax = list("message")
		canAlwaysUSE = FALSE;
		canUseWhileRESTING = TRUE;
		_maxDistance = 0;
		helpCategory = "General"
		helpDescription = ""
		cancelsPushups = FALSE;

		getDescription() {
			var/Command/Technique/S = new /Command/Technique/super_hearing
			var/desc = "Send the given message to other people in the same room as you. This message can eventually be heard by people nearby that have the {R[S.getName()]{x skill."
			del S
			return desc
		}

		command(mob/user, text) {
			text=ktext.limitText(text,MAX_CHAT_CHARACTERS);

			var/newName = user.invisible ? "Someone" : user.name;

			if(ktext.len(text) > 0){
				send("{CYou say, '{x{W[rStrip_Escapes(text)]{x{C'{x",user)

				for(var/mob/A in user.getMobiles(user.y+6,user.y-5,user.x-16,user.x+15)){
					if(a_get_dist(user,A) <= (_maxDistance + A.superHearing())){
						if(isplayer(user) && user:spacePod && (user in user:spacePod:passengers)){
							if(!A.in_npc_menu){
								if(A.superHearing() && a_get_dist(user,A) > _maxDistance){
									send("{D\[{x{GSuper Hearing{x{D\]{x {C[newName]'s spacepod speaker emits, '{x{W[rStrip_Escapes(text)]{x{C'{x",A)
								}else{
									send("{C[newName]'s spacepod speaker emits, '{x{W[rStrip_Escapes(text)]{x{C'{x",A)
								}
							}
						}else{
							A.event_say(user, text)
							if(!A.in_npc_menu){
								if(A.superHearing() && a_get_dist(user,A) > _maxDistance){
									send("{D\[{x{GSuper Hearing{x{D\]{x {C[newName] says, '{x{W[rStrip_Escapes(text)]{x{C'{x",A)
								}else{
									send("{C[newName] says, '{x{W[rStrip_Escapes(text)]{x{C'{x",A)
								}
							}
						}
					}
				}
			}
			else{
				send("You can't have a blank message!",user)
			}
		}
