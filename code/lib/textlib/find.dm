proc
	findtext_first_of(haystack, needle, pos=1)
		var/needleLen = length(needle)
		. = findtext(haystack, ascii2text(text2ascii(needle,1)), pos)
		for(var/i in 2 to needleLen)
			. = min(. , findtext(haystack, \
				ascii2text(text2ascii(needle,i)), pos)) || .

	findText_first_of(haystack, needle, pos=1)
		var/needleLen = length(needle)
		. = findText(haystack, ascii2text(text2ascii(needle,1)), pos)
		for(var/i in 2 to needleLen)
			. = min(. , findText(haystack, \
				ascii2text(text2ascii(needle,i)), pos)) || .


	findtext_first_not_of(haystack, needle, pos=1)
		var/haystackLen = length(haystack)
		for(var/i in 1 to haystackLen)
			if(!findtext(needle, ascii2text(text2ascii(haystack,i))))
				return i
		return 0

	findText_first_not_of(haystack, needle, pos=1)
		var/haystackLen = length(haystack)
		for(var/i in 1 to haystackLen)
			if(!findText(needle, ascii2text(text2ascii(haystack,i))))
				return i
		return 0


	findtext_last_of(haystack, needle, pos=0)
		if(!pos) pos = length(haystack)
		var/needleLen = length(needle)
		. = 0
		for(var/i in 1 to needleLen)
			for(var/j=pos, j>., --j)
				if(cmptext(ascii2text(text2ascii(haystack, j)), \
					ascii2text(text2ascii(needle, i))))
					. = j
					break

	findText_last_of(haystack, needle, pos=0)
		if(!pos) pos = length(haystack)
		var/needleLen = length(needle)
		. = 0
		for(var/i in 1 to needleLen)
			for(var/j=pos, j>., --j)
				if(text2ascii(haystack,j) == text2ascii(needle,i))
					. = j
					break

	findtext_last_not_of(haystack, needle, pos=0)
		if(!pos) pos = length(haystack)
		for(var/i=pos,i>0,--i)
			if(!findtext(needle, ascii2text(text2ascii(haystack,i))))
				return i
		return 0

	findText_last_not_of(haystack, needle, pos=0)
		if(!pos) pos = length(haystack)
		for(var/i=pos,i>0,--i)
			if(!findText(needle, ascii2text(text2ascii(haystack,i))))
				return i
		return 0