Command/Wiz
	koall
		name = "koall";
		immCommand = 1
		immReq = 5
		format = "koall";
		syntax = "{ckoall{x {c<{x{Cmobile{x{c>{x";
		priority = 2

		command(mob/user) {
			for(var/mob/NPA/m in world){
				m._doEnergy(-1000);
			}
		}