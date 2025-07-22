proc
	format_text(text, WEB = FALSE)
	{
		var/loc0 = findtextEx(text, "<a")

		while (loc0)
		{
			var
				tag_close = findtextEx(text, "</a>", loc0 + 1)
				tag_end = findtextEx(text, ">", loc0 + 1)

			if (!tag_close || !tag_end || tag_end >= tag_close)
				break // Malformed or incomplete tag

			var
				tag_content = copytext(text, loc0 + 1, tag_end) // e.g. aL50
				inner_text = copytext(text, tag_end + 1, tag_close)
				align_code = ckey(copytext(tag_content, 2, 3))
				width_text = copytext(tag_content, 3)
				width = text2num(width_text)
				align = LEFT

			switch (align_code)
				if ("l") align = LEFT
				if ("c") align = CENTER
				if ("r") align = RIGHT

			var/aligned = align_text(inner_text, width, align, WEB)

			text = copytext(text, 1, loc0) + aligned + copytext(text, tag_close + 4)

			loc0 = findtextEx(text, "<a")
		}

		return text
	}
