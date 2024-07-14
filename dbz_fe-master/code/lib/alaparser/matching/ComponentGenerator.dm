ComponentGenerator
    New() {
        _populateTypes();
    }

    var
        list/_componentTypes;

    proc
        _isMultiComponent(entry) {
            var/hasPipe = findtext(entry, "|");
            if(!hasPipe) return FALSE;
            else return TRUE;
        }

        _getMultiComponentFromEntry(entry) {
            var/list/parts = __textToList(entry, "|");
            var/MatcherComponent/multi/comp = new();
            var/list/subComps = comp._components;
            for(var/part in parts) {
                var/MatcherComponent/compPart = src._getMatcherFromEntry(part);
                if(compPart != null) {
                    subComps.Add(compPart);
                }
            }
            if(!length(subComps)) return null;
            else return comp;
        }

        _populateTypes() {
            _componentTypes = new();

            for(var/t in typesof(/MatcherComponent) - /MatcherComponent) {
                var/MatcherComponent/real = new t();
                if(!real._name) continue;
                _componentTypes += real._name;
                _componentTypes[real._name] = real.type;
            }
        }

        _fromCommand(Command/cmd) {
            var/list/tokens = __textToList(cmd.format, ";");
            . = new /list();

            for(var/entry in tokens) {
                var/MatcherComponent/comp;
                if(src._isMultiComponent(entry)) {
                    comp = _getMultiComponentFromEntry(entry);
                } else {
                    comp = _getMatcherFromEntry(entry);
                }
                if(comp != null) . += comp;
            }
        }

        _getMatcherFromEntry(entry) {
            if(entry == "" || entry == null) return null;
            var/name = _getEntryName(entry);
            var/list/opts = _getEntryOptions(entry);
            return getMatcher(name, opts);
        }

        _getEntryName(entry) {
            var/end = findtext(entry, "(");
            if(end == 0) {
                end = length(entry) + 1;
            }

            for(var/i = 1; i <= length(entry); i++) {
                var/ascii = text2ascii(entry, i);
                if(__isAlpha(ascii)) {
                    return copytext(entry, i, end);
                }
            }
        }

        _getEntryOptions(entry) {
            return alaparser.optionParser.parse(entry);
        }

        _stripForLiteral(name) {
            var/first = findtext(name, "'");
            if(first == 0) return name;
            else return copytext(name, 1, first);
        }

        getMatcher(name, list/opts) {
            if(name in src._componentTypes) {
                var/path = src._componentTypes[name];
                return new path(opts);
            } else {
                return new /MatcherComponent/literal(_stripForLiteral(name), opts);
            }
        }
