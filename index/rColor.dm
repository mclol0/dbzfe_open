proc
	rColor(text, color, client){
		// If color is disabled, strip all color codes
		if(!color){
			return stripColors(text);
		}

		// Process colors based on client type
		switch(client){
			if(TELNET){
				return parseTelnetColors(text);
			}

			if(BYOND){
				return parseByondColors(text);
			}
		}

		return text;
	}

// Strip all color codes from text (matches C code StripColors function)
proc/stripColors(text){
	if(!text) return text;

	var/processed = text;

	// Remove all {color} codes
	var/list/curlyColors = list("{y", "{Y", "{c", "{C", "{m", "{M", "{r", "{R", "{b", "{B", "{g", "{G", "{d", "{D", "{w", "{W", "{o", "{x")
	for(var/color in curlyColors){
		processed = replacetextEx(processed, color, "");
	}

	// Remove all ^color codes
	var/list/caretColors = list("^d", "^r", "^g", "^y", "^b", "^m", "^c", "^w", "^u", "^7")
	for(var/color in caretColors){
		processed = replacetextEx(processed, color, "");
	}

	// Remove escape sequences
	processed = replacetextEx(processed, "", "");

	return processed;
}

// Parse colors for TELNET clients (matches C code ParseColors function)
proc/parseTelnetColors(text){
	if(!text) return text;

	var/processed = text;

	// {color} codes for TELNET
	var/list/curlyColors = list(
		"{y" = "[0;33m", "{Y" = "[1;33m",
		"{c" = "[0;36m", "{C" = "[1;36m",
		"{m" = "[0;35m", "{M" = "[1;35m",
		"{r" = "[0;31m", "{R" = "[1;31m",
		"{b" = "[0;34m", "{B" = "[1;34m",
		"{g" = "[0;32m", "{G" = "[1;32m",
		"{d" = "[0;30m", "{D" = "[1;30m",
		"{w" = "[0;37m", "{W" = "[1;37m",
		"{o" = "[38;5;166m", "{x" = "[0m"
	)

	for(var/color in curlyColors){
		processed = replacetextEx(processed, color, curlyColors[color]);
	}

	// ^color codes for TELNET
	var/list/caretColors = list(
		"^d" = "[40m", "^r" = "[41m", "^g" = "[42m", "^y" = "[43m",
		"^b" = "[44m", "^m" = "[45m", "^c" = "[46m", "^w" = "[47m",
		"^u" = "[4m", "^n" = "", "^7" = "[7m"
	)

	for(var/color in caretColors){
		processed = replacetextEx(processed, color, caretColors[color]);
	}

	return processed;
}

// Parse colors for BYOND clients (matches C code ByondColors function)
proc/parseByondColors(text){
	if(!text) return text;

	var/processed = text;

	// {color} codes for BYOND
	var/list/curlyColors = list(
		"{y" = "<font color=#cfcf00>", "{Y" = "<font color=#ffff00>",
		"{c" = "<font color=#008080>", "{C" = "<font color=#00ffff>",
		"{m" = "<font color=#cf00cf>", "{M" = "<font color=#ff00ff>",
		"{r" = "<font color=#cf0000>", "{R" = "<font color=#ff0000>",
		"{b" = "<font color=#0000cf>", "{B" = "<font color=#0000ff>",
		"{g" = "<font color=#008000>", "{G" = "<font color=#00ff00>",
		"{d" = "<font color=#000000>", "{D" = "<font color=#909090>",
		"{w" = "<font color=#cfcfcf>", "{W" = "<font color=#ffffff>",
		"{o" = "<font color=#CC3300>", "{x" = "</font>"
	)

	for(var/color in curlyColors){
		processed = replacetextEx(processed, color, curlyColors[color]);
	}

	// ^color codes for BYOND
	var/list/caretColors = list(
		"^d" = "<font color=#909090>", "^r" = "<font color=#cf0000>",
		"^g" = "<font color=#008000>", "^y" = "<font color=#ffff00>",
		"^b" = "<font color=#0000cf>", "^m" = "<font color=#cf00cf>",
		"^c" = "<font color=#008080>", "^w" = "<font color=#cfcfcf>",
		"^u" = "<u>", "^n" = "</u>", "^7" = "<font color=#cfcf00>"
	)

	for(var/color in caretColors){
		processed = replacetextEx(processed, color, caretColors[color]);
	}

	// Remove escape sequences
	processed = replacetextEx(processed, "", "");

	return processed;
}