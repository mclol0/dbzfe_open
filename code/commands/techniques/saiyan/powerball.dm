Command/Technique
	powerball
		name = "powerball"
		internal_name = "powerball"
		format = "powerball";
		priority = 3
		_maxDistance = 0;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Throw a ball of bright, white energy into the sky. Saiyans can use this ball to trigger a part of their genes that transforms them into big apes."
		skillDatum = /fEAttk/powerball

		command(mob/user) {
			if(user){
				if(..(user,user,TRUE,name,TRUE)){
					return;
				}

				send("{RYou create and throw a bright ball of white energy into the sky!{x",user)
				send("{W*{x {x[user.raceColor(user.name)]{x{R creates and throws a bright ball of white energy into the sky!{x", _ohearers(0,user))

				game.addCooldown(user.name,internal_name,600 SECONDS);

				new/fEAttk/powerball(user,user.x,user.y+3,user.z)
			}
			else{
				syntax(user,getSyntax());
			}
		}