Command/Wiz
	summondbs
		name = "summondbs";
		immCommand = 1
		immReq = 3
		format = "summondbs";

		command(mob/user) {
			send("You hold out your hand and cast a magical portal and out pops the dragonballs!",user,TRUE);
			send("[user.raceColor(user.name)] holds out their hand and casts a magical portal and out pops the dragonballs!",_ohearers(0,user),TRUE);

			if(user.getArea() == get_area("earth")){
				for(var/obj/item/DRAGONBALLS/d){
					d.loc=locate(user.x,user.y,user.z);
				}
			}else{
				for(var/obj/item/NAMEK_DRAGONBALLS/d){
					d.loc=locate(user.x,user.y,user.z);
				}
			}
		}