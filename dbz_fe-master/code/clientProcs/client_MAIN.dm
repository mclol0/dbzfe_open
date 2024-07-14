client
	var
		ctype = BYOND;
		state = STATE_LOGIN;
		lastCMD = NULL;
		bust_prompt = FALSE;
		bust_error = FALSE;

	New(){

		if(findtext(key,"@")) {
			ctype = TELNET;
		} else {
			ctype = BYOND;
		}

		..();

		game.logger.info("[game.translateIP(address)] connected.");
	}

	Del(){
		game.logger.info("[game.translateIP(address)] disconnected.");

		..();
	}

	Command(input as text){

		input=ktext.trimWhitespace(input);

		switch(state){
			if(STATE_PLAYING){
				if(mob.client.ctype == BYOND){ send(input,mob,TRUE); }

				if(ktext.len(input) > 0){
					mob.command.queue(input);
				}else{
					bust_prompt = TRUE;
				}
			}
		}
	}