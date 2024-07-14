Command/Wiz
	changalign
		name = "changalign";
		immCommand = 1
		immReq = 3
		format = "changalign; !searc(mob@mobiles)|~searc(mob@mobiles); any";
		syntax = "{cchangalign{x {c<{x{Cmobile{x{c>{x {c<{x{Cgood/evil{x{c>{x";
		priority = 2

		command(mob/user, mob/Player/m, align) {
			if(m){
				if(align=="good"){
					m.alignment = GOOD
					m.checkSk();
					send("{BYou suddenly feel peaceful....{x",m);
				}else if(align=="evil"){
					m.alignment = EVIL
					m.checkSk();
					send("{RYou suddenly feel disturbed....{x",m);
				}else{
					syntax(user,syntax);
				}
			}
			else{
				syntax(user,syntax);
			}
		}