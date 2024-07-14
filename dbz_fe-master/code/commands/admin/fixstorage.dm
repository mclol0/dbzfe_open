Command/Wiz
	fixstorage
		name = "fixstorage";
		immCommand = 1
		immReq = 5
		format = "fixstorage";
		syntax = "{cfixstorage{x";
		priority = 2

		command(mob/user) {
			var
				database/query/items = _query("SELECT * FROM `player_storage`;")

			while(items.NextRow())
				var/list/row = items.GetRowData()

				for(var/x=1;x<=text2num(row["QUANTITY"]),x++){
					_query("INSERT INTO `corpses` (name, item) VALUES ('[row["PLAYER"]]', '[row["ITEM"]]');")
				}
		}