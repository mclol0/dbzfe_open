// Main color processing procedure
proc/rColor(text, color, client)
{
	if (!text) return text
	if (!color) return stripColors(text)

	switch(client)
		if ("TELNET")
			return parseTelnetColors(text)
		if ("BYOND")
			return parseByondColors(text)

	return parseTelnetColors(text)
}

// Strip all color codes from text
proc/stripColors(text)
{
	if (!text) return text
	var/processed = text

	var/list/curlyColors = list("{y", "{Y", "{c", "{C", "{m", "{M", "{r", "{R", "{b", "{B", "{g", "{G", "{d", "{D", "{w", "{W", "{o", "{x")
	for (var/color in curlyColors)
		processed = replacetextEx(processed, color, "")

	var/list/caretColors = list("^d", "^r", "^g", "^y", "^b", "^m", "^c", "^w", "^u", "^7", "^n")
	for (var/color in caretColors)
		processed = replacetextEx(processed, color, "")

	processed = replacetextEx(processed, ascii2text(27), "") // remove ESC characters
	return processed
}

// TELNET ANSI color formatting
proc/parseTelnetColors(text)
{
	if (!text) return text
	var/processed = text
	var/ESC = ascii2text(27)

	var/colors = list(
		"{y" = ESC + "\[0;33m", "{Y" = ESC + "\[1;33m", "{c" = ESC + "\[0;36m", "{C" = ESC + "\[1;36m",
		"{m" = ESC + "\[0;35m", "{M" = ESC + "\[1;35m", "{r" = ESC + "\[0;31m", "{R" = ESC + "\[1;31m",
		"{b" = ESC + "\[0;34m", "{B" = ESC + "\[1;34m", "{g" = ESC + "\[0;32m", "{G" = ESC + "\[1;32m",
		"{d" = ESC + "\[0;30m", "{D" = ESC + "\[1;30m", "{w" = ESC + "\[0;37m", "{W" = ESC + "\[1;37m",
		"{o" = ESC + "\[38;5;166m", "{x" = ESC + "\[0m"
	)

	var/bg = list(
		"^d" = ESC + "\[40m", "^r" = ESC + "\[41m", "^g" = ESC + "\[42m", "^y" = ESC + "\[43m",
		"^b" = ESC + "\[44m", "^m" = ESC + "\[45m", "^c" = ESC + "\[46m", "^w" = ESC + "\[47m",
		"^u" = ESC + "\[4m", "^n" = "", "^7" = ESC + "\[7m"
	)

	for (var/key in colors)
		processed = replacetextEx(processed, key, colors[key])

	for (var/key in bg)
		processed = replacetextEx(processed, key, bg[key])

	return processed
}

// BYOND HTML font color formatting
proc/parseByondColors(text)
{
	if (!text) return text
	var/processed = text

	var/colors = list(
		"{y" = "<font color=#cfcf00>", "{Y" = "<font color=#ffff00>", "{c" = "<font color=#008080>",
		"{C" = "<font color=#00ffff>", "{m" = "<font color=#cf00cf>", "{M" = "<font color=#ff00ff>",
		"{r" = "<font color=#cf0000>", "{R" = "<font color=#ff0000>", "{b" = "<font color=#0000cf>",
		"{B" = "<font color=#0000ff>", "{g" = "<font color=#008000>", "{G" = "<font color=#00ff00>",
		"{d" = "<font color=#000000>", "{D" = "<font color=#909090>", "{w" = "<font color=#cfcfcf>",
		"{W" = "<font color=#ffffff>", "{o" = "<font color=#CC3300>", "{x" = "</font>"
	)

	var/bg = list(
		"^d" = "<font color=#909090>", "^r" = "<font color=#cf0000>", "^g" = "<font color=#008000>",
		"^y" = "<font color=#ffff00>", "^b" = "<font color=#0000cf>", "^m" = "<font color=#cf00cf>",
		"^c" = "<font color=#008080>", "^w" = "<font color=#cfcfcf>", "^u" = "<u>", "^n" = "</u>",
		"^7" = "<font color=#cfcf00>"
	)

	for (var/key in colors)
		processed = replacetextEx(processed, key, colors[key])

	for (var/key in bg)
		processed = replacetextEx(processed, key, bg[key])

	return processed
}
