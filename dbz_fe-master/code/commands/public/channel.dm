Command/Public
	channel
		name = "channel"
		format = "~channel; ?word";
		syntax = list("OOC | SCOUTER | TIPS")
		priority = 1
		canAlwaysUSE = TRUE;
		helpDescription = "This command is used to toggle specific channels such as OOC or SCOUTER."
		cancelsPushups = FALSE;

		command(mob/user, channel) {
			if(user && channel){
				if(TextMatch("ooc", channel, 1, 1)){
					if(user.channels.Find("OOC")){
						user.channels.Remove("OOC")
						send("You have disabled the 'OOC' channel.",user)
					}else{
						user.channels.Add("OOC")
						send("You have enabled the 'OOC' channel.",user)
					}
				}else if(TextMatch("scouter", channel, 1, 1)){
					if(!isScanner(user.equipment[EYE],FALSE) && user.race != ANDROID && user.race != REMORT_ANDROID && (user.race != SPIRIT || !user.hasSkill("telekenisis"))){
						send("You don't have a scouter!",user)
					} else if(user.channels.Find("SCOUTER")){
						user.channels.Remove("SCOUTER")
						send("You have disabled the 'SCOUTER' channel",user)
					}else{
						user.channels.Add("SCOUTER")
						send("You have enabled the 'SCOUTER' channel.",user)
					}
				}else if(TextMatch("tips", channel, 1, 1)){
					if(user.channels.Find("TIPS")){
						user.channels.Remove("TIPS")
						send("You have disabled the 'TIPS' channel.",user)
					}else{
						user.channels.Add("TIPS")
						send("You have enabled the 'TIPS' channel.",user)
					}
				}else{
					send("'[lowertext(channel)]' is an invalid channel.",user)
				}
			}
			else{
				syntax(user,src);
			}
		}
