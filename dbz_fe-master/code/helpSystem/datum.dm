var/HELPSYSTEM/helpSystem = new()

HELPSYSTEM
	var
		//list/relationships = list()
		list/helpList = list()
		list/incompleteHelp = list()
		list/commandPaths = list(/Command)

	proc
		loadSystem() {
			helpList = list()
			incompleteHelp = list()
			loadFromCommands()
			loadFromDB()
			setupHelpReferences()
		}

		loadFromCommands() {
			for(var/P in commandPaths) {
				for(var/C in typesof(P)) {
					var/Command/command = new C

					if (command.visible) {
						var/HELPSYSTEM/HELPFILE/help = new()
						help.name = command:name
						help.internalName = command:internal_name
						help.relatedNames = command:relatedNames
						help.description = command:getDescription()
						help.usage = command:getSyntax()
						help.category = command:helpCategory
						help.related = command:relatedHelp
						help.fromSource = HELP_FROMCMD

						help.setupTeachers()

						if (help.isComplete()) {
							addToList(help)
						} else {
							addToList(help, incompleteHelp)
						}
					}
				}
			}
		}

		loadFromDB() {
			var/rowCount = _rowCount("FROM `help`;")

			if (rowCount > 1) {
				var/database/query/q = _query("SELECT * FROM `help`;")
				while(q.NextRow()){
					var/list/row = q.GetRowData()
					var/HELPSYSTEM/HELPFILE/help = new()

					help.name = row["name"]
					help.description = row["description"]
					help.usage = row["usage"]
					help.category = row["category"] ? row["category"] : "General"
					if (row["related"]) {
						help.related = fa_split(row["related"], ",")
					}
					help.fromSource = HELP_FROMDB

					if (help.isComplete()) {
						addToList(help)
						removeFromList(help.name, incompleteHelp)
					} else {
						addToList(help, incompleteHelp)
					}
				}
			}
		}

		setupHelpReferences() {
			for (var/cat in helpList) {
				//Browse each category
				var/categoryList = helpList[cat]
				for (var/helpName in categoryList) {
					categoryList[helpName]:setReferences()
				}
			}
		}

		removeFromList(name, list/targetList) {
			for(var/c in targetList) {
				if (name in targetList[c]) {
					targetList[c] -= name
					return
				}
			}
		}

		addToList(HELPSYSTEM/HELPFILE/help, list/targetList=helpList) {
			if (!targetList[help.category]) {
				targetList[help.category] = list()
			}

			var/list/categoryList = targetList[help.category]
			categoryList[help.name] = help
		}

		getHelpList(list/targetList=helpList, var/suggested=FALSE) {
			var/list/buffer = list()

			buffer += "\n"
			if (!suggested) {
				buffer += "Available Help\n"
			} else {
				buffer += "We have found several help entries matching the word you are looking for...\n"
			}

			buffer += "\n"

			var/first = TRUE
			var/helpCount = 0
			for(var/section in targetList) {
				if (targetList[section].len == 0) {
					continue
				}

				if (!first) {
					buffer += "\n\n"
				}

				buffer += "{R[section]:{x\n"
				buffer += format_list(targetList[section], 4, 20)
				first = FALSE
				helpCount += targetList[section].len
			}

			buffer += "\n\nDisplaying [helpCount] help files.\n"

			return implodetext(buffer, "")
		}

		getHelp(name, includeIncomplete=FALSE) {
			var/list/matches = list()

			for (var/cat in helpList) {
				var/list/categoryList = helpList[cat]
				if ((name in categoryList)) {
					return categoryList[name]
				}

				for (var/h in categoryList) {
					if(__textMatch(h, name)) {
						matches[h] = categoryList[h]
					}
				}
			}

			if (includeIncomplete) {
				for (var/cat in incompleteHelp) {
					var/list/categoryList = incompleteHelp[cat]
					if ((name in categoryList)) {
						return categoryList[name]
					}

					for (var/h in categoryList) {
						if(__textMatch(h, name)){
							send("Acquiring help from incomplete list. This is visibile to imms only!", usr)
							matches[h] = categoryList[h]
						}
					}
				}
			}

			if (matches.len > 1) {
				return getHelpList(list("Suggestions" = matches), TRUE)
			}

			if (matches.len == 1) {
				for(var/helpName in matches) {
					return matches[helpName]
				}
			}

			return NULL
		}

		getHelpByCategory(category) {
			var/list/results = list()
			var/list/targetList = helpList[category]
			for (var/name in targetList) {
				if (targetList[name].category == category) {
					results += targetList[name]
				}
			}

			return results
		}

	HELPFILE
		var
			name = NULL
			internalName = NULL
			list/relatedNames = list()
			description = NULL
			usage = "N/A"
			category = "General"
			list/related = list()
			immCommand = FALSE
			fromSource = NULL
			oldName = NULL
			list/teachers = list()

		proc
			setupTeachers() {
				//Create the teachers list
				var/nameInList = (name in game.teachList) ? name : internalName
				teachers = game.teachList[nameInList]

				//Look for other known names. This is a fix for skills that share the same display name
				if (relatedNames && relatedNames.len > 0) {
					for(var/o in relatedNames) {
						var/list/relTeachers = game.teachList[o]
						if (relTeachers && relTeachers.len > 0) {
							teachers += relTeachers
						}
					}
				}
			}
			update(currentName, field, value)
			{
				removeFromList(currentName, helpSystem.helpList)
				removeFromList(currentName, helpSystem.incompleteHelp)

				switch(field) {
					if ("name") name = lowertext(value)
					if ("description") description = value
					if ("usage") usage = value
					if ("category") category = value
					if ("related") related = value ? fa_split(lowertext(value), ",") : list()
				}

				//Cleanup the related field
				if (related.len > 0) {
					for(var/i in 1 to related.len) {
						related[i] = ktext.trimWhitespace(related[i])
					}
				}

				if (fromSource == HELP_FROMDB) {
					oldName = lowertext(currentName)
					save()
					return
				}

				updateHelpSystem()
			}

			save(insert=FALSE) {
				if (!oldName) {
					oldName = name
				}

				var/q
				if (insert) {
					q = "INSERT INTO `help` (name, description, usage, category, related) VALUES ('[sanit(lowertext(name))]', '[sanitHelp(description)]', '[usage]', '[category]', '[__listToText(related, ",")]');"
				} else {
					q = "UPDATE `help` SET `name`='[lowertext(name)]', `description`='[sanitHelp(description)]', `usage`='[usage]', `category`='[category]', `related`='[__listToText(related, ",")]' WHERE `name` = '[sanit(oldName)]';"
				}
				_query(q)
				updateHelpSystem()
			}

			updateHelpSystem() {
				removeFromList(name, helpSystem.helpList)
				removeFromList(name, helpSystem.incompleteHelp)
				if(isComplete()) {
					helpSystem.addToList(src)
				} else {
					helpSystem.addToList(src, helpSystem.incompleteHelp)
				}
			}

			delete()
			{
				removeFromList(name, helpSystem.helpList)
				removeFromList(name, helpSystem.incompleteHelp)
				_query("DELETE FROM `help` WHERE `name` = '[sanit(lowertext(name))]';")
			}

			show(mob/user, var/rawtext = FALSE) {
				var/list/buffer = list()
				buffer += "\n{cCategory:{x [category]\n"
				buffer +="{cHelp File:{x [uppertext(copytext(name,1,2)) + copytext(name, 2)]"

				if (teachers && teachers.len > 0) {
					buffer +="\n{cLearnt From:{x [__listToText(teachers, ", ")]"
				}
				buffer += format_text("\n{cDescription:{x [checkForNewLine(description)]")

				if (usage && usage != "N/A") {
					buffer += "\n\n{cUsage:{x [usage]"
				}

				if (related.len > 0) {
					var/relatedString = "{W[__listToText(related, "{c, {W")]{x"
					buffer += "\n\n{cSee also:{x [relatedString]"
				}

				buffer += "\n"

				if(!rawtext) {
					send(implodetext(buffer, ""), user, TRUE)
				} else {
					usr << "[checkForNewLine(description)]";
				}
			}

			setReferences() {
				for (var/ref in related) {
					var/refHelp = helpSystem.getHelp(lowertext(ref))

					if (refHelp) {
						refHelp:addRelated(src)
					} else {
						related -= ref
					}
				}
			}

			isComplete() {
				return name && description && category
			}

			addRelated(var/relatedHelp) {
				if (!(relatedHelp:name in related)) {
					related += relatedHelp:name

					if (fromSource == HELP_FROMDB) {
						save()
					}
				}
			}

			removeRelated(var/relatedName) {
				if ((relatedName in related)) {
					related -= relatedName

					if (fromSource == HELP_FROMDB) {
						save()
					}
				}
			}
