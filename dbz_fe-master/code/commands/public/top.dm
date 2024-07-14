Command/Public
	top
		name = "top"
		format = "top";
		canAlwaysUSE = TRUE;
		canUseWhileRESTING = TRUE;
		helpDescription = "Display the list of top players ranked by their base PL."
		cancelsPushups = FALSE;

		command(mob/user) {
			if(user){
				var
					database/query/q = _query("SELECT `name`, `powerlevel` FROM `power_ranking` ORDER BY `powerlevel` DESC LIMIT 25;")
					list/players = list()

				while(q.NextRow()){
					var
						list/row = q.GetRowData()

					players += list("[format_text("<al17>[row["name"]]</a> {W<ar[length(short_num(row["powerlevel"]))+18]>[short_num(text2num(row["powerlevel"]))]</a>{x")]" = text2num(row["powerlevel"]))
				}

				ranking_menu("Top {Y25{x players on [game.name]",players,"fancy",70,user)
			}
		}