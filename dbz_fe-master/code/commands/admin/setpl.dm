Command/Wiz
	setpl
		name = "setpl";
		immCommand = 1
		immReq = 3
		format = "~setpl; !searc(mob@mobiles)|~searc(mob@mobiles); num";
		syntax = "{csetpl{x {c<{x{Cmobile{x{c>{x {c<{x{Cpowerlevel{x{c>{x";

		command(mob/user, mob/m, powerlevel) {
			if(m){
				powerlevel = clamp(powerlevel, 2, MAX_PL*10)
				m.maxpl = powerlevel
				m.currpl = m.getMaxPL()
				send("You have set [m.name]'s powerlevel to [commafy(powerlevel)]",user)
			}
			else{
				syntax(user,syntax);
			}
		}