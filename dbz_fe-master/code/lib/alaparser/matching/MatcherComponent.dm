MatcherComponent
	New(list/opts) {
		src._options = opts;
	}

	var
		list/_options = new /list();
		_name;
		ComponentResult/_result;

	proc
		_getType() {
			return src.type;
		}

		_success(count, value) {
			_result = new();
			_result.setTokenCount(count);
			_result.setValue(value);
			_result.setSuccess(TRUE);
			return TRUE;
		}

		_failure() {
			_result = new();
			_result.setSuccess(FALSE);
			return FALSE;
		}

		_isCaseSensitive() {
			if(locate(/Option/prefix/caseSensitive) in src._options) return TRUE;
			return FALSE;
		}

		_isPartial() {
			if(locate(/Option/prefix/partial) in src._options) return TRUE;
			return FALSE;
		}

		_isForcedValue() {
			if(locate(/Option/prefix/forceValue) in src._options) return TRUE;
			return FALSE;
		}

		_isOptional() {
			if(locate(/Option/prefix/optional) in src._options) {
				return TRUE;
			}
			return FALSE;
		}

		isSuccessful() {
			return src._result.isSuccessful();
		}

		getTokenCount() {
			return src._result.getTokenCount();
		}

		getValue() {
			return src._result.getValue();
		}

		getName() {
			if(!_name) return src.type;
			else return _name;
		}

		clone() {
			var/p = src.type;
			var/MatcherComponent/other = new p();
			other._options = src._options;
			return other;
		}

		match(ParserInput/inp) {
		}

