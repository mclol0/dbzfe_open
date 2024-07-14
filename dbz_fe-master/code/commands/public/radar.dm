Command/Public
	radar
		name = "radar"
		format = "radar";
		internal_name = "radar";
		canUseWhileRESTING = TRUE;

		getDescription() {
			var/obj/item/I = new /obj/item/DRAGON_RADAR
			var/desc = "{CUsing a [I.DISPLAY] in your inventory, display it's screen which will point you towards the closest Dragon Ball.{x"
			del I
			return desc
		}

		command(mob/Player/user) {
			if(..(user)){
				return;
			}

			var/obj/item/DRAGON_RADAR/d = locate(/obj/item/DRAGON_RADAR) in user.contents

			if(d != NULL){
				//d.scan(user);
				send(drawRadar(user),user,TRUE);
				game.addCooldown(user.name,internal_name,30 SECONDS);
			}else{
				send("You don't even have a Dragon Ball radar!",user,TRUE);
			}
		}
