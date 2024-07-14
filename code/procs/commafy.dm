proc
	commafy(N, SigFig=999)
		var/negative = FALSE;

		if(N<0){negative=TRUE;}

		. = num2text(abs(N), SigFig)

		var/end = findtextEx(., ".") || length(.)+1

		for(var/pos=end-3, pos>1, pos-=3)
			. = copytext(., 1, pos) + "," + copytext(.,pos)

		if(negative){ . = "-[.]"; }