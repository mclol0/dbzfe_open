Command/Wiz
	freeze
		name = "freeze";
		immCommand = 1
		immReq = 1
		format = "~freeze; !searc(mob@mobiles)|~searc(mob@mobiles)";
		syntax = "{cfreeze{x {c<{x{Cmobile{x{c>{x";
		priority = 2

		command(mob/user, mob/m) {
			if(m){
				if(m.frozen){
					send("[m.name] is now unfrozen.",user,TRUE);
					m.frozen = FALSE;
				}else{
					send("[m.name] is now frozen.",user,TRUE);
					m.frozen = TRUE;
				}
			}
			else{
				syntax(user,syntax);
			}
		}