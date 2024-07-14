Command/Wiz
	disconnect
		name = "disconnect";
		immCommand = 1
		immReq = 1
		format = "~disconnect; !searc(mob@mobiles)|~searc(mob@mobiles); any";
		syntax = "{cdisconnect{x {c<{x{Cclient{x{c>{x";

		command(mob/user, mob/Player/m, reason) {
			if(m && m.client){
				if(m == user){
					send("You can't disconnect yourself dingus!",user)
				}else{
					send("[m.raceColor(m.name)] has been disconnected.",user)
					send(reason,m,TRUE);
					sleep(1)
					m.disconnect();
				}
			}
			else{
				syntax(user,syntax);
			}
		}