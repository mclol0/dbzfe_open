Command/Public
	afk
		name = "afk"
		format = "afk";
		internal_name = "afk";
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		helpDescription = "Set your character as AFK. This is flag is displayed before your name in the {Rwho{x {Clist.{x"
		cancelsPushups = FALSE;

		command(mob/Player/user) {
			if(..(user)){
				return;
			}

			if(user.isAFK){
				send("You're no longer AFK.",user,TRUE);
				user.isAFK = FALSE;
			}else{
				send("You're now AFK.",user,TRUE);
				user.isAFK = TRUE;
			}
		}