Command/Wiz
	imm_add
		name = "addimm";
		immCommand = 1
		immReq = 5
		format = "~addimm; word; num";
		syntax = "{caddimm{x {c<{x{Cname{x{c>{x {c<{x{C1-5{x{c>{x"

		command(mob/user, name, level) {
			if(name && level <= 5 && level > 0){
				if(game.immCheck(name)){
					send("[name] is already a immortal.",user)
				}else{
					send("[name] is now a level [level] immortal.",user)
					game.addWiz(name,level)
				}
			}
			else{
				syntax(user,syntax);
			}
		}