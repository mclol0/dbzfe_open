/*Command/Wiz
	copyover
		name = "copyover";
		immCommand = 1
		immReq = 3
		format = "~copyover";
		syntax = "{ccopyover{x";
		priority = 2

		command(mob/user) {
			if(user){
				send(" {Y({x{R*{x{Y){x            The world starts spinning             {Y({x{R*{x{Y){x ",game.players,TRUE);

				/*save players*/
				for(var/client/m){
					if(m.state == STATE_PLAYING){
						var/savefile/F=new("copyover/players/[rot13("[m]")]")
						m.mob.copyover = TRUE;
						m.mob.dropDragonballs();
						m.mob:saveSQLCharacter();
						F["mob"] << m.mob;
						F["x"] << m.mob.x;
						F["y"] << m.mob.y;
						F["z"] << m.mob.z;
						game.players.Remove(m.mob);
					}else{
						m << "The server is currently in the process of a copyover please reconnect.";
						del(m)
					}
				}
				/*save players*/

				sleep(1 TICK)
				world.Reboot();
			}
			else{
				syntax(user,syntax);
			}
		}*/

Command/Wiz
	copyover
		name = "copyover";
		immCommand = 1
		immReq = 3
		format = "~copyover";
		syntax = "{ccopyover{x";
		priority = 2

		command(mob/user) {
			if(user){
				send(" {Y({x{R*{x{Y){x            The world starts spinning             {Y({x{R*{x{Y){x ",game.players,TRUE);

				/*save players*/
				for(var/client/m){
					if(m.state == STATE_PLAYING){
						var/savefile/F=new("copyover/players/[rot13("[m]")]")
						m.mob.copyover = TRUE;
						m.mob.dropDragonballs();
						m.mob:saveSQLCharacter();
						F["mob"] << m.mob.name;
						game.players.Remove(m.mob);
					}else{
						m << "The server is currently in the process of a copyover please reconnect.";
						del(m)
					}
				}
				/*save players*/

				sleep(1 TICK)
				world.Reboot();
			}
			else{
				syntax(user,syntax);
			}
		}