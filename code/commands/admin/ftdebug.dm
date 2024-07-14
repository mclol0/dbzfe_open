Command/Wiz
	ftdebug
		name = "ftdebug";
		immCommand = 1
		immReq = 3
		format = "ftdebug";
		syntax = "{cftdebug{x";
		priority = 2

		command(mob/user) {
			for(var/respawnMob/t){
				send("datum;[t]",user);
			}
			send("----",user);
			for(var/fTimer/t){
				send("datum;[t]",user)
				send("mob1;[t.MOB_1]",user)
				send("mob2;[t.MOB_2]",user)
				send("run;[t.RUNNING]",user)
			}
		}