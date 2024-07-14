Command/Wiz
	imm_remove
		name = "remimm";
		immCommand = 1
		immReq = 5
		format = "~remimm; word";
		syntax = "{cremimm{x {c<{x{Cname{x{c>{x";

		command(mob/user, name) {
			if(name){
				if(game.immCheck(name)){
					game.removeWiz(name)
					send("[name] is no longer a immortal.",user)
				}else{
					send("[name] is not a immortal.",user)
				}
			}
			else{
				syntax(user,syntax);
			}
		}