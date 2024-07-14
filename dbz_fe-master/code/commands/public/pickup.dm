Command/Public
	pickup
		name = "get"
		format = "~pickup|~get; ?!searc(obj@item_loc)|?~searc(obj@item_loc)|?word";
		syntax = list("item name")
		priority = 1
		helpDescription = "Take an object from the ground and place it in your inventory. Some items might not be able to be picked up with this command."

		command(mob/user, o) {
			if(istype(o,/obj/item)){
				if(istype(o,/obj/item/DRAGONBALLS) && DBDatum.WISHING){
					syntax(user,src);
					return FALSE;
				}

				if(istype(o,/obj/item/NAMEK_DRAGONBALLS) && DBDatum_NAMEK.WISHING){
					syntax(user,src);
					return FALSE;
				}

				if(istype(o,/obj/item/NAMEK_DRAGONBALLS) && !user.canPickupNamekBall()){
					send("You can only carry so many large {YDrag({x{R*{x{Y)n{x{RBall{xs at once!",user,TRUE);
					return FALSE;
				}

				if(o && o:CAN_PICKUP){
					if(o:weightCheck(user)){
						user.addInv(o);
						o:insideBuilding = FALSE;
						send("You pickup [o:PREFIX][o:DISPLAY].",user)
						send("[user.raceColor(user.name)] picks up [o:PREFIX][o:DISPLAY].",_ohearers(0,user))
					}else{
						send("You're overweight you can't pick this up!",user,TRUE);
					}
				}
			}else if(o == "all"){
				for(var/obj/item/i in user.loc.contents){
					if(!istype(i,/obj/item/DRAGONBALLS) && !istype(i,/obj/item/NAMEK_DRAGONBALLS)){
						if(i.weightCheck(user)){
							if(i && i.CAN_PICKUP){
								user.addInv(i);
								i.insideBuilding = FALSE;
								send("You pickup [i:PREFIX][i:DISPLAY].",user)
								send("[user.raceColor(user.name)] picks up [i:PREFIX][i:DISPLAY].",_ohearers(0,user))
							}
						}else{
							send("You're overweight you can't pick this up!",user,TRUE);
						}
					}
				}
			}else{
				syntax(user, src);
			}
		}
