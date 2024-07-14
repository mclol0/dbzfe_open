ParserInput
	New(_rawText, _tokens, _source) {
		src._rawText = _rawText;
		src._tokens = _tokens;
		src._source = _source;
	}

	var
		_rawText;
		list/_tokens;
		mob/_source

	proc
		getText() {
			return src._rawText;
		}

		getFirstToken() {
			return src._tokens[1];
		}

		getTokens() {
			return src._tokens;
		}

		getSource() {
			return src._source;
		}
