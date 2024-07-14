Command/Public
	pushups
		name = "pushups"
		format = "~pushups; num";
		syntax = list("amount")
		priority=1
		helpDescription = "Basic strength training in which you get down on the floor and start executing pushups until boredom or unconciousness."

		command(mob/user, amount=100) {
			if(user){
				if(amount > 0){
					if(amount > 100){
						send("You're only able to do pushups in sets of 100 max!",user,TRUE);
						return;
					}

					if(!user.doingPushups){
						alaparser.parse(user,"emo begins doing pushups.",list());
						user.pushups(amount);
					}else{
						send("You're already performing pushups!",user,TRUE);
					}
				}else{
					syntax(user,src);
				}
			}
		}