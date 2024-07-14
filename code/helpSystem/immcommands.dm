Command/Wiz
	test
		name = "test"
		immCommand = 1;
		immReq = 1
		format = "~test;";

		command(mob/user, helpName, relatedName) {
			send(houseSystem.upgradesToString(), user)
		}

	addrelatedhelp
		name = "addrelatedhelp"
		immCommand = 1;
		immReq = 1
		format = "~addrelatedhelp; !word; !word";
		syntax = list("help name", "related help name")

		command(mob/user, helpName, relatedName) {
			if (helpName && relatedName) {
				var/helpObj = helpSystem.getHelp(helpName)
				var/relatedHelp = helpSystem.getHelp(relatedName)

				if (!helpObj) {
					send("No help exists with name [helpName]", user)
					return
				}

				if (!relatedHelp) {
					send("no help exists with name [relatedName]", user)
					return
				}

				if (helpObj && relatedHelp) {
					if (helpObj:fromSource == HELP_FROMCMD) {
						send("You are updating a help file defined inside a command. This update will not be persistent unless you create a new help or modify the command definition.", user)
					}

					helpObj:addRelated(relatedHelp)
					relatedHelp:addRelated(helpObj)
					send("Added [relatedHelp:name] to [helpObj:name] related help list.", user)
					return
				}
			}

			syntax(user, getSyntax())
		}

	removerelatedhelp
		name = "removerelatedhelp"
		immCommand = 1;
		immReq = 1
		format = "~removerelatedhelp; !word; !word";
		syntax = list("help name", "related help name")

		command(mob/user, helpName, relatedName) {
			if (helpName && relatedName) {
				var/helpObj = helpSystem.getHelp(helpName)

				if (!helpObj) {
					send("No help exists with name [helpName]", user)
					return
				}

				if (!(relatedName in helpObj:related)) {
					send("[relatedName] is not part of [helpObj:name] related help list.", user)
					return
				}

				if (helpObj && relatedName) {
					if (helpObj:fromSource == HELP_FROMCMD) {
						send("You are updating a help file defined inside a command. This update will not be persistent unless you create a new help or modify the command definition.", user)
					}

					helpObj:removeRelated(relatedName)
					send("Removed [relatedName] from [helpObj:name] related help list.", user)
					return
				}
			}

			syntax(user, getSyntax())
		}

	getteachers
		name = "getteachers";
		immCommand = 1;
		immReq = 1
		format = "~getteachers";
		syntax = "getteachers"

		command(mob/user) {
			var/list/buffer = list()
			for (var/s in game.teachList) {
				buffer += "[s]:\n"
				var/list/teachers = game.teachList[s]
				if (teachers.len > 0) {
					for (var/t in teachers) {
						buffer += "<al2></a>[t]\n"
					}
				} else {
					buffer += "<al2></a>None\n"
				}
			}
			send(format_text(implodetext(buffer, "")), user)
		}

	incompletehelp
		name = "incompletehelp";
		immCommand = 1;
		immReq = 1
		format = "~incompletehelp";
		syntax = "incompletehelp"

		command(mob/user) {
			send("Incomplete help information found.", user)
			var/helpListStr = helpSystem.getHelpList(user, helpSystem.incompleteHelp)
			send(helpListStr, user)
		}

	reloadhelpsystem
		name = "reloadhelpsystem";
		immCommand = 1;
		immReq = 1
		format = "~reloadhelpsystem";
		syntax = "{reloadhelpsystem"

		command(mob/user) {
			send("Reloading help system information", user)
			helpSystem.loadSystem()
		}

	createhelp
		name = "createhelp";
		immCommand = 1
		immReq = 4
		format = "~createhelp; word; any;";
		syntax = "{ccreatehelp{x {c<{x{CName{x{c>{x {c<{x{CDescription{x{c>{x"

		command(mob/user, name, desc) {
			if (name && desc){
				var/HELPSYSTEM/HELPFILE/H = helpSystem.getHelp(name, TRUE)
				if (H) {
					if (H.fromSource == HELP_FROMDB) {
						send("A help entry called [name] already exists!", user)
						return
					}

					send("A help entry called [name] already exists because of a command definition. This will create a new record in the DB and display this instead.", user)
				}

				H = new()
				H.name = name
				H.description = desc
				H.fromSource = HELP_FROMDB
				H.save(TRUE)
				send("Created new help command: {c[name]{x", user)
				return
			}

			if (!name)
				send("Please provide the name of the help file to create.", user)

			if (!desc)
				send("Please provide the description for the help file.", user)

			syntax(user, syntax)
		}

	deletehelp
		name = "deletehelp";
		immCommand = 1
		immReq = 4
		format = "~deletehelp; any;";
		syntax = "{cdeletehelp{x {c<{x{CName{x{c>{x"

		command(mob/user, name) {
			if (name) {
				var/HELPSYSTEM/HELPFILE/H = helpSystem.getHelp(name, TRUE)
				if (!H) {
					send("A help entry called [name] does not exist.", user)
					return
				}

				if (H.fromSource == HELP_FROMCMD) {
					send("The help you are trying to delete is defined in a command. Remove the definition there instead.", user)
					return
				}

				H.delete()
				send("Deleted help command: {c[H.name]{x", user)
				return
			}

			if (!name)
				send("Please provide the name of the help file to delete.", user)

			syntax(user, syntax)
		}

	updatehelp
		name = "updatehelp";
		immCommand = 1
		immReq = 4
		format = "~updatehelp; word; word; any;";
		syntax = "{cupdatehelp{x {c<{xHelpfile{x{c>{x {c<\[{x{Cname | description | usage | category | related{x{c]>{x {c<{x{CNew Value{x{c>{x"

		command(mob/user, name, field, value) {
			var/list/validFields = list("name", "description", "usage", "category", "related")

			if (name && field) {
				if (!value && field == "name") {
					send("Name cannot be set to NULL", user)
				}

				var/check = TRUE
				var/HELPSYSTEM/HELPFILE/H = helpSystem.getHelp(name, TRUE)
				if (!H) {
					send("A help entry called [name] does not exist.", user)
					check = FALSE
				}

				if (field && validFields.Find(field) == 0)
				{
					send("Invalid Field. Please use one of the following: [__listToText(validFields, ", ")]", user)
					check = FALSE
				}

				if (check) {
					if (H.fromSource == HELP_FROMCMD) {
						send("You are updating a help file defined inside a command. This update will not be persistent unless you create a new help or modify the command definition.", user)
					}

					H.update(name, field, value)
					send("Updated help command: {c[name]{x", user)
				}

				return
			}

			if (!name)
				send("Missing Helpfile Name", user)

			if (!field)
				send("Missing Field", user)

			if (!value)
				send("Missing Value", user)

			syntax(user, syntax)

		}