Command/Public
	map
		name = "map"
		format = "map";
		internal_name = "map";
		canUseWhileRESTING = TRUE;
		helpDescription = "Display a larger version of the mini map. This command has a cooldown of 30 seconds."

		command(mob/user) {
			if(..(user)){
				return;
			}

			send(buildMap(user,MMAP_LEFT,MMAP_RIGHT,MMAP_TOP,MMAP_BOT),user)

			game.addCooldown(user.name,internal_name,20 SECONDS);
		}
