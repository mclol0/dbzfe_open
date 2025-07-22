proc
	format_list(list/l, amount = 3, spacing = 23, EXTRA = FALSE)
	{
		var/curLine = 0
		var/text = ""

		for (var/listEnt in l)
		{
			// Add item
			text += listEnt

			// Pad with spaces based on visual length
			var/visual_length = length(rStrip_Escapes(listEnt))
			var/pad = spacing - (2 * visual_length - length(listEnt))
			if (pad > 0)
				for (var/i = 1 to pad)
					text += " "

			// Move to next line?
			curLine++
			if (curLine >= amount)
			{
				if (EXTRA) text += "\n"
				text += "\n"
				curLine = 0
			}
		}

		return text
	}
