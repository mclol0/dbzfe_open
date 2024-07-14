Command/Wiz
	destroydbs
		name = "destroydbs";
		immCommand = 1
		immReq = 3
		format = "destroydbs";
		priority = 2;

		command(mob/user) {
			for(var/obj/item/DRAGONBALLS/d){
				del(d)
			}
			_query("DELETE  FROM `dragonballs`;");
		}