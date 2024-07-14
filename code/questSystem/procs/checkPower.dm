fQuest_Factory
	checkPower(var/mob/m as mob){
		for(var/X in m.questData){
			var/fQuest/quest = qFac.get(X);
			var/list/Q = quest.completedVariables

			if(Q && Q.Find("hasPower")){
				qFac.canComplete(X, m.questData[X], m)
				return TRUE;
			}
		}

		return FALSE;
	}