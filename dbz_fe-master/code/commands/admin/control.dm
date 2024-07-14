Command/Wiz
	control
		name = "control";
		immCommand = 1
		immReq = 3
		format = "~control; !searc(mob@mobiles)|~searc(mob@mobiles); any";
		syntax = "{ccontrol{x {c<{x{Cmobile{x{c>{x {c<{x{Ccommand{x{c>{x";

		command(mob/user, mob/m, input) {
			if(m && input){
				if(length(input) > 0){
					var
						list/extras
						ParserOutput/out = alaparser.parse(m, input, extras);

					if(!out.getMatchSuccess()) {
						send("Invalid Command.",user)
					}
				}
			}
			else{
				syntax(user,syntax);
			}
		}