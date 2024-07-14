
Command
	New() {
		format = __replaceText(format," ","");

		if(!src.format) return;
		src._setComponents(alaparser.generator._fromCommand(src));
	}

	var
		internal_name = NULL;
		visible = TRUE;
		name = NULL;
		list/syntax = list();
		_auto_create = TRUE;
		format = NULL;
		priority = 0;
		list/_components;
		canAlwaysUSE = FALSE;
		canUseWhileRESTING = FALSE;

		//Imm variables
		immCommand = 0;
		immReq = 0;

		//Other variables
		iCommand = TRUE; // iCommand?
		skillCommand = NULL; // Is this command a skill?
		tType = NULL; // Technique type ex: UTILITY, MELEE, ENERGY etc.
		_maxDistance = NULL; // Maximum distance a player can be before out of range for a skill.
		_minDistance = NULL; // Minimum distance a player must be before casting a skill.
		defenses[] = list(); // What defenses for this skill are there ex: PARRY_HIGH, PARRY_LOW etc.
		canFinish = NULL; // Can this skill kill the player.
		comboAble = NULL; // Can this skill be used as a combo
		comboName = NULL; // What the skill is displayed as in a combo output
		comboOptions[]; // Combo Options?
		breakCombo = TRUE; // Will this command break a combo currently in progress?
		needsSTUN = FALSE; //Does this command require the target to be stunned. Mostly used for help
		needsUnconscious = FALSE; //Does this command require the target to be stunned. Mostly used for help
		canSTUN = TRUE; // Can this melee attack cause you to get stunned if defended against?
		helpDescription = NULL // Description used for help system
		helpCategory = "General" // Category for help grouping
		canChangeBarrage = TRUE // Workaround for attacks that use the same logic as multiprojectile skills but cannot be modified by the user.
		cancelsPushups = TRUE;

		relatedNames[] = list() //For help system. Used for those commands that are a single point of access to help information (e.g. heal)
		relatedHelp[] = list() //For help system. List of related help files to show in See also

	proc
		getName() {
			return name
		}
		getDescription() {
			return helpDescription
		}

		getSyntax() {
			var/syntaxStr = "{R[name]{x"

			for (var/p in syntax) {
				syntaxStr = "[syntaxStr] {c<{C[p]{c>{x"
			}

			return syntaxStr
		}

		preprocess(mob/M) {
			return TRUE;
		}

		postprocess(mob/M) {
			src._setComponents(alaparser.generator._fromCommand(src)); // Memory leak fix we reset our components after use to clear any references
		}

		_go(mob/M, var/Matcher/match) {
			var/list/arguments = list(M) + match._getValues();
			if(length(arguments) > 0) {
				call(src,"command")(arglist(arguments));
			} else {
				call(src,"command")();
			}
		}

		_setComponents(list/L) {
			src._components = L;
		}

		_getFirstComponent() {
			return _components[1];
		}

		_getComponents() {
			. = new /list();
			for(var/MatcherComponent/comp in _components) {
				. += comp.clone();
			}
		}

		command() {
			CRASH("Command.command() default called. [src.type] must override command()!")
		}

		_getAutoCreate() {
			return _auto_create;
		}