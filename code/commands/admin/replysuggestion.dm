Command/Wiz
	replysuggestion
		name = "replysuggestion";
		immCommand = 1
		immReq = 3
		format = "replysuggestion; num; word; ?word; ?any";
		syntax = "{creplysuggestion{x {C<{x{cID{x{C>{x {C<{x{cACCEPT|DENY{x{C>{x {C<{x{cHIGH|LOW{x{C>{x {C<{x{cREPLY{x{C>{x";

		command(mob/user, id, accepted, priority, text) {
			if(user && id && accepted && priority && text){
				var/database/query/suggestions = _query("SELECT * FROM `suggestions` WHERE `ID`='[id]';")

				suggestions.NextRow();

				var/rowData = suggestions.GetRowData();

				if(priority != "high" && priority != "low"){
					syntax(user,syntax);
					return FALSE;
				}else{
					switch(priority){
						if("high"){
							priority = PRIORITY_HIGH;
						}

						if("low"){
							priority = PRIORITY_LOW;
						}
					}
				}

				if(accepted != "deny" && accepted != "accept"){
					syntax(user,syntax);
					return FALSE;
				}else{
					switch(accepted){
						if("accept"){
							accepted = STATUS_ACCEPTED;
						}

						if("deny"){
							accepted = STATUS_DENIED;
						}
					}
				}

				if(accepted == STATUS_DENIED){
					send("Staff member [user.raceColor(user.name)] has {RDENIED{x suggestion ID: [id].",game.players,TRUE);
					replySuggestion(id,"{o[user.name]{x",0,"Denied Suggestion",STATUS_DENIED);
					return FALSE;
				}

				if(rowData["staff"] == "No reply."){
					send("Reply sent to suggestion ID [id].",user,TRUE);
					send("Staff member [user.raceColor(user.name)] has {GACCEPTED{x suggestion ID: [id].",game.players,TRUE);
					replySuggestion(id,"{o[user.name]{x",priority,text,accepted);
				}else{
					send("A staff member has already replied to suggestion ID [id].",user,TRUE);
				}
			}
			else{
				syntax(user,syntax);
			}
		}