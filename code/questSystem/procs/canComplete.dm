fQuest_Factory
	canComplete(var/quest as text, variables, mob/m=NULL as mob){
		if(!quest){ world << "NO QUEST FOUND?" }

		if(isCompleted(m,quest)){ return FALSE; }

		var
			fQuest/Q = qFac.get(quest);
			neededVars = Q.completedVariables.len;
			completedVars = 0;

		for(var/x in Q.completedVariables){
			if(findtextEx(x,"hasKilled") && variables[x] >= Q.completedVariables[x]){
				completedVars++;
			}
			if(findtextEx(x,"hasPower") && m.maxpl >= Q.completedVariables[x]){
				completedVars++;
			}
			if(findtextEx(x,"hasItem") && hasItem(m,Q.completedVariables[x])){
				completedVars++;
			}
			if(findtextEx(x,"hasSkill") && (locate(Q.completedVariables[x]) in m.techniques)){
				completedVars++;
			}
			if(!findtextEx(x,"hasSkill") && !findtextEx(x,"hasPower") && !findtextEx(x,"hasItem") && !findtextEx(x,"hasKilled") && Q.completedVariables[x] == variables[x]){
				completedVars++;
			}
		}

		if(completedVars == neededVars){
			getRewards(quest,m);

			updateQuest(m,quest,m.questData[quest],TRUE);

			return TRUE;
		}

		return FALSE;
	}