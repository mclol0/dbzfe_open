Command/Wiz
	setlc
		name = "setlc";
		immCommand = 1
		immReq = 3
		format = "~setlc; !searc(mob@mobiles)|~searc(mob@mobiles); num";
		syntax = "{csetlc{x {c<{x{Cmobile{x{c>{x {c<{x{Cpowerlevel{x{c>{x";

		command(mob/user, mob/m, amount) {
			if(m){
				m.labcredits = amount
				send("You have set [m.name]'s lab credits to [commafy(amount)]",user)
			}
			else{
				syntax(user,syntax);
			}
		}