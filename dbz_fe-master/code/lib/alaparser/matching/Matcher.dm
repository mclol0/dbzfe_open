Matcher
	New(Command/cmd, ParserInput/inp) {
		src._matchers = list(cmd._getFirstComponent());
		src._values = new /list();
		src._parent = cmd;
		src._clientInput = inp;
		src._ignoredValueTypes = src.getIgnoredValueTypes();
	}

	var
		list/_matchers;
		list/_ignoredValueTypes;
		_tokensMatched = 0;
		_success = FALSE;
		list/_values;
		ParserInput/_clientInput;
		Command/_parent;

	proc
		_consumeTokens(n) {
			var/list/tokens = src._clientInput.getTokens();
			tokens.Cut(1,1+n);
			_tokensMatched += n;
		}

		_addValue(val) {
			_values += val;
		}

		_getValues() {
			return _values;
		}

		_includeValue(MatcherComponent/comp) {
			if(comp._isForcedValue()) return TRUE;
			if(comp._getType() in src._ignoredValueTypes) return FALSE;
			return TRUE;
		}

		_getTokensMatched() {
			return _tokensMatched;
		}

		_getFirstMatchStrength() {
			var/MatcherComponent/first = src._matchers[1];
			if(!first._isPartial()) return 100;

			if(istype(first, /MatcherComponent/literal)) {
				var/MatcherComponent/literal/lit = first;
				return 100 - length(lit.word);
			}
			return 100;
		}

		_isSuccessful() {
			return src._success;
		}

		_hasTokensLeft() {
			return (src._clientInput.getTokens() && length(src._clientInput.getTokens()));
		}


		_match() {
			for(var/i = 1; i <= length(_matchers); i++) {
				var/MatcherComponent/comp = _matchers[i];
				if(!_hasTokensLeft()) {
					if(!comp._isOptional()) {
						return FALSE;
					} else {
						_addValue(NULL);
						if(i == 1) _matchers = _parent._getComponents();
						continue;
					}
				}

				comp.match(src._clientInput);

				if(!comp.isSuccessful()) {
					if(!comp._isOptional()) {
						return FALSE;
					} else {
						_addValue(NULL);
						if(i == 1) _matchers = _parent._getComponents();
						continue;
					}
				} else {
					if(_includeValue(comp)) _addValue(comp.getValue());
					_consumeTokens(comp.getTokenCount());
					if(i == 1) _matchers = _parent._getComponents();
				}

			}

			if(length(src._clientInput.getTokens())) return FALSE;
			src._success = TRUE;
			return TRUE;
		}

		getCommand() {
			return src._parent;
		}

		getPriority() {
			return src._parent.priority;
		}

		getIgnoredValueTypes() {
			. = new /list();
			. += /MatcherComponent/literal;
		}

MatcherResult
	var
		list/componentResults;
