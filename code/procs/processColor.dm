proc
	processColor(textBuffer, color, client){

		if(color && client){
			switch(client){
				if(TELNET){
					for(var/X in game.telnet_escapes){
						textBuffer = replacetextEx(textBuffer,X,game.telnet_escapes[X]);
					}
				}

				if(BYOND){
					for(var/X in game.byond_escapes){
						textBuffer = replacetextEx(textBuffer,X,game.byond_escapes[X]);
					}
				}
			}
		}

		return textBuffer;
	}