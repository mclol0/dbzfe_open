Command/Public
	prompt
		name = "prompt"
		format = "prompt; any";
		syntax = list("text")
		canUseWhileRESTING = TRUE;
		helpDescription = "{CThis command allows you to customize your prompt variables are listed below.\n\nCurrent Energy: $curreng\nMax Energy: $maxeng\nEnergy Percentage: $p_energy\nCurrent Powerlevel: $currpl\nCurrent Powerlevel Abbr: $currpl_short\nMax Powerlevel: $maxpl\nMax Powerlevel Abbr: $maxpl_short\nPowerlevel Percentage: $p_powerlevel\nEnergy Meter: $en_bar\nPower Meter: $pl_bar\nCurrent Combat Target: $target\nCurrent Combat Target Abbr: $target_short\nDefault Combat Target: $def_target\nDefault Combat Target Abbr: $def_target_short\n\nDefault Prompt Example: <$p_energy> / <$currpl/$maxpl> $def_target{x"

		command(mob/Player/user, prompt) {
			if(length(prompt) > 0 && length(prompt) <= 95){
				user.prompt = rStrip_Escapes(prompt);
				send("Prompt set to [user.client.client_prompt()]",user)
			}else{
				send("Your prompt can only be between 1~95 characters long!",user);
			}
		}