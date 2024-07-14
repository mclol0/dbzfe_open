Command/Wiz
	imm_commands
		name = "immcommands";
		immCommand = 1
		immReq = 1
		format = "~immcommands";
		syntax = "{immcommands{x"

		command(mob/user) {
			var
				list/immcommands[] = list()

			for(var/K in typesof(/Command/Wiz)){
				var/Command/Wiz/C = new K()
				if(C.immReq > 0){
					var/immLevel = game.immLevel(user.name);
					if(immLevel >= C.immReq){
						immcommands.Add("{c[C.name]{x")
					}
					else{
						immcommands.Add("{D[C.name]{x")
					}
				}
			}
			send(format_text("<al28></a>{YImmortal Commands{x<ar28></a>"),user)
			send(format_list(immcommands,3,16),user)
		}