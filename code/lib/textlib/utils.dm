proc
	reversetext(string)
		for(var/i=length(string), i>0, --i)
			. += ascii2text(text2ascii(string,i))

	explodetext(string, delim, limit=0)
		. = new/list
		var/pos = findtext(string, delim), tpos, str
		if(limit > 1)
			var/ct = 1
			if(pos != 1)
				. += copytext(string, 1, pos)
				ct = 2
			while(ct < limit && pos)
				tpos = pos+1
				pos = findtext(string, delim, tpos)
				str = copytext(string, tpos, pos)
				if(str)
					. += str
					++ct
			str = copytext(string, pos+1)
			if(str)
				. += str
		else if(limit == 1)
			. += string
		else
			if(pos != 1)
				. += copytext(string, 1, pos)
			while(pos)
				tpos = pos+1
				pos = findtext(string, delim, tpos)
				str = copytext(string, tpos, pos)
				if(str) . += str

	explodeText(string, delim, limit=0)
		. = new/list
		var/pos = findText(string, delim), tpos, str
		if(limit > 1)
			var/ct = 1
			if(pos != 1)
				. += copytext(string, 1, pos)
				ct = 2
			while(ct < limit && pos)
				tpos = pos+1
				pos = findText(string, delim, tpos)
				str = copytext(string, tpos, pos)
				if(str)
					. += str
					++ct
			str = copytext(string, pos+1)
			if(str)
				. += str
		else if(limit == 1)
			. += string
		else
			if(pos != 1)
				. += copytext(string, 1, pos)
			while(pos)
				tpos = pos+1
				pos = findText(string, tpos, pos)
				if(str) . += str

	implodetext(list/L, delim)
		if(L.len)
			. = L[1]
			for(var/i in 2 to L.len)
				. += delim + L[i]