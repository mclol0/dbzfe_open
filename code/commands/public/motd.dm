Command/Public
	motd
		name = "motd"
		format = "motd";
		syntax = "{cmotd{x"
		canUseWhileRESTING = TRUE;
		helpDescription = "Read and display the MOTD."
		cancelsPushups = FALSE;

		command(mob/user) {
			send(readFile("motd"),user)
		}