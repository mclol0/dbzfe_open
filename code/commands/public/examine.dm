Command/Public
	examine
		name = "examine"
		format = "~examine; ?~searc(obj@inventory)";
		syntax = list("item name")
		priority = 1
		canAlwaysUSE = TRUE;
		helpDescription = "This command examines an item revealing the items stats.\nNote: You cannot examine an item you are currently wearing."
		cancelsPushups = FALSE;

		command(mob/user, obj/item/o) {
			if(o && o in user.contents){
				o:showDetails(user)
			}
			else{
				syntax(user, src);
			}
		}