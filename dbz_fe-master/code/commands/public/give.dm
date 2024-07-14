Command/Public
	give
		name = "give"
		format = "~give; ?word; ?!searc(mob@all_mob_loc)|?~searc(mob@all_mob_loc); ?num";
		syntax = list("zenni", "item name", "mobile")
		helpDescription = "Transfer an item from your inventory to another player's inventory."

		command(mob/Player/user, O, mob/Player/m, amount=0) {
			var/foundItem = FALSE;

			if(m && !isplayer(m)){
				send("You can't give things to npcs!",user,TRUE);
				return;
			}

			if(TextMatch("zenni", O, 1, 1) && amount > 0){
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
							send("You give [m.raceColor(m.name)] [O:PREFIX][O:DISPLAY].",user)
							send("[user.raceColor(user.name)] gives you [O:PREFIX][O:DISPLAY].",m)
							send("[user.raceColor(user.name)] gives [m.raceColor(m.name)] [O:PREFIX][O:DISPLAY].",a_oview_extra(0,user,m))
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