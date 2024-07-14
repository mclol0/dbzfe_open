fQuest_Factory
	grabNPCName(var/request as text){
		request = text2path(copytext(request,11,length(request)))

		return game.npcNames[request];
	}