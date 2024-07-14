Command/Wiz
	gethelp
		name = "gethelp";
		format = "gethelp; any";
		syntax = "{cgethelp{x {c\[{x{Chelpfile{x{c\]"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 3

		command(mob/user, text) {
			if(length(text) > 0){
				var/H = helpSystem.getHelp(text, user.isImm)

				if (H) {
					if (istype(H, /HELPSYSTEM/HELPFILE)) {
						if (H:immCommand && !user.isImm) {
							send("Unknown help: [text]", user, TRUE)
							return
						}

						H:show(user, 1)

						return
					} else {
						send(H, user, TRUE)
						return
					}
				} else {
					send("Unknown help: [text]", user, TRUE)
				}
			}
			else{
				send("Syntax: {cgethelp{x {c\[{x{Chelpfile{x{c\]",user,TRUE)
			}
		}
