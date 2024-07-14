Command/Wiz
	teach
		name = "teach";
		immCommand = 1
		immReq = 3
		format = "~teach; !searc(mob@mobiles)|~searc(mob@mobiles); any";
		syntax = "{cteach{x {c<{x{Cmobile{x{c>{x {c<{x{Cskill{x{c>{x";

		command(mob/user, mob/m, skill) {
			if(m && skill){
				m.learnSkill(skill,TRUE)
			}
			else{
				syntax(user,syntax);
			}
		}