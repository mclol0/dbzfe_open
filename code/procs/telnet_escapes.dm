proc
	telnet_escapes(client){
		switch(client){
			if(TELNET){
				return game.telnet_escapes;
			}

			if(BYOND){
				return game.byond_escapes;
			}
		}

		return game.telnet_escapes;
	}