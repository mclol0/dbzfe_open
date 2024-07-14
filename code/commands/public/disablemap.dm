Command/Public
	disablemap
		name = "disablemap"
		format = "disablemap";
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "This command toggles MAP printing."
		cancelsPushups = FALSE;

		command(mob/user) {
			if(user.disableMap){
				user.disableMap = FALSE;
				send("Map enabled.",user)
			}else{
				user.disableMap = TRUE;
				send("Map disabled.",user)
			}
		}