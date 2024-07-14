fQuest_Factory
	updateQuest(var/mob/m as mob, var/quest as text, var/list/variables, var/completed=FALSE){
		var/rowCount = _rowCount("FROM `quest_data` WHERE `owner`='[m.name]' AND `quest`='[quest]';")

		if(rowCount){
			_query("UPDATE `quest_data` SET `data`='[list2params(variables)]'[completed ? ",`completed`='[completed]'" : ""] WHERE `owner`='[m.name]' AND `quest`='[quest]';")
		}else{
			_query("INSERT INTO `quest_data` (owner, quest, data, completed) VALUES (\"[m.name]\", \"[quest]\", \"[list2params(variables)]\", \"[completed]\");")
		}

		return TRUE;
	}