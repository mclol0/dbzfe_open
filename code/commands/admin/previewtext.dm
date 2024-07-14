Command/Public
	previewtext
		name = "previewtext";
		format = "previewtext; any";
		syntax = list("text")
		canAlwaysUSE = TRUE

		command(mob/user, text) {
			if(length(text) > 0){
				send(checkForNewLine(format_text(text)),user)
			}
			else{
				send("Missing text.",user,TRUE)
				syntax(user, getSyntax())
			}
		}