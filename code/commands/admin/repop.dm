Command/Wiz
	repop
		name = "repop";
		format = "repop; any";
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 2

		command(mob/user, text) {
			if(lowertext(text) == "quiet" || lowertext(text) == "silent") {
				send("You have silently repopped all mobs", user);
			} else {
				send("{WThe world was caressed by [user.name]'s {M^rbeautiful{x{x{W hands.{x",game.players)
				send("{WAll dead mobiles have been revived!{x",game.players)
			}
			
			for(var/respawnMob/r){ r._respawn=TRUE; }
		}
