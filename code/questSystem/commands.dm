Command/Public
	quest
		name = "quest"
		format = "~quest; ?any";
		canAlwaysUSE = TRUE;
		helpCategory = "General"
		helpDescription = "Display the list of active quests you currently have. Use this with the number of a quest to look at its details."

		command(mob/user, quest) {
			if(ktext.len(quest) > 0){
				var/FOUND = FALSE;

				for(var/qq in user.questData){
					var/fQuest/Q = qFac.get(qq);

					if(Q.internal_id == text2num(quest)){
						send("{Y[Q.name]{x",user,TRUE);
						send("{G[Q.desc]{x",user,TRUE);
						send("Objectives:",user,TRUE);
						if(qFac.isCompleted(user,Q.internal_name)){
							send("{GThis quest has been completed...{x",user,TRUE);
						}else{
							send(qFac.printObjectives(user,Q.internal_name,user.questData[Q.internal_name]),user,TRUE);
						}
						FOUND = TRUE;
						break;
					}
				}

				if(!FOUND){
					send("-Quest Log: Invalid quest #...",user,TRUE);
				}
			}else{
				send("-Quest Log:",user,TRUE);
				if(user.questData.len > 0){
					for(var/x in user.questData){
						var/fQuest/qq = qFac.get(x);

						if(qFac.isCompleted(user,qq.internal_name)){
							send(" {G*{x \[#[qq.internal_id]\] [qq.name] \[{GCOMPLETE{x\]",user,TRUE);
						}else{
							send(" {D*{x \[#[qq.internal_id]\] [qq.name] \[{RINCOMPLETE{x\]",user,TRUE);
						}
					}
				}else{
					send(" {R*{x No quest data found.",user,TRUE);
				}
			}
		}