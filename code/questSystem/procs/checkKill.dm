fQuest_Factory
	checkKill(var/mob/NPA/m as mob, var/mob/Player/p as mob){
		for(var/X in p.questData){
			var/list/quest = p.questData[X];

			if(quest && !isCompleted(p,X) && quest.Find("hasKilled([m.type])")){
				quest["hasKilled([m.type])"]++;
				qFac.updateQuest(p,X,p.questData[X],FALSE);
				qFac.canComplete(X, p.questData[X], p)
				return TRUE;
			}
		}

		return FALSE;
	}