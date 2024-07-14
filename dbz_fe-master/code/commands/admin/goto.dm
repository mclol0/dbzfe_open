Command/Wiz
	gotoc
		name = "goto";
		immCommand = 1
		immReq = 2
		format = "~goto; num; num; num";
		priority = 1;
		syntax = "{cgoto{x {c<{x{Cx{x{c>{x {c<{x{Cy{x{c>{x {c<{x{Cz{x{c>{x";

		command(mob/user, x, y, z) {
			if(user && x && y && z){
				user.insideBuilding = 0;
				user.loc=locate(x,y,z)
				send("You goto [x],[y],[z].",user)
			}else{
				syntax(user,syntax);
			}

		}