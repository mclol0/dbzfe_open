proc/level2text(level)
	switch(level)
		if(LOG_OFF) return "OFF"
		if(LOG_FATAL) return "FATAL"
		if(LOG_ERROR) return "ERROR"
		if(LOG_WARN) return "WARN"
		if(LOG_INFO) return "INFO"
		if(LOG_DEBUG) return "DEBUG"
		if(LOG_TRACE) return "TRACE"
		if(LOG_ALL) return "ALL"

proc/text2level(text)
		if (text == "OFF") return LOG_OFF
		if (text == "FATAL") return LOG_FATAL
		if (text == "ERROR") return LOG_ERROR
		if (text == "WARN") return LOG_WARN
		if (text == "INFO") return LOG_INFO
		if (text == "DEBUG") return LOG_DEBUG
		if (text == "TRACE") return LOG_TRACE
		if (text == "ALL") return LOG_ALL