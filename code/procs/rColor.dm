proc
	rColor(text, color, client){

		if(!color){ return call_ext(textLib,"StripColors")(text); }

		switch(client){
			if(TELNET){
				return call_ext(textLib,"ParseColors")(text);
			}

			if(BYOND){
				return call_ext(textLib,"ByondColors")(text);
			}
		}

		return text;
	}