Command/Wiz
	setname
		name = "setname";
		immCommand = 1
		immReq = 3
		format = "~setname; !searc(mob@mobiles)|~searc(mob@mobiles); any";
		syntax = "{csetname{x {c<{x{Cmobile{x{c>{x {c<{x{Cpowerlevel{x{c>{x";

		command(mob/user, mob/Player/m, _newName) {
			if(m){
				_newName = ClearSpaces(_newName);

				if(m._changeName(_newName)){
					send("Their name is now [_newName]",user,TRUE);
				}else{
					send("Failed to set [m.raceColor(m.name)]'s name to [_newName]!",user,TRUE);
				}
			}
			else{
				syntax(user,syntax);
			}
		}