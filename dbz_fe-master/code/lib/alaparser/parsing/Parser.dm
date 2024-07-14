Parser
	var
		list/commands = new /list();

	proc
		_tokenize(str) {
			return __textToList(str, " ");
		}

		addCommand(Command/C) {
			commands += C;
		}

		preprocess(mob/user, str) {
			return TRUE;
		}

		postprocess(mob/user, str, Matcher/match) {
		}

		process(mob/user, str, list/commands) {
			if(!src.preprocess(user,str)) {
				return null;
			}

			var/list/tokens = src._tokenize(str);
			var/Matcher/leadingMatcher;
			var/list/winners = new /list();

			for(var/entry in user.commandList){
				var/Command/cmd = user.commandList[entry];
				var/ParserInput/userInput = new /ParserInput(str, tokens.Copy(), user);
				var/Matcher/matcher = new /Matcher(cmd, userInput);

				if(matcher._match() || matcher._getTokensMatched()) {
					winners += matcher;
				} else {
					if(leadingMatcher == null || matcher._getTokensMatched() > leadingMatcher._getTokensMatched()) {
						leadingMatcher = matcher;
					}
				}
			}

			var/Matcher/bestMatcher = src._selectWinner(winners);
			if(!bestMatcher) bestMatcher = leadingMatcher;

			var/ParserOutput/out = new();

			var/Command/cmd = bestMatcher.getCommand();
			if(bestMatcher._isSuccessful() || bestMatcher._getTokensMatched()) {
				out.setMatchSuccess(TRUE);
				if(cmd.preprocess(user)) {

					if(user.doingPushups && bestMatcher._parent.cancelsPushups){ user.doingPushups = FALSE;sleep(1) }

					bestMatcher._parent._go(user, bestMatcher);
					cmd.postprocess(user);
					src.postprocess(user, str, bestMatcher);
					out.setCommandSuccess(TRUE);
				}
			}
			out.setMatcher(bestMatcher);
			if(!out.getMatchSuccess() && user && user.client){ user.client.bust_prompt = TRUE;user.client.bust_error = TRUE; }
			return out;
		}

		_sortWinners(list/winners)	{
			for(var/Matcher/C in winners){
				for(var/x=1,x<winners.len,x++){
					var/Matcher/K = winners[x]

					if(C.getPriority() > K.getPriority()){
						winners.Remove(K)
					}
				}
			}
		}

		_selectWinner(list/winners) {
			var/Matcher/strongest;

			_sortWinners(winners);

			for(var/Matcher/matcher in winners) {
				if(!strongest || matcher.getPriority() > strongest.getPriority() && matcher._getFirstMatchStrength() > strongest._getFirstMatchStrength()) {
					strongest = matcher;
				}
			}
			return strongest;
		}
