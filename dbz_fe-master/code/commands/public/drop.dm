Command/Public
	drop
		name = "drop"
		format = "~drop; ?!searc(obj@inventory)|?~searc(obj@inventory)|?word";
		syntax = list("item name")
		priority=1
		helpDescription = "Drop an item from your inventory to the ground. Certain kinds of special items might not be able to be dropped."

		command(mob/user, iRef) {
			if(length(iRef) > 0 && TextMatch("all", iRef, 1, 1) && user.contents.len > 0){
				for(var/obj/item/i in user.contents){
					if(i.CAN_DROP){
						user.dropItem(i);
						i.insideBuilding = user.insideBuilding;
						send("You drop [i.PREFIX][i.DISPLAY].",user)
						send("[user.raceColor(user.name)] drops [i.PREFIX][i.DISPLAY].",_ohearers(0,user))
					}
				}
			}else if(istype(iRef,/obj/item)){
				if(iRef:CAN_DROP){
					user.dropItem(iRef);
					iRef:insideBuilding = user.insideBuilding;
					send("You drop [iRef:PREFIX][iRef:DISPLAY].",user)
					send("[user.raceColor(user.name)] drops [iRef:PREFIX][iRef:DISPLAY].",_ohearers(0,user))
				}else{
					send("You can't drop that!",user);
				}
			}
			else{
				syntax(user,src);
			}
		}