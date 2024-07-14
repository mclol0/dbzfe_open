fQuest_Factory
	printObjectives(var/mob/m as mob, var/quest as text, var/list/questVars){
		var
			outputBuffer = NULL;
			fQuest/qq = qFac.get(quest);

		for(var/x in qq.completedVariables){
			if(findtextEx(x,"hasKilled")){
				if(qq.completedVariables[x] == 1){
					if(questVars[x] >= qq.completedVariables[x]){
						outputBuffer += "\n * Defeat [grabNPCName(x)]. ({gcomplete{x)";
					}else{
						outputBuffer += "\n * Defeat [grabNPCName(x)]. ({rincomplete{x)";
					}
				}else{
					if(questVars[x] >= qq.completedVariables[x]){
						outputBuffer += "\n * Defeat [qq.completedVariables[x]] [grabNPCName(x)]. ({gcomplete{x)";
					}else{
						outputBuffer += "\n * Defeat [questVars[x]]/[qq.completedVariables[x]] [grabNPCName(x)]. ({rincomplete{x)";
					}
				}
			}
			else if(findtextEx(x,"hasPower")){
				if(m.maxpl >= qq.completedVariables[x]){
					outputBuffer += "\n * Obtain a powerlevel of [commafy(qq.completedVariables[x])] or more. ({gcomplete{x)";
				}else{
					outputBuffer += "\n * Obtain a powerlevel of [commafy(qq.completedVariables[x])] or more. ({rincomplete{x)";
				}
			}
			else if(findtextEx(x,"hasItem")){
				if(hasItem(m,qq.completedVariables[x])){
					outputBuffer += "\n * Obtain [grabItemName(qq.completedVariables[x])]. ({gcomplete{x)";
				}else{
					outputBuffer += "\n * Obtain [grabItemName(qq.completedVariables[x])]. ({rincomplete{x)";
				}
			}
			else if(findtextEx(x,"hasSkill") ){
				if((locate(qq.completedVariables[x]) in m.techniques)){
					outputBuffer += "\n * Learn [grabSkillName(qq.completedVariables[x])]. ({gcomplete{x)";
				}else{
					outputBuffer += "\n * Learn [grabSkillName(qq.completedVariables[x])]. ({rincomplete{x)";
				}
			}
			else if(!findtextEx(x,"hasSkill") && !findtextEx(x,"hasPower") && !findtextEx(x,"hasItem") && !findtextEx(x,"hasKilled")){
				if(qq.completedVariables[x] == questVars[x]){
					outputBuffer += "\n * [x]. ({gcomplete{x)";
				}else{
					outputBuffer += "\n * [x]. ({rincomplete{x)";
				}
			}
		}

		return outputBuffer;
	}