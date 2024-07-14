fQuest_Factory
	obtainQuest(var/mob/m as mob, var/quest as text){
		var/fQuest/Q = qFac.get(quest);

		if(Q.allowedAlign.Find(m.alignment) && (Q.allowedRaces.Find(ALL_RACES) || Q.allowedRaces.Find(m.race))) {

			var/rowCount = _rowCount("FROM `quest_data` WHERE `owner`='[m.name]' AND `quest`='[quest]' AND `completed`='0';")

			if(!rowCount){
				var/database/query/q = _query("SELECT * FROM `quest_data` WHERE `owner`='[m.name]' AND `quest`='[quest]';");
				var/list/rowData;
				q.NextRow();
				rowData = q.GetRowData();

				if(text2num(rowData["completed"]) == TRUE){
					return FALSE;
				}else{
					m.questData += list("[quest]" = Q.savedVariables)
					send("{YNew quest obtained!{x {R'{x{G[Q.name]{x{R'{x",m,TRUE);
					updateQuest(m,quest,m.questData[quest],FALSE);
				}

				return TRUE;
			}
		}

		return FALSE;
	}