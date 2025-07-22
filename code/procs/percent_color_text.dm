proc
	percent_color_text(min, max, text)
	{
		var/p = percent(min, max)

		if (p <= 25)
			return "{R[text]{x"
		if (p <= 50)
			return "{Y[text]{x"
		if (p <= 100)
			return "{B[text]{x"
		if (p)
			return "{C[text]{x"
	}

proc
	percent_color_noTex(min, max)
	{
		var/p = percent(min, max)

		if (p <= 25)
			return "{R"
		if (p <= 50)
			return "{Y"
		if (p <= 100)
			return "{B"
		if (p)
			return "{C"
	}
