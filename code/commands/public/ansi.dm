Command/Public
	ansi
		name = "ansi"
		format = "ansi";
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "This command toggles ANSI colors."
		cancelsPushups = FALSE;

		command(mob/user) {
			if(user.cColor){
				user.cColor = FALSE;
				send("ANSI color disabled.",user)
			}else{
				user.cColor = TRUE;
				send("{RA{x{GN{x{MS{x{WI{x color enabled.",user)
			}
		}