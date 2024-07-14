Command/Wiz
	multiplay
		name = "multiplay";
		immCommand = 1
		immReq = 3
		format = "multiplay";
		priority = 2;

		command(mob/user) {
			if(game.multiplay){
				game.multiplay = FALSE;
				send("Multiplay disabled.",user);
			}else{
				game.multiplay = TRUE;
				send("Multiplay enabled.",user);
			}
		}