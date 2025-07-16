Command/Wiz
	settings
		name = "settings";
		immCommand = 1
		immReq = 1
		format = "~settings; word; num;";
		syntax = "{csettings <{x{Ckey name{x{c> <{x{Cvalue{x{c>{x";
		priority = 2

		command(mob/user, key, value) {
			if (key == NULL && value == NULL) {
				send("{YCURRENT SETTINGS{x", user)
				for(var/k in game.settings.map) {
					send("  [k] = [game.settings.get(k)]", user)
				}

				send("{RPLEASE BE CAREFUL WHEN CHANGING THIS AS IT COULD CRASH THE MUD{x", user)
			}

			if (key == NULL || value == NULL) {
				send("You have to provide both a value for {CKEY{x and one for {CVALUE{x", user)
				return
			}

			if (!(key in game.settings.map)) {
				send("Invalid key!", user)
				return
			}

			game.settings.setValue(key, value)
			send("Value for {R[key]{x updated to {C[value]{x", user)
		}