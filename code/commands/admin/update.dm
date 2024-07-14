proc/update(){
	set waitfor=FALSE;

	send("{RUPDATE{x: Attempting compile DBZFE.dme...",game.players);
	shell("DreamMaker ../DBZFE.dme > ./compile.out");
	var/output = file2text("./compile.out");
	var/start = world.time;

	while(!findtextEx(output,"saving")){
		if((world.time - start) >= 60){break;}
		sleep(world.tick_lag)
	}

	if(findtextEx(output,"saving")){

		send("{RUPDATE{x: {GSuccess.{x",game.players);

		shell("mv ../DBZFE.dmb ./");
		//shell("mv ../DBZFE.rsc ./");

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
		fdel("./compile.out");
		sleep(1 TICK)
		world.Reboot();
	}else{
		send(output,game.players);
		send("{RUPDATE: Failed.{x",game.players);
		fdel("./compile.out");
	}
}

Command/Wiz
	update
		name = "update";
		immCommand = 1
		immReq = 5
		format = "update";

		command(mob/user) {
			if(world.system_type == UNIX){
				update();
			}else{
				send("{RCOMPILE{x: This is disabled in windows.",user);
			}
		}