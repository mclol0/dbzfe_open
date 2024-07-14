Command/Technique
	summon
		name = "summon"
		internal_name = "summon"
		format = "~summon";
		priority = 1
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Summon your space pod to your location."

		command(mob/Player/user) {
			if(user){
				if(user.insideBuilding){
					send("You cannot summon your spacepod inside a building!",user,TRUE);
					return;
				}

				if(user.fCombat._hostiles()){
					send("You can't summon your spacepod mid-fight!",user,TRUE);
					return;
				}

				if(user.spacePod && user.spacePod:loc==user.loc){
					send("Your spacepod is in the same room as you!",user)
					return;
				}

				if(user.spacePod){
					user.spacePod:summon(user.x,user.y,user.z)
					user.spacePod:insideBuilding = user.insideBuilding
				}else{
					new /obj/spacepod(user)
				}
			}
			else{
				syntax(user,getSyntax());
			}
		}