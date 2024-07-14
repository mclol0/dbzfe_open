Command/Wiz
	dbloc
		name = "dbloc";
		immCommand = 1
		immReq = 3
		format = "dbloc";
		priority = 2;

		command(mob/user) {
			for(var/obj/item/DRAGONBALLS/d){
				if(d.x && d.y && d.z){
					send("[d.DISPLAY] [d.x],[d.y],[d.z]",user);
				}else{
					send("[d.DISPLAY] [d.loc]",user);
				}
			}

			for(var/obj/item/NAMEK_DRAGONBALLS/d){
				if(d.x && d.y && d.z){
					send("[d.DISPLAY] [d.x],[d.y],[d.z]",user);
				}else{
					send("[d.DISPLAY] [d.loc]",user);
				}
			}
		}