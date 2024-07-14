var
	list
		capital_letters = list("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z")
		allowed_characters = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
		illegal_names = list("Fuck", "Shit", "Fag", "Douche", "Queer", "Cunt", "Bitch", "Pussy", "Vagina", "Penis", "Cock", "Nigger", "Nigga", "Bastard", "Sucks", "Ass", "Dick")
		filtered_names = list("Kakarot", "Bojack", "Namek", "Saiyan", "Icer", "Majin", "Arlia", "Android", "Yajirobe", "Raditz", "Goku", "Vegeta", "Piccolo", "Bulma", "Vegeto", "Vegito", "Oolong", "Krillin", "Naruto", "Pokemon", "Trunks", "Goten", "Gotenks", "Gohan", "Roshi", "Cooler", "Chilled", "Salza", "Froze", "Frieza")
proc
	ASCII_Filter(var/text,var/options)
		var/options2 = Split(options,"&")
		var/list/allowedlist = list("")
		for(var/x in options2)
			if(findtext(x,"-"))
				var/startnum = text2num(copytext(x,1,4))
				var/endnum = text2num(copytext(x,5,8))
				for(var/i = startnum, i <= endnum)
					allowedlist += i
					i ++
			else
				allowedlist += text2num(x)
		for(var/ii = 1, ii <= length(text), ii++)
			var/a = text2ascii(copytext(text, ii, ii+1))
			if(a in allowedlist)
				continue
			else
				return 0
		return 1
	Split(var/textstring,var/splitcharacter)
		if(!istext(textstring))return
		if(!istext(splitcharacter))return
		var/list/list2make = list("")
		var/currenttext
		var/out = ""
		for(var/i = 1,i < length(textstring),i++)
			currenttext = copytext(textstring,i,i+1)
			if(length(textstring) - 1 == i)
				currenttext = copytext(textstring,i,i+2)
				out += currenttext
				if(out)list2make += out
				out = ""
				continue
			if(currenttext == splitcharacter)
				if(out)list2make += out
				out = ""
				continue
			out += currenttext
		return list2make

mob/proc
	Review_Name(name)
		var
			fill_name = ckey(name)
			config = "048-057&065-090&097-122&032"
			name_length = length(name)
		if(!fill_name)
			send("You must enter a name.",src)
			return 1
		if(!ASCII_Filter(name,config))
			send("Your name can only contain letters and numbers",src)
			return 1
		if(name == uppertext(name))
			send("Your name cannot be entirely capped",src)
			return 1
		for(var/f in filtered_names)
			if(findtext(name,f))
				send("Your name cannot contain '[f]'",src)
				return 1
		for(var/i in illegal_names)
			if(findtext(name,i))
				send("Your name cannot contain '[i]'",src)
				return 1
		if(name_length > 16 || name_length < 3)
			send("Your name must contain 3 to 16 characters.\n- Current Length: [name_length]",src)
			return 1
		if(!(capital_letters.Find(copytext("[name]",1,2))))
			send("Your name must start with a capital letter",src)
			return 1
		if(copytext(name,1,2) == " ")
			send("Your name cannot begin with a space",src)
			return 1
		if(findtext(name, " "))
			send("Your name cannot have a space.",src)
			return 1
		if(copytext(name,name_length,name_length+1) == " ")
			send("Your name cannot end with a space",src)
			return 1

	Review_Password(name)
		var
			fill_name = ckey(name)
			name_length = length("[name]")
		if(!fill_name)
			send("You must enter a password",src)
			return 1
		if(name_length > 30 || name_length < 6)
			send("Your password must contain 6 to 30 characters.\n- Current Length: [name_length]",src)
			return 1
		if(copytext(name,1,2) == " ")
			send("Your password cannot begin with a space",src)
			return 1
		if(findtext(name, " "))
			send("Your password cannot have a space.",src)
			return 1
		if(copytext(name,name_length,name_length+1) == " ")
			send("Your password cannot end with a space",src)
			return 1

	Review_Email(name)
		var
			fill_name = ckey(name)
			name_length = length(name)
		if(!fill_name)
			send("You must enter a email",src)
			return 1
		if(name_length > 50 || name_length < 6)
			send("Your email must contain 6 to 50 characters.\n- Current Length: [name_length]",src)
			return 1
		if(copytext(name,1,2) == " ")
			send("Your email cannot begin with a space",src)
			return 1
		if(findtext(name, " "))
			send("Your email cannot have a space.",src)
			return 1
		if(!findtext(name, "@"))
			send("This is not a valid email!",src)
			return 1
		if(copytext(name,name_length,name_length+1) == " ")
			send("Your email cannot end with a space",src)
			return 1