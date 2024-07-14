fQuest_Factory
	isCompleted(var/mob/m as mob, var/quest as text){
		var/rowCount = _rowCount("FROM `quest_data` WHERE `owner`='[m.name]' AND `quest`='[quest]' AND `completed`='1';")

		if(rowCount){
			return TRUE;
		}

		return FALSE;
	}