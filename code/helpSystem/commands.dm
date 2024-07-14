Command/Public
	help
		name = "help"
		format = "help; ?any";
		syntax = list("command")
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;

		command(mob/user, command) {
			if (!command) {
				var/helpListString = helpSystem.getHelpList()
				send(helpListString, user, TRUE)
				return
			}

			var/H = helpSystem.getHelp(command, user.isImm)

			if (H) {
				if (istype(H, /HELPSYSTEM/HELPFILE)) {
					if (H:immCommand && !user.isImm) {
						send("Unknown help: [command]", user, TRUE)
						return
					}

					H:show(user)
					return
				} else {
					send(H, user, TRUE)
					return
				}
			}

			send("Unknown help: [command]", user)
			return
		}