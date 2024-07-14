Logger
	var
		name = ""
		level = LOG_ALL
		logging = FALSE
		additivity = TRUE
		list/appenders = NULL;
		list/loggers = NULL;

	New(Appender/_default_appender, _name)
		if(_default_appender) addAppender(_default_appender)
		name = _name

	proc
		fatal(log) _log(log, LOG_FATAL)
		error(log) _log(log, LOG_ERROR)
		warn(log) _log(log, LOG_WARN)
		info(log) _log(log, LOG_INFO)
		debug(log) _log(log, LOG_DEBUG)
		trace(log) _log(log, LOG_TRACE)

		getLogger(name)
			if(name in loggers) return loggers[name]
			else
				if(!loggers) loggers = list()

				var/Logger/logger = new/Logger(, name)
				addLogger(logger, name)

				return logger

		addLogger(Logger/logger, name)
			if(!loggers) loggers = list(name = logger)
			else
				loggers += name
				loggers[name] = logger

				if(logging && !logger.logging) logger.startLogging()
				else if(!logging && logger.logging) logger.endLogging()

		removeLogger(name)
			loggers -= name
			if(!length(loggers)) loggers = NULL;

		setLevel(level)
			ASSERT(level <= LOG_OFF && level >= LOG_ALL)
			src.level = level

		getLevel() return level

		_log(log, level)
			if(!logging) return

			if(level in list(LOG_INFO,LOG_WARN,LOG_ERROR,LOG_FATAL,LOG_TRACE)){ game.immMsg("\[[level2text(level)]: [log]\]"); }

			if(level < src.level) return

			for(var/Appender/appender in appenders) appender.append(log, level, name)

			for(var/name in loggers)
				var/Logger/logger = loggers[name]
				logger._log(log, level)

		startLogging()
			logging = TRUE

			for(var/Appender/appender in appenders) appender.startLog()

			for(var/name in loggers)
				var/Logger/logger = loggers[name]
				if(!logger.logging) logger.startLogging()

		endLogging()
			logging = FALSE

			for(var/Appender/appender in appenders) appender.endLog()

			for(var/name in loggers)
				var/Logger/logger = loggers[name]
				if(logger.logging) logger.endLogging()

		addAppender(Appender/appender)
			if(!appenders) appenders = list(appender)
			else appenders += appender

			for(var/name in loggers)
				var/Logger/logger = loggers[name]
				if(logger.additivity) logger.addAppender(appender)

		removeAppender(Appender/appender)
			appenders -= appender
			if(!length(appenders)) appenders = NULL;

			for(var/name in loggers)
				var/Logger/logger = loggers[name]
				if(logger.additivity) logger.removeAppender(appender)

		htmlFileConfig(file)
			ASSERT(file)

			var
				Layout/HTMLLayout/html_layout = new
				Appender/FileAppender/file_appender = new(html_layout, file)

			addAppender(file_appender)

		plaintextFileConfig(file)
			ASSERT(file)

			var
				Layout/PlaintextLayout/plaintext_layout = new
				Appender/FileAppender/file_appender = new(plaintext_layout, file)

			addAppender(file_appender)

		plaintextWorldLogConfig()
			var
				Layout/PlaintextLayout/plaintext_layout = new
				Appender/WorldLogAppender/worldlog_appender = new(plaintext_layout)

			addAppender(worldlog_appender)