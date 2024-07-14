Command/Wiz
	shutdown
		name = "shutdown";
		immCommand = 1
		immReq = 5
		format = "~shutdown; num";
		syntax = "{cshutdown{x {c<{x{Cseconds{x{c>{x";

		command(mob/user, seconds) {
			if(seconds){
				send("[game.name] shutting down in [seconds] seconds.",game.players)
				spawn(seconds*10){
					for(var/mob/Player/m in world)
						game.players.Remove(m)
						m.saveSQLCharacter()
					shutdown()
				}
			}
			else{
				syntax(user,syntax);
			}
		}