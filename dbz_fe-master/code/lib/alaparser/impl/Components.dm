MatcherComponent
    multi
        _name = "__multi__";

        var
            list/_components = list();
            MatcherComponent/_winner;

        _getType() {
            return _winner.type;
        }

        clone() {
            var/p = src.type;
            var/MatcherComponent/multi/other = new p();
            other._components = src._components.Copy();
            return other;
        }

        match(ParserInput/inp) {
            for(var/MatcherComponent/comp in src._components) {
                if(comp.match(inp)) {
                    src._options = comp._options;
                    src._result = comp._result;
                    src._winner = comp;
                    return TRUE;
                }
            }
            return src._failure();
        }

    any
        _name = "any";
        match(ParserInput/inp) {
            return src._success(length(inp.getTokens()), __listToText(inp.getTokens(), " "));
        }

    word
        _name = "word";
        match(ParserInput/inp) {
            var/str = inp.getFirstToken();
            if(length("[text2num(str)]") == length(str)) {
                return src._failure();
            } else {
                return src._success(1, str);
            }
        }

    num
        _name = "num";
        match(ParserInput/inp) {
            var/str = inp.getFirstToken();
            var/numstr = text2num(str);
            if(!isnum(numstr)) {
                return src._failure();
            } else {
                return src._success(1, numstr);
            }
        }

    literal
        New(word, list/opts) {
            src.word = word;
            ..(opts);
        }

        _name = "__literal__";
        var
            word

        clone() {
            var/MatcherComponent/literal/other = ..();
            other.word = src.word;
            return other;
        }

        match(ParserInput/inp) {
            var/text = inp.getFirstToken();
            if(__textMatch(word, text, src._isCaseSensitive(), src._isPartial())) {
                return src._success(1, src.word);
            } else {
                return src._failure();
            }
        }

    searc
        New(list/opts) {
            ..(opts);
            src._rangeOption = locate(/Option/postfix/range) in src._options;
        }

        _name = "searc";
        clone() {
            var/MatcherComponent/searc/other = ..();
            other._rangeOption = src._rangeOption;
            return other;
        }

        match(ParserInput/inp) {
            var/list/possibles = src._rangeOption._getPossibles(inp.getSource());
            return findTarget(inp, possibles);
        }

        var
            Option/postfix/range/_rangeOption;

        proc
            _getEntryKeywords(entry) {
                return entry:getMatchKeywords();
            }

            isMatch(entry, attempt) {
                var/list/keywords = src._getEntryKeywords(entry);

                for(var/word in keywords) {
                    if(__textMatch(word, attempt, src._isCaseSensitive(), src._isPartial())) return TRUE;
                }
                return FALSE;
            }

            findTarget(ParserInput/inp, list/possibles) {
                var/attempt = inp.getFirstToken();
                var/match = null;
                var/dot = findtext(attempt, ".");
                var/matchNumber = 1;
                if(dot != 0) {
                    var/first = copytext(attempt, 1, dot);
                    if(__isTextNum(first)) {
                        attempt = copytext(attempt, dot+1);
                        matchNumber = text2num(first);
                    }
                }

                for(var/entry in possibles) {
                    if(src.isMatch(entry, attempt)) {
                        match = entry;
                        if(--matchNumber == 0) break;
                    }
                }

                if(match != null && matchNumber == 0) {
                    return src._success(1, match);
                } else {
                    return src._failure();
                }
            }
