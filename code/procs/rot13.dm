proc
	rot13(string)

		ASSERT(istext(string))

		var/string_len = length(string)
		var/new_string = ""

		//loop through every character in the string
		for(var/i = 1, i <= string_len, i++)
			var/ascii = text2ascii(string,i)
			if(ascii >= 65 && ascii <= 90) //replace upper case letters
				ascii += 13; if(ascii > 90) ascii -= 26

			else if(ascii >= 97 && ascii <= 122) //replace lower case letters
				ascii += 13; if(ascii > 122) ascii -= 26

			new_string += ascii2text(ascii)

		return new_string