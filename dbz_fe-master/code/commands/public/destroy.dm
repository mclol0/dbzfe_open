Command/Public
	destroy
		name = "destroy"
		format = "~destroy; ?!searc(obj@inventory)|?~searc(obj@inventory)";
		syntax = list("item name")
		priority = 1
		helpDescription = "Completely destroy an item from your inventory."

		command(mob/user, obj/item/o) {
			if(o){
				if(o.DESTRUCTABLE){
					send("You destroy [o.PREFIX][o.DISPLAY]!",user)
					send("[user.raceColor(user.name)] de-materializes [o.PREFIX][o.DISPLAY].",a_oview_extra(0,user,user))
					user.destroyItem(o);
				}else{
					send("You attempt to destroy [o.PREFIX][o.DISPLAY]... but fail!",user)
				}
			}
			else{
				syntax(user,src);
			}
		}