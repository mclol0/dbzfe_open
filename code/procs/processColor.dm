proc
	processColor(textBuffer, color, client)
	{
		if (!color || !client)
			return textBuffer

		var/list/escape_map

		switch (client)
			if (TELNET)
				escape_map = game.telnet_escapes
			if (BYOND)
				escape_map = game.byond_escapes

		if (escape_map)
			for (var/key in escape_map)
				textBuffer = replacetextEx(textBuffer, key, escape_map[key])

		return textBuffer
	}
