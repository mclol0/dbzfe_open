proc
	rColor(text, color, client){

		if(!color){ return call(textLib,"StripColors")(text); }

		switch(client){
			if(TELNET){
				return call(textLib,"ParseColors")(text);
			}

			if(BYOND){
				return call(textLib,"ByondColors")(text);
			}
		}

		return text;
	}