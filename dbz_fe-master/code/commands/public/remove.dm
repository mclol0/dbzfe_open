Command/Public
	remove
		name = "remove"
		format = "~remove; ?!searc(obj@equipment)|?~searc(obj@equipment)|?word";
		syntax = list("item name","all")
		priority = 1
		helpDescription = "Remove an equipped item and put it in your inventory."

		command(mob/user, o) {
			if(istype(o,/obj/item)){
				user.removeItem(o,user);
			}else if(o == "all"){
				var/count = 0;

				for(var/i=1;i<EQUIPMENT_SLOTS;i++){
					if(user.equipment[i]){
						user.removeItem(user.equipment[i],user);
						count++;
					}
				}

				if(!count){
					send("You have nothing to remove!",user,TRUE);
					return;
				}

			}else{
				syntax(user,src);
			}
		}