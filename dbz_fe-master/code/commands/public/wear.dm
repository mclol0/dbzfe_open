Command/Public
	wear
		name = "wear"
		format = "~wear; ?~searc(obj@inventory)|?word";
		syntax = list("item name","all")
		priority = 1
		helpDescription = "Wear a piece of equipment from your inventory into the related slot. If an item is already using the slot you are trying to equip then the items will be swapped, returning the previously equipped item to your inventory."

		command(mob/user, o) {
			if(istype(o,/obj/item)){
				user.equipItem(o,user);
			}else if(o == "all"){
				var/list/slots[] = list();
				var/Slot = NULL;
				var/count = 0;

				for(var/obj/item/i in user.contents){

					if(i){
						if(i.SLOT == FINGERS){
							if(!user.equipment[LEFT_FINGER]){
								Slot = LEFT_FINGER;
							}else if(!user.equipment[RIGHT_FINGER]){
								Slot = RIGHT_FINGER;
							}else{
								Slot=pick(LEFT_FINGER,RIGHT_FINGER);
							}
						}else{
							Slot = i.SLOT;
						}

						if(!slots.Find(Slot) && !user.equipment[Slot] && i.EQUIPABLE){
							user.equipItem(i,user);
							slots.Add(Slot);
							count++;
						}
					}
				}

				if(!count){
					send("You have nothing to wear!",user,TRUE);
					return;
				}

			}else{
				syntax(user,src);
			}
		}