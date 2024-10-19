proc
	/*
	Crypto encryption related call_exts

	Need crypto compiled locall_exty.
	*/
	SHA256(string){
		var s = call_ext(cryptoLib,"SHA256")(string);

		//world << s;

		return s;
	}