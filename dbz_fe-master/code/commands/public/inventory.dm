Command/Public
	inventory
		name = "inventory"
		format = "~inventory";
		priority = 3;
		canUseWhileRESTING = TRUE;
		helpDescription = "Display the items that you are currently carrying."
		cancelsPushups = FALSE;

		command(mob/user) {
			send(user.listInv(),user)
		}