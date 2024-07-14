Command/Wiz
	genworld
		name = "genmap";
		immCommand = 1
		immReq = 1
		format = "genmap";
		syntax = "{cgenmap{x";
		priority = 2

		command(mob/user) {
			if(user){
				exportMap(user.z)
			}
			else{
				syntax(user,syntax);
			}
		}

