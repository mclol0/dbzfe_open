proc
	/*
	This procedure will get rid of any unwanted whitespace.
	*/
	ClearSpaces(var/String) // Takes out all of the first spaces
		var/firstchar = copytext(String, 1, 2)
		if(firstchar == " " || firstchar == "	")
			var/NewString = copytext(String, 2)
			return ClearSpaces(ClearMiddleSpaces(NewString))
		else return ClearMiddleSpaces(String)

	ClearMiddleSpaces(String)
		for(var/i = 1, i < length(String), i ++)
			var/twochars = copytext(String, i, i + 2)
			if(twochars == "  " || twochars == "	 " || twochars == "		" || twochars == " 	")
				var/FrontString = copytext(String, 1, i + 1)
				var/BackString = copytext(String, i + 2)
				var/NewString = FrontString + BackString
				return ClearMiddleSpaces(NewString)
			else continue
		return String