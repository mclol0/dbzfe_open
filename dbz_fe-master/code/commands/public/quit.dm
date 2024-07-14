Command/Public
	quit_full
		name = "quit"
		format = "quit";
		canUseWhileRESTING = TRUE;
		helpDescription = "Exit the game."

		command(mob/Player/user) {
			if(user.fCombat._hostiles()){
				send("You can't quit right now!", user)
				return;
			}

			if(user.traveling){
				send("You are currently traveling to planet [lowertext(user.traveling)] you can't leave yet!",user)
				return
			}

			send("Thanks for playing [game.name]!",user)
			sleep(1)
			user.disconnect();
		}

	quit
		visible = FALSE;
		format = "~quit";
		canUseWhileRESTING = TRUE;

		command(mob/Player/user, word) {
			send("I'm sorry, you must type 'quit' in whole.",user)
		}