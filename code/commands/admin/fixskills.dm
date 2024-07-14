Command/Wiz
	fixskills
		name = "fixskills";
		immCommand = 1
		immReq = 5
		format = "~fixskills";
		syntax = "{cfixskills{x";

		command(mob/user) {
			var/database/query/q = _query("SELECT * FROM `characters`;");

			var/list/rowData

			while(q.NextRow()) {
				rowData = q.GetRowData();

				var/list/Techniques = params2list(rowData["techniques"]);
				var/list/NewTechniques = list();
				var/Player = rowData["name"];

				for(var/x in Techniques){
					NewTechniques += list(game.getSkillName(text2path(x)));
				}

				for(var/x in Techniques){
					_query("UPDATE `characters` SET `techniques`='[list2params(NewTechniques)]' WHERE `name`='[Player]';")
				}
			}
		}