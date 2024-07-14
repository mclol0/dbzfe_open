Command/Public
	history
		name = "history";
		format = "~history; ?word; ?num";
		syntax = list("page")
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "Display past chat history on the OOC channel."
		cancelsPushups = FALSE;

		command(mob/user, channel="ooc", page) {
			if(TextMatch("ooc", channel, 1, 1)){
				if(page){
					var
						rowCount = _RowCount("SELECT * FROM `ooclog` ORDER BY `MID` DESC LIMIT [page*20-20], 20;")
						database/query/changes = _query("SELECT * FROM `ooclog` ORDER BY `MID` DESC LIMIT [page*20-20], 20;")

					if(rowCount > 0){
						send("{cThere are {x{C[commafy(rowCount)]{x {cmessage(s){x.",user,TRUE)
						send("{m-----{x",user,TRUE)
						while(changes.NextRow()){
							var/list/row = changes.GetRowData()
							if(user.isImm){
								send("{y\[{x{Y[row["MID"]]{x{y\]{x {y\[{x{Y[row["date"]]{x{y\]{x {y\[{x{YOOC{x{y\]{x [row["sender"]]{y, '{x{Y[read_sanit(row["message"])]{x{y'{x",user,TRUE)
							}else{
								send("{y\[{x{Y[row["date"]]{x{y\]{x {y\[{x{YOOC{x{y\]{x [row["sender"]]{y, '{x{Y[read_sanit(row["message"])]{x{y'{x",user,TRUE)
							}
						}
						send("{m-----{x",user,TRUE)
					}else{
						send("{m-----{x",user,TRUE)
						send("{cThere are no messages to display.{x",user,TRUE)
						send("{m-----{x",user,TRUE)
					}
				}else{
					var
						rowCount = _rowCount("FROM `ooclog`;")
						database/query/changes = _query("SELECT * FROM `ooclog` ORDER BY `MID` DESC LIMIT 20;")

					if(rowCount > 0){
						send("{cThere are {x{C[commafy(rowCount)]{x {cmessages(s){x. {cDisplaying the most recent messages as page {C1{x{c.{x",user,TRUE)
						send("{m-----{x",user,TRUE)
						while(changes.NextRow()){
							var/list/row = changes.GetRowData()
							if(user.isImm){
								send("{y\[{x{Y[row["MID"]]{x{y\]{x {y\[{x{Y[row["date"]]{x{y\]{x {y\[{x{YOOC{x{y\]{x [row["sender"]]{y, '{x{Y[read_sanit(row["message"])]{x{y'{x",user,TRUE)
							}else{
								send("{y\[{x{Y[row["date"]]{x{y\]{x {y\[{x{YOOC{x{y\]{x [row["sender"]]{y, '{x{Y[read_sanit(row["message"])]{x{y'{x",user,TRUE)
							}
						}
						send("{m-----{x",user,TRUE)
						send("{cThere are {x{C[commafy(cround(rowCount/20))]{x {cpage(s) of messages. Use {x{C'{x{cmessage \<channel\> \<page\>{x{C'{x {cto view older messages.{x",user,TRUE)
					}else{
						send("{m-----{x",user,TRUE)
						send("{cThere are no messages to display.{x",user,TRUE)
						send("{m-----{x",user,TRUE)
					}
				}
			}else{
				send("Invalid channel history requested.",user,TRUE)
			}
		}