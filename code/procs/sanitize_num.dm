proc
	sanitize_num(n=0, no_negative, no_decimal)
		if(isnum(n))
			if(no_negative && n < 0) n = -n
			if(no_decimal) n = round(n, 1)
			n = num2text(n, 999)
		if(!istext(n)) n = "0"
		// strip commas
		var/idx = findtextEx(n, ascii2text(44))
		while(idx)
			n = copytext(n, 1, idx) + copytext(n, idx+1)
			idx = findtextEx(n, ascii2text(44))
		// strip negative
		if(no_negative)
			if(n && text2ascii(n,1) == 45) n = copytext(n, 2)
		// look for scientific notation
		idx = findtext(n, ascii2text(69))
		if(idx)
			var/e = round(text2num(copytext(n, idx+1) || 0))
			n = text2num(copytext(n, 1, idx) || 0)
			while(e > 0)
				n *= 10
				--e
			while(e < 0)
				n /= 10
				++e
			if(no_negative && n < 0) n = -n
			if(no_decimal) n = round(n, 1)
			n = num2text(n, 999)
		// strip any non-digits
		for(idx=1, idx<=length(n), ++idx)
			var/ch = text2ascii(n,idx)
			if(ch < 48 || ch > 57)
				if(ch == 45 && !no_negative && idx == 1)
					continue
				if(ch == 46 && !no_decimal)
					no_decimal = 1
					continue
				n = copytext(n, 1, idx)
				break
		return n