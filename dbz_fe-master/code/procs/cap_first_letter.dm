proc
	/*
	This procedure will capitilize the first letter in any passed string argument.
	*/

	capFirstL(var/text as text){
		return uppertext(copytext(text,1,2)) + copytext(text, 2)
	}