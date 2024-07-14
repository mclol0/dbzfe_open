Command/Wiz
	ko
		name = "ko";
		immCommand = 1
		immReq = 3
		format = "~ko; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cko{x {c<{x{Cmobile{x{c>{x";
		priority = 2

		command(mob/user, mob/m) {
			if(m){
				m._doEnergy(-1000);
			}
			else{
				syntax(user,syntax);
			}
		}