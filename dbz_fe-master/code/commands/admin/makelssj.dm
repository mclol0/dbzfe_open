Command/Wiz
	makelssj
		name = "makelssj";
		immCommand = 1
		immReq = 3
		format = "~makelssj; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cmakelssj{x {c<{x{Cmobile{x{c>{x";

		command(mob/user, mob/m) {
			if(m){
				if(m.race == SAIYAN){
					m:makeLSSJ();
				}
			}
			else{
				syntax(user,syntax);
			}
		}