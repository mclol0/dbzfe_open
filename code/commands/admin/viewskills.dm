Command/Wiz
	viewskills
		name = "viewskills";
		immCommand = 1
		immReq = 1
		format = "viewskills; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cviewskills{x {c<{x{Cmobile{x{c>{x";
		priority = 2

		command(mob/user, mob/m) {
			if(m){
				for(var/x in m.techniques){
					send("[x]",user);
				}
			}
			else{
				syntax(user,syntax);
			}
		}