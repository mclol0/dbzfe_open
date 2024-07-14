Command/Public
	socials
		name = "socials";
		format = "~socials";
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "Display the available socials list excluding skills & commands."

		command(mob/user) {
			var
				list/socials[] = list()

			for(var/X in 1 to alaparser.commands.len){
				var/Command/C = alaparser.commands[alaparser.commands[X]];

				if(istype(C,/Command/Public/Socials) && C.visible) { socials.Add("{c[C.name]{x"); }
			}

			send("Socials:",user)
			send(format_list(socials,4,16),user)
		}
