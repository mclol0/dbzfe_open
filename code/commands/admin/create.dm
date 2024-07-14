Command/Wiz
	create
		name = "create";
		immCommand = 1
		immReq = 3
		format = "~create; ?any";
		syntax = "{ccreate{x {c<{x{Citem{x{c>{x";

		command(mob/user, item) {
			if(user && item){
				var/tmp/obj/item/O = NULL;

				for(var/K in typesof(/obj/item)){

					if(K == /obj/item/corpse) continue

					var/obj/item/X = new K

					if(TextMatch(rStrip_Escapes("[X.DISPLAY]"), item, 1, 1)){
						send("[X.DISPLAY] created.",user)
						send("[user.raceColor(user.name)] materializes [X.PREFIX][X.DISPLAY] out of thin air.",a_oview_extra(0,user,user))
						O = X;
						user.addInv(X)
						break
					}else{
						del(X)
					}
				}

				if(!O){ send("Item \"[item]\" not found please be specific (ex: red scouter, heavenly halo).",user); }
			}
			else{
				syntax(user,syntax);
			}
		}