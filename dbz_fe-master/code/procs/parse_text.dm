proc
	parseText(text){
		if(findtextEx(text,"$name"))
			text = replacetext(text,"$name",game.name)

		if(findtextEx(text,"$time"))
			text = replacetext(text,"$time",systemTime())

		if(findtextEx(text,"$tick"))
			text = replacetext(text,"$tick","[commafy(world.time)]")

		if(findtextEx(text,"$players"))
			text = replacetext(text,"$players","[commafy(game.players.len)]")

		if(findtextEx(text,"$cpu"))
			text = replacetext(text,"$cpu","[world.cpu]")

		if(findtextEx(text,"$world_objects"))
			text = replacetext(text,"$world_objects","[commafy(world.contents.len)]")

		return text;
	}