Command/Wiz
	setzenni
		name = "setzenni";
		immCommand = 1
		immReq = 3
		format = "~setzenni; !searc(mob@mobiles)|~searc(mob@mobiles); num";
		syntax = "{csetzenni{x {c<{x{Cmobile{x{c>{x {c<{x{Camount{x{c>{x";

		command(mob/user, mob/m, amount) {
			if(m){
				m.zenni = amount
				send("You have set [m.name]'s zenni to [commafy(amount)]",user)
			}
			else{
				syntax(user,syntax);
			}
		}