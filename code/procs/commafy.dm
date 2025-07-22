proc
	commafy(N, SigFig = 999)
	{
		var/negative = (N < 0)
		var/text = num2text(abs(N), SigFig)

		var/decimal = findtextEx(text, ".")
		if (!decimal)
			decimal = length(text) + 1

		for (var/pos = decimal - 3; pos > 1; pos -= 3)
			text = copytext(text, 1, pos) + "," + copytext(text, pos)

		if (negative)
			text = "-" + text

		return text
	}
