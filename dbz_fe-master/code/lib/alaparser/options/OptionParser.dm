OptionParser
	proc
		_parsePrefix(list/L, str) {
			for(var/i = 1; i <= length(str); i++) {
				var/char = text2ascii(str, i);
				if(__isAlpha(char)) break;
				var/Option/opt = src._getPrefixOption(char);
				if(opt == NULL) continue;
				else L += opt;
			}
			return L;
		}

		_parsePostfix(list/L, str) {
			var/left = findtext(str, "(");
			var/right = findtext(str, ")");
			if(!left || !right || left > right || right < left) return L;

			var/body = copytext(str, left+1, right);
			var/list/bodyList = __textToList(body, "@");
			if(length(bodyList) != 2) return L;
			L += new /Option/postfix/range(bodyList[1], bodyList[2]);
		}

		parse(str) {
			. = new /list();
			src._parsePrefix(., str);
			src._parsePostfix(., str);
		}

		_getPrefixOption(t) {
			switch(ascii2text(t)) {
				if("!") return new /Option/prefix/forceValue;
				if("?") return new /Option/prefix/optional;
				if("%") return new /Option/prefix/caseSensitive;
				if("~") return new /Option/prefix/partial;
				else return NULL;
			}
		}