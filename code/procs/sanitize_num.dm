proc
	sanitize_num(n = 0, no_negative = FALSE, no_decimal = FALSE)
	{
		// Step 1: Handle number conversion
		if (isnum(n))
		{
			if (no_negative && n < 0) n = -n
			if (no_decimal) n = round(n, 1)
			n = num2text(n, 999)
		}
		if (!istext(n)) n = "0"

		// Step 2: Strip commas (ascii 44)
		while (findtextEx(n, ","))
			n = replacetext(n, ",", "")

		// Step 3: Strip negative sign if needed
		if (no_negative && length(n) && text2ascii(n, 1) == 45)
			n = copytext(n, 2)

		// Step 4: Convert scientific notation if present (E)
		var/idx = findtext(n, "E")
		if (idx)
		{
			var/e = round(text2num(copytext(n, idx + 1)) || 0)
			var/base = text2num(copytext(n, 1, idx)) || 0

			if (e)
			{
				if (e > 0)
					base *= 10 ** e
				else
					base /= 10 ** abs(e)
			}

			if (no_negative && base < 0) base = -base
			if (no_decimal) base = round(base, 1)

			n = num2text(base, 999)
		}

		// Step 5: Strip non-digit characters (except 1 '-' at start or 1 '.')
		var/new_text = ""
		var/had_decimal = FALSE

		for (var/i = 1, i <= length(n), i++)
		{
			var/ch = text2ascii(n, i)

			if (ch >= 48 && ch <= 57) // 0–9
				new_text += copytext(n, i, i + 1)
			else if (ch == 45 && !no_negative && i == 1) // minus
				new_text += "-"
			else if (ch == 46 && !no_decimal && !had_decimal) // period
				new_text += "."
				had_decimal = TRUE
			else
				break
		}

		return new_text || "0"
	}
