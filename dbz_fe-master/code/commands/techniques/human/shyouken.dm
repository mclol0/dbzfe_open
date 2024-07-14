Command/Technique
	shyouken
		name = "shyouken"
		internal_name = "shyouken"
		format = "~shyouken";
		priority = 1
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "For a short period of time, increase your chances of send your opponent out of the room and extending a melee combo."
		skillDatum = /atkDatum/utility/shyouken

		command(mob/user) {

			if(user){
				if(..(user,NULL)){
					return;
				}

				if(!user.shyouken){
					send("{B*{x {WYou begin to glow white!{x",user);
					send("{W*{x [user.raceColor(user.name)] {Wbegins to glow white!{x",_ohearers(0,user))

					user.shyouken((world.time + 7 SECONDS));
				}else{
					send("{R*{x You're already using shyouken!",user);
				}
			}
			else{
				syntax(user, getSyntax())
			}
		}