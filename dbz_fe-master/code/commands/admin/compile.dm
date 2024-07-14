Command/Wiz
	compile
		name = "compile";
		immCommand = 1
		immReq = 5
		format = "compile";

		command(mob/user) {
			if(world.system_type == UNIX){
				send("{RCOMPILE{x: Attempting compile DBZFE.dme...",game.players);
				shell("DreamMaker ../DBZFE.dme > ./compile.out");
				send(file2text("./compile.out"),game.players);
				fdel("./compile.out");
				shell("mv ../DBZFE.dmb ./");
				//shell("mv ../DBZFE.rsc ./");
			}else{
				send("{RCOMPILE{x: This is disabled in windows.",user);
			}
		}