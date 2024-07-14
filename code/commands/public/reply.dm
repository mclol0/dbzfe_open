Command/Public
	reply
		name = "reply"
		format = "~reply; any";
		syntax = list("message")
		canAlwaysUSE = FALSE
		canUseWhileRESTING = TRUE;
		helpDescription = "Send a private message to the last person that sent you a message."
		cancelsPushups = FALSE;

		command(mob/user, text) {
			text=ktext.limitText(text,MAX_CHAT_CHARACTERS);

			if (user.lastTell) {
				alaparser.parse(user, "tell [user.lastTell] [text]", list())
				return
			}else{
				send("You don't have anyone to reply to.", user)
			}
		}