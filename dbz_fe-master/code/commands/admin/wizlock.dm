Command/Wiz
	wizlock
		name = "wizlock";
		immCommand = 1
		immReq = 3
		format = "wizlock";
		syntax = "{cwizlock{x";

		command(mob/user) {
			if(game.locked){
				game.locked = FALSE;
				send("[game.name] is no longer wizlocked!",game.players)
			}else{
				game.locked = TRUE;
				send("[game.name] is now wizlocked!",game.players)
			}
		}