Command/Wiz
	scatterdbs
		name = "scatterdbs";
		immCommand = 1
		immReq = 3
		format = "scatterdbs";
		priority = 2;

		command(mob/user) {
			send("{YThe Dragonball's are now active!{x",game.players,TRUE);

			DBDatum.COOLDOWN = 0;
			DBDatum_NAMEK.COOLDOWN = 0;

			for(var/obj/item/DRAGONBALLS/d){
				d.scatter();
			}
			for(var/obj/item/NAMEK_DRAGONBALLS/d){
				d.scatter();
			}
		}