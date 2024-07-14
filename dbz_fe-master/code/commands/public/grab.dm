Command/Public
	grab
		name = "grab"
		format = "~grab; !~searc(mob@all_mob_loc)";
		syntax = list("mobile")
		priority=2
		helpDescription = "Hold on to another player. This is used by teleport-capable people to bring others with them."

		command(mob/user, mob/target) {
			if(target){
				user.grab(target);
			}
			else{
				syntax(user, src);
			}
		}