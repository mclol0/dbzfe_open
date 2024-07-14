Command/Public
	commands
		name = "commands";
		format = "~commands";
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "Display the available commands list excluding skills."

		command(mob/user) {
			var
				list/commands[] = list()

			for(var/X in 1 to alaparser.commands.len){
				var/Command/C = alaparser.commands[alaparser.commands[X]];

				if(istype(C,/Command/Public) && C.visible) { commands.Add("{c[C.name]{x"); }
			}

			send("Commands:",user)
			send(format_list(commands,3,16),user)
		}