Command/Public
	emote
		name = "emote"
		format = "~emote; any";
		syntax = list("text")
		canAlwaysUSE = TRUE
		helpDescription = "{CDescribe actions that your character perform to others. This will send a message to others in a format: {cYourname text{x.\n{YExample:{x ThunderZ laughs out loud.{x"
		cancelsPushups = FALSE;

		command(mob/user, text) {
			var/newName = user.invisible ? "Someone" : user.name;

			if(length(text) > 0){
				send("{c[newName] [text]{x",hearers(0,user))
			}
			else{
				send("You can't have a blank message!",user,TRUE)
			}
		}