proc
	sanit_text(text){
		text = replacetext(text, "/", "\\")
		return text
	}

	read_sanit(var/t as text){
		t = replacetext(t, "''", "'")
		t = replacetext(t, "\\\"", "\"")
		return t
	}

	sanit(var/sanitized_text as text)
		sanitized_text = replacetext(sanitized_text, "\\", "\\\\")
		sanitized_text = replacetext(sanitized_text, "\"", "\\\"")
		sanitized_text = replacetext(sanitized_text, "'", "''")
		return sanitized_text
		
	sanitHelp(text) {
		text = replacetext(text, "'", "''")

		return text
	}