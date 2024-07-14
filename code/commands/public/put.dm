Command/Public
	put
		name = "put"
		format = "~put; ?!searc(obj@inventory)|?~searc(obj@inventory); ?!searc(obj@item_loc)|?~searc(obj@item_loc)";
		syntax = list("item name", "container")
		priority = 1
		helpDescription = "Place an item from your inventory into the selected container."

		command(mob/user, obj/item/o, obj/item/c) {
			if(o && o.CAN_STASH && c && c.CONTAINER && !istype(c, /obj/item/HOUSESYSTEM/UPGRADES/MEDPOD)){
				if (istype(c, /obj/item/HOUSESYSTEM/UPGRADES)) {
					if (!c:hasAccess(user)) {
						send("You are not allowed to put items in this container.", user)
						return
					}
				}

				if(!o:CAN_DROP){
					send("You can't stash this!",user,TRUE);
				}

				c:stash(user, o)
			}
			else{
				syntax(user,src);
			}
		}
