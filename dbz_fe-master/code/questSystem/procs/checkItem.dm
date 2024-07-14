fQuest_Factory
	checkItem(var/mob/m as mob){
		for(var/X in m.questData){
			var/fQuest/quest = qFac.get(X);
			var/list/Q = quest.completedVariables

			if(Q && Q.Find("hasItem")){
				qFac.canComplete(X, m.questData[X], m)
				return TRUE;
			}
		}

		return FALSE;
	}