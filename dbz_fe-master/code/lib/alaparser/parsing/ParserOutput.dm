ParserOutput
	var
		_matchSuccess = FALSE;
		_commandSuccess = FALSE;
		Matcher/_matcher;

	proc
		setMatchSuccess(v) { src._matchSuccess = v; }
		setCommandSuccess(v) { src._commandSuccess = v; }
		setMatcher(m) { src._matcher = m; }
		getMatcher() { return src._matcher; }
		getMatchSuccess() { return src._matchSuccess; }
		getCommandSuccess() { return src._commandSuccess; }