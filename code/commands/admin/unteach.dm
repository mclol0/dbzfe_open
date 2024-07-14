Command/Wiz
	unteach
		name = "unteach";
		immCommand = 1
		immReq = 3
		format = "~unteach; !searc(mob@mobiles)|~searc(mob@mobiles); any";
		syntax = "{cunteach{x {c<{x{Cmobile{x{c>{x {c<{x{Cskill{x{c>{x";

		command(mob/user, mob/Player/m, skill) {
			if(m && skill){
				m.forgetSkill(skill)
			}
			else{
				syntax(user,syntax);
			}
		}