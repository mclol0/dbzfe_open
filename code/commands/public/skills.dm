Command/Public
	skills
		name = "skills"
		format = "~skills";
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		helpDescription = "Display the list of available techniques for you to use and learn."
		cancelsPushups = FALSE;

		command(mob/user) {
			var
				skill_list[] = list()

			for(var/x in user.skillSet()){
				var/Command/Technique/C = new x
				if(user.techniques.Find(C.type)){
					skill_list.Add("{c[C.name]{x")
				}
				else{
					skill_list.Add("{D[C.name]{x")
				}
			}

			send(format_text("{Y^c<al28></a>Techniques<ar28></a>{x"),user,TRUE)
			send(format_list(skill_list,4,16),user,TRUE)
		}