fQuest_Factory
	completeCheck(var/mob/m as mob){
		for(var/X in m.questData){
			qFac.canComplete(X, m.questData[X], m)
		}
	}