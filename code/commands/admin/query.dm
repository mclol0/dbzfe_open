Command/Wiz
	sql
		name = "sql";
		immCommand = 1
		immReq = 5
		format = "sql; any";
		syntax = "{csql{x {c<{x{Cstring{x{c>{x";

		command(mob/user, string) {
			if(length(string) > 5){
				var/database/query/q = _query(string);

				user << "query: [string]";

				while(q.NextRow()){
					var/list/row = q.GetRowData();
					var/buffer = NULL;

					for(var/x in row){
						buffer += "\n[x]: [row[x]]"
					}

					send(buffer,user,TRUE);
				}

				send("[q.RowsAffected()] rows affected.",user,TRUE);
			}
			else{
				syntax(user,syntax);
			}
		}