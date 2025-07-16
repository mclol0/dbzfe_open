Command/Public
	characters
		name = "characters";
		immCommand = 1
		immReq = 1
		format = "~characters;";
		syntax = "{ccharacters{x";
		priority = 3

		command(mob/user) {
			var/database/query/results = _query("SELECT name, email, stats FROM characters where email = '[user.email]'")

			send("{YCHARACTERS linked to [user.email]:{x", user)
			while(results.NextRow()) {
				var/list/row = results.GetRowData()
				var/name = row["name"]

				send("  [name]", user)
			}
		}