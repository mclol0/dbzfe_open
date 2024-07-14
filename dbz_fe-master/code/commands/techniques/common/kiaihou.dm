Command/Technique
	kiaihou
		name = "kiaihou"
		internal_name = "kiaihou"
		format = "~kiaihou";
		priority = 3
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Push your Ki outwards, pushing weaker characters out of the room in random directions"
		skillDatum = /atkDatum/utility/kiaihou

		command(mob/user) {

			if(user){
				if(..(user,NULL)){
					return;
				}

				new /atkDatum/utility/kiaihou(user, src)
			}
			else{
				syntax(user, getSyntax())
			}
		}