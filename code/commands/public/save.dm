Command/Public
	save
		name = "save"
		format = "save";
		internal_name = "save";
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		helpDescription = "This command will save your character."
		cancelsPushups = FALSE;

		command(mob/Player/user) {
			if(..(user)){
				return;
			}

			if(user.saveSQLCharacter() && user.canSave){
				send("{GSaved.{x",user,TRUE)
			}else{
				send("{RFailed to save.{x",user,TRUE)
				game.logger.error("[user.name] failed to save their character manually.");
			}

			game.addCooldown(user.name,internal_name,10 SECONDS);
		}