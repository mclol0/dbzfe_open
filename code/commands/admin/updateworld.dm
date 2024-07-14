Command/Wiz
	updateworld
		name = "updateworld";
		immCommand = 1
		immReq = 5
		format = "updateworld";

		command(mob/user) {
			if(world.system_type == UNIX){
				send("{RCOMPILE{x: Attempting compile DBZFE.dme...",game.players);
				shell("DreamMaker ../DBZFE.dme > ./compile.out");
				send(file2text("./compile.out"),game.players);
				fdel("./compile.out");
				shell("mv ../DBZFE.dmb ./");
				shell("mv ../DBZFE.rsc ./");

				send(" {Y({x{R*{x{Y){x            The world starts spinning             {Y({x{R*{x{Y){x ",game.players,TRUE);

				/*save players*/
				for(var/client/m){
					if(m.state == STATE_PLAYING){
						var/savefile/F=new("copyover/players/[rot13("[m]")]")
						m.mob.copyover = TRUE;
						F["mob"] << m.mob;
						F["x"] << m.mob.x;
						F["y"] << m.mob.y;
						F["z"] << m.mob.z;
					}else{
						m << "The server is currently in the process of a copyover please reconnect.";
						del(m)
					}
				}
				/*save players*/

				sleep(1 TICK)
				world.Reboot();

			}else{
				send("{RCOMPILE{x: This is disabled in windows.",user);
			}
		}