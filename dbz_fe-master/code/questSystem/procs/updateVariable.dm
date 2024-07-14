fQuest_Factory
	updateVariable(var/mob/m as mob, var/quest as text, var/questVar as text, var/questVal){
		var/list/QQ = m.questData[quest];

		if(QQ){
			QQ[questVar] = questVal;
			qFac.canComplete(quest, m.questData[quest], m)
			return TRUE;
		}

		return FALSE;
	}