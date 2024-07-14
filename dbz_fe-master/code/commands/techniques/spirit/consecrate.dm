Command/Technique

	consecrate
		name = "consecrate"
		internal_name = "consecrate"
		format = "~consecrate";
		priority = 1;
		_minDistance = 0;
		_maxDistance = 0;
		tType = UTILITY;
		defenses = NULL;
		helpCategory = "Utility"
		helpDescription = "Create consecrated ground. This will heal you and other players in the room."
		skillDatum = /fEAttk/consecrate

		command(mob/user) {

			var isConsActive = 0;
			for(var/obj/item/i in user.loc.contents){
				if(istype(i,/obj/item/consecrated_ground)) {
					isConsActive = 1;
				}
			}

			if(isConsActive == FALSE) {


				if(!istype(user,/mob/Player/Immortal) && game.checkCooldown(user.name,internal_name)) {
					send("You can't use [name] for another [num2text((game.coolDowns["([user.name])[internal_name]"] - world.time) / 10,3)] second(s)!",user)
				} else {
					send("{B* You place your hands on the ground and begin to emit a soft glow!{x",user);
					send("{CYou are surrounded by consecrated ground.{x", user);

					send("{W*{x [user.raceColor(user.name)] places [user.determineSex(1)] hand on the ground ad begins to emit a soft glow!\n",_ohearers(0,user));
					send("{CYou are surrounded by consecrated ground.{x", _ohearers(0,user));

					new /fEAttk/consecrate(user,src);
				}
			} else {
				send("{DThere already appears to be a consecrated pool at your location", user);
			}
		}
