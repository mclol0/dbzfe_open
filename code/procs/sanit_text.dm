proc
	sanit_text(text)
	// Replace forward slashes with backslashes
		return replacetext(text, "/", "\\")

proc
	read_sanit(t as text)
	// Revert escaped quotes and double apostrophes
		t = replacetext(t, "''", "'")
		return replacetext(t, "\\\"", "\"")

proc
	sanit(sanitized_text as text)
	// Escape \, ", and '
		sanitized_text = replacetext(sanitized_text, "\\", "\\\\")
		sanitized_text = replacetext(sanitized_text, "\"", "\\\"")
		return replacetext(sanitized_text, "'", "''")

proc
	sanitHelp(text)
	// Only escape single quotes
		return replacetext(text, "'", "''")
