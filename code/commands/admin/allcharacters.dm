Command/Wiz
	allcharacters
		name = "allcharacters";
		immCommand = 1
		immReq = 1
		format = "~allcharacters; word";
		syntax = "{ccharacters{x {c<{x{Cpartial name{x{c>{x";
		priority = 2

		command(mob/user, var/partial) {
			var/database/query/results
			if(partial){
				results = _query("SELECT name, email, stats FROM characters WHERE name LIKE '%[sanit(partial)]%' OR email LIKE '%[sanit(partial)]%'")	
			}
			else{
				results = _query("SELECT name, email, stats FROM characters")
			}

			var/count = 0

			send("{YCHARACTERS CREATED{x", user, TRUE)
			while(results.NextRow()) {
				var/list/row = results.GetRowData()
				var/name = row["name"]
				var/email = row["email"]

				send("  [name] - [email]", user, TRUE)
				count += 1
			}				
			send("{Y---{x", user, TRUE)
			send("There are a total of {C[count]{x characters in the database", user, TRUE)
		}