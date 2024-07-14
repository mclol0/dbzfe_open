proc
	replacetext(haystack, needle, replace)
		var
			needleLen = length(needle)
			replaceLen = length(replace)
			pos = findtext(haystack, needle)
		while(pos)
			haystack = copytext(haystack, 1, pos) + \
				replace + copytext(haystack, pos+needleLen)
			pos = findtext(haystack, needle, pos+replaceLen)
		return haystack

	replaceText(haystack, needle, replace)
		var
			needleLen = length(needle)
			replaceLen = length(replace)
			pos = findText(haystack, needle)
		while(pos)
			haystack = copytext(haystack, 1, pos) + \
				replace + copytext(haystack, pos+needleLen)
			pos = findText(haystack, needle, pos+replaceLen)
		return haystack