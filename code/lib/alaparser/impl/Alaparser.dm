var/Alaparser/alaparser = new();

Alaparser
	New(mainParser = TRUE, base_type = /Command) {
		src.generator = new();
		src.optionParser = new();
		src.commands = new();
		if(mainParser) spawn() _createMainParser(base_type);
	}

	proc
		parse(mob/user, str, list/add) {
			if(!add) add = list();

			if(user.updateCommands){ user.updateCommands(); user.updateCommands=FALSE; }

			var/list/total = new();
			for(var/a in commands) {
				total[a] = commands[a];
			}
			for(var/a in add) {
				total[a] = add[a];
			}
			return parser.process(user, str, total);
		}

		_createMainParser(base_type) {
			src.parser = new();
			for(var/p in typesof(base_type)) {
				var/Command/cmd = new p();
				if(!cmd._getAutoCreate() || !cmd.format) {
					del cmd;
				} else {
					commands += "[cmd.type]";
					commands["[cmd.type]"] = cmd;
				}
			}
			ready = TRUE;
		}

	var
		ready = FALSE;
		list/commands;
		Parser/parser;
		ComponentGenerator/generator
		OptionParser/optionParser
