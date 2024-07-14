Command/Technique
	preprocess(mob/user,str){
		if(..(user,str)){
			. = TRUE;
			if(user.flying && name != "fly" && iCommand){user.flying=NULL;user.lFlyT=NULL;}
		}
	}

Command
	preprocess(mob/user, str) {
		if(user){
			if((user.getStatus() in list("unconscious","stunned","sleeping","teleporting")) && !canAlwaysUSE || (user.getStatus() in list("resting")) && user.resting && !canUseWhileRESTING && !canAlwaysUSE){
				send("You are [user.getStatus()]!",user,TRUE)
				if(user.client){ user.client.lastCMD = (world.time + 5); }
				return FALSE;
			}
		}
		else{
			game.logger.error("preprocess: no user found.");
			return FALSE;
		}

		return TRUE;
	}