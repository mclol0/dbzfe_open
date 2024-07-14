Command/Wiz
	reboot
		name = "reboot";
		immCommand = 1
		immReq = 2
		format = "~reboot; num";
		syntax = "{creboot{x {c<{x{Cseconds{x{c>{x";

		command(mob/user, seconds) {
			if(seconds){
				send("[game.name] rebooting in [seconds] seconds.",game.players)
				spawn(seconds*10){
					for(var/mob/Player/m in world)
						game.players.Remove(m)
						m.saveSQLCharacter()
					world.Reboot()
				}
			}
			else{
				syntax(user,syntax);
			}
		}