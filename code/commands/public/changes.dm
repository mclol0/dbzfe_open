Command/Public
	changes
		name = "changes";
		format = "~changes; ?num";
		syntax = list("page number")
		canUseWhileRESTING = TRUE;
		canAlwaysUSE = TRUE;
		helpDescription = "This command will print the latest changes added to the MUD."
		cancelsPushups = FALSE;

		command(mob/user, page) {
			if(page){
				var
					rowCount = _RowCount("SELECT * FROM `changes` ORDER BY `CID` DESC LIMIT [page*20-20], 20;")
					database/query/changes = _query("SELECT * FROM `changes` ORDER BY `CID` DESC LIMIT [page*20-20], 20;")

				if(rowCount > 0){
					send("{cThere are {x{C[commafy(rowCount)]{x {cchange(s){x.",user,TRUE)
					send("{m-----{x",user,TRUE)
					while(changes.NextRow()){
						var/list/row = changes.GetRowData()
						if(user.isImm){
							send("{g\[{x{D[row["CID"]]{x{g]{x {g\[{x{D[row["date"]]{x{g]{x {c[read_sanit(row["change"])]{x",user,TRUE)
						}else{
							send("{g\[{x{D[row["date"]]{x{g]{x {c[read_sanit(row["change"])]{x",user,TRUE)
						}
					}
					send("{m-----{x",user,TRUE)
				}else{
					send("{m-----{x",user,TRUE)
					send("{cThere are no changes to display.{x",user,TRUE)
					send("{m-----{x",user,TRUE)
				}
			}else{
				var
					rowCount = _rowCount("FROM `changes`;")
					database/query/changes = _query("SELECT * FROM `changes` ORDER BY `CID` DESC LIMIT 20;")

				if(rowCount > 0){
					send("{cThere are {x{C[commafy(rowCount)]{x {cchange(s){x. {cDisplaying the most recent changes as page {C1{x{c.{x",user,TRUE)
					send("{m-----{x",user,TRUE)
					while(changes.NextRow()){
						var/list/row = changes.GetRowData()
						if(user.isImm){
							send("{g\[{x{D[row["CID"]]{x{g]{x {g\[{x{D[row["date"]]{x{g]{x {c[read_sanit(row["change"])]{x",user,TRUE)
						}else{
							send("{g\[{x{D[row["date"]]{x{g]{x {c[read_sanit(row["change"])]{x",user,TRUE)
						}
					}
					send("{m-----{x",user,TRUE)
					send("{cThere are {x{C[commafy(cround(rowCount/20))]{x {cpage(s) of changes. Use {x{C'{x{cchanges \<page\>{x{C'{x {cto view older changes.{x",user,TRUE)
				}else{
					send("{m-----{x",user,TRUE)
					send("{cThere are no changes to display.{x",user,TRUE)
					send("{m-----{x",user,TRUE)
				}
			}
		}