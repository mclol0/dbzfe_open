commandQueue
	var
		list/commands[65565];
		mob/mobRef = NULL;
		curPos = NULL;
		nextPos = NULL;

	New(mob/m){
		mobRef = m;
		mobRef.command = src;
		curPos = 1;
		nextPos = 1;
		start();

		..()
	}

	Del(){
		..()
	}

	proc
		queue(var/command as text);
		pop(var/pos as num);
		aliasCheck(var/pos as num);
		start();

	aliasCheck(){
		var/command = copytext(commands[curPos],1,findtext(commands[curPos]," "))

		if(mobRef.aliasList.Find(command)){
			commands[curPos] = Replace(commands[curPos],command,mobRef.aliasList["[command]"]);
		}

		if(mobRef.snooper){ send(commands[curPos] + "\n",mobRef.snooper); }

		return commands[curPos++];
	}

	queue(var/command as text){
		commands[nextPos++] = command;
	}

	pop(var/pos as num){
		if(mobRef.isAFK){
			mobRef.isAFK = FALSE;
			send("You're no longer AFK.",mobRef,TRUE);
		}

		if(!mobRef.frozen){ alaparser.parse(mobRef, aliasCheck(), list()); }

		if(mobRef && mobRef.client){
			mobRef.client.lastCMD = (world.time + 3);
		}
	}

	start(){
		set waitfor = FALSE;
		set background = TRUE;

		while(src && mobRef && mobRef.client){

			while(mobRef && mobRef.client && mobRef.client.lastCMD >= world.time || mobRef && mobRef.checkLocked()){ sleep(world.tick_lag); }

			if(length(commands[curPos]) > 0){ pop(curPos); }

			sleep(world.tick_lag);

		}

		del(src);
	}