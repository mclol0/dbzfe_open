/client/proc/
	client_prompt(){
		return mob:parsePrompt(color_prompt(checkForNewLine("\n[mob:prompt]")));
	}