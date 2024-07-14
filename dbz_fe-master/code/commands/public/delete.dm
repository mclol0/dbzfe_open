Command/Public
	delete
		name = "delete"
		format = "delete";
		canUseWhileRESTING = TRUE;
		helpDescription = "Completely delete your character from the game. This action is irreversible and you will be asked for confirmation before proceeding."

		command(mob/Player/user) {
			if(user.fCombat._hostiles()){
				send("You can't quit right now!", user)
				return;
			}

			if(input_confirm("Delete your character [user.name]?",user)){
				DeleteCharacter(user);
			}else{
				send("Okay.",user)
			}
		}