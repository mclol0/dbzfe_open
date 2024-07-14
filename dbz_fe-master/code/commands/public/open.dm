Command/Public
	open
		name = "open"
		format = "~open; ?!searc(obj@inventory)|?~searc(obj@inventory)";
		syntax = list("container")
		canUseWhileRESTING = TRUE;
		priority = 1
		helpDescription = "Open a closed container."

		command(mob/user, obj/item/o) {
			if(o){
				user.Open(o);
			}
			else{
				syntax(user, src);
			}
		}