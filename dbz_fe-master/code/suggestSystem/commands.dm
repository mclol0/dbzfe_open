proc
	displayPriority(priority){
		switch(text2num(priority)){
			if(PRIORITY_HIGH){
				return "{RHIGH PRIORITY{x";
			}

			if(PRIORITY_LOW){
				return "{DLOW PRIORITY{x";
			}

			if(NO_PRIORITY){
				return "No priority.";
			}
		}

		return "No priority.";
	}

	displayAccepted(status){
		switch(text2num(status)){
			if(STATUS_ACCEPTED){
				return "{GACCEPTED{x";
			}

			if(STATUS_DENIED){
				return "{RDENIED{x";
			}
		}

		return "No reply.";
	}

Command/Public
	suggestions
		name = "suggestions";
		format = "suggestions; ?num";
		syntax = list("page number")
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpCategory = "General"
		helpDescription = "Display the list of suggestions that have been entered by players in the mud and their answer from immortals."

		command(mob/user, page) {
			if(page){
				var
					rowCount = _RowCount("SELECT * FROM `suggestions` ORDER BY `priority` ASC LIMIT [page*5-5], 5;")
					database/query/suggestions = _query("SELECT * FROM `suggestions` ORDER BY `priority` ASC LIMIT [page*5-5], 5;")

				if(rowCount > 0){
					send("{RThere are {x{R[commafy(rowCount)]{x {Rsuggestion(s).",user,TRUE)
					send("{D-----{x",user,TRUE)
					while(suggestions.NextRow()){
						var/list/row = suggestions.GetRowData()
						send("\nID: [row["ID"]]\nPriority: [displayPriority(row["priority"])]\nStatus: [displayAccepted(row["accepted"])]\nSuggested by: [row["player"]]\nStaff Replied: [row["staff"]]\nSuggestion: [read_sanit(row["suggestion"])]\n",user,TRUE)
					}
					send("{D-----{x",user,TRUE)
					send("{RShowing page [page].{x",user,TRUE)
				}else{
					send("{D-----{x",user,TRUE)
					send("{RThere are no suggestions to display.{x",user,TRUE)
					send("{D-----{x",user,TRUE)
				}
			}else{
				var
					rowCount = _rowCount("FROM `suggestions`;")
					database/query/suggestions = _query("SELECT * FROM `suggestions` ORDER BY `priority` ASC LIMIT 5;")

				if(rowCount > 0){
					send("{RThere are {x{R[commafy(rowCount)]{x {Rsuggestion(s).",user,TRUE)
					send("{D-----{x",user,TRUE)
					while(suggestions.NextRow()){
						var/list/row = suggestions.GetRowData()
						send("\nID: [row["ID"]]\nPriority: [displayPriority(row["priority"])]\nStatus: [displayAccepted(row["accepted"])]\nSuggested by: [row["player"]]\nStaff Replied: [row["staff"]]\nSuggestion: [read_sanit(row["suggestion"])]\n",user,TRUE)
					}
					send("{D-----{x",user,TRUE)
					send("{RThere are {x{R[commafy(cround(rowCount/5))]{x {Rpage(s) of changes. Use {x{D'{x{Rsuggestions \<page\>{x{D'{x {Rto view older changes.{x",user,TRUE)
				}else{
					send("{D-----{x",user,TRUE)
					send("{RThere are no suggestions to display.{x",user,TRUE)
					send("{D-----{x",user,TRUE)
				}
			}
		}

Command/Public
	suggest
		name = "suggest";
		format = "suggest; any";
		syntax = list("message")
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpCategory = "General"
		helpDescription = "Send a suggestion for Immortals to review and improve the mud."

		command(mob/user, suggestion) {
			if(length(suggestion) > 0){
				addSuggestion(user.raceColor(user.name),suggestion);
				send("Suggestion sent. (If this is abused you will be banned)",user,TRUE);
			}else{
				send("A blank suggestion? That's helpful.",user,TRUE);
			}
		}