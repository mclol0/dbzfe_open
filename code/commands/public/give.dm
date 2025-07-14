Command/Public
	give
		name = "give"
		format = "~give; ?word; ?!searc(mob@all_mob_loc)|?~searc(mob@all_mob_loc); ?num";
		syntax = list("zenni", "item name", "mobile")
		helpDescription = "Transfer an item from your inventory to another player's inventory."

		command(mob/Player/user, O, mob/Player/m, amount=0) {
			var/foundItem = FALSE;

			if(m && !m.canReceiveItems){
				send("You cannot give items to NPCs!",user,TRUE)
				return
			}

			if(TextMatch("zenni", O, 1, 1) && amount > 0){
				if (istype(m, /mob/NPA)) {
					send("You cannot give Zenni to NPCs!", user, TRUE)
					return
				}
				amount = cround(amount);
				send("You give [m.raceColor(m.name)] {G[commafy(amount)]{x {YZenni{x!",user,TRUE);
				send("[user.raceColor(user.name)] gives you {G[commafy(amount)]{x {YZenni{x!",m,TRUE);
				send("[user.raceColor(user.name)] gives [m.raceColor(m.name)] {G[commafy(amount)]{x {YZenni{x!",a_oview_extra(0,user));
				user.zenni -= amount;
				m.zenni += amount;
				foundItem = TRUE;
			}else{
				for(var/obj/item/I in user.contents){
					if(TextMatch(rStrip_Escapes(I.DISPLAY), O, 1, 1)){
						O = I;

						if(O && O:CAN_DROP && O:CAN_GIVE){
							user.giveItem(O,m);
						}

						foundItem = TRUE;
						break;
					}
				}
			}


			if(!foundItem){
				syntax(user, src);
			}
		}