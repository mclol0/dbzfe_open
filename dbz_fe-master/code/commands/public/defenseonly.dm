Command/Public
	defenseonly
		name = "defenseonly"
		format = "defenseonly";
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "This command toggles DEFENSE printing."
		cancelsPushups = FALSE;

		command(mob/user) {
			if(user.defenseOnly){
				user.defenseOnly = FALSE;
				send("Defense only disabled.",user)
			}else{
				user.defenseOnly = TRUE;
				send("Defense only enabled.",user)
			}
		}