proc
	rStrip_Escapes(text){
		return call_ext(textLib,"StripColors")(text)
	}