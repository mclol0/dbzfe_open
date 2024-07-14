Command/Public
	itemdb
		name = "itemdb"
		format = "itemdb; ?any";
		syntax = list("item name")
		canAlwaysUSE = TRUE;
		canUseWhileRESTING = TRUE;
		helpDescription = "Display the list of current items in the database or the details of a specific item."
		cancelsPushups = FALSE;

		command(mob/user, item) {
			if(item){
				var/foundI = NULL;

				for(var/i in game.itemDB){
					if(__textMatch(lowertext(rStrip_Escapes(i)), lowertext(item), FALSE, TRUE)){
						foundI = i;
						break
					}
				}

				if(foundI){
					send(game.itemDB[foundI],user,TRUE);
				}else{
					send("itemDB: No item found! (try to be exact as possible)",user,TRUE);
				}
			}else{
				send("{YItem Database:{x",user,TRUE);

				for(var/i in game.itemDB){
					send(i,user,TRUE);
				}
			}
		}
