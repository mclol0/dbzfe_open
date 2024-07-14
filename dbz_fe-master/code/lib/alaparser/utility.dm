// A robust text2list implementation that doesn't error on odd strings
// and has the default option of skipping empty additions.
proc/TextMatch(Text, Name, multi, ignorecase)
	if(ignorecase)
		Name = lowertext(Name)
		Text = lowertext(Text)
	if(multi) return (Name == Text || copytext(Text,1,length(Name)+1)==Name)
	else return Text == Name

proc/__textToList(str, delim = ";", skip_empty = TRUE) {
	return text2list(str,delim);
	if(!str) {
		return new /list();
	}

	var/next = findtext(str, delim);
	var/last = 0;
	. = new /list();;
	while(next != 0) {
		var/txt = copytext(str, last+1, next);
		if(skip_empty == FALSE || txt) {
			. += txt;
		}
		last = next;
		next = findtext(str, delim, next+1, 0);
	}

	var/txt = copytext(str, last+1);
	if(skip_empty == FALSE || txt) {
		. += txt;
	}
}

// A robust list2text implementation that can skip empty entries.
proc/__listToText(list/L, delim = ";", skip_empty = TRUE) {
	if(!L || !length(L)) return "";

	. = "";
	for(var/entry in L) {
		if(skip_empty == FALSE || entry) {
			. = "[.][entry][delim]";
		}
	}

	if(skip_empty != FALSE) . = copytext(., 1, length(.) - length(delim) + 1);
}

proc/__replaceText(str, replace, with) {
	return __listToText(__textToList(str, replace, FALSE), with, FALSE);
}


proc/__textMatch(text, attempt, case = FALSE, partial = TRUE) {
	var/match = text;
	if(!case) {
		attempt = lowertext(attempt);
		match = lowertext(match);
	}

	if(partial) return (attempt == match || copytext(match, 1, length(attempt)+1) == attempt);
	else return (attempt == match);
}

proc/__isAlpha(ascii) {
	return ((ascii >= 65 && ascii <= 90) || (ascii >= 97 && ascii <= 122))
}

proc/__isTextNum(n) {
	return ("[text2num(n)]" == "[n]");
}