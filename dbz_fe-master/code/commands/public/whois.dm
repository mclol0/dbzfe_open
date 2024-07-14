Command/Public
	whois
		name = "whois"
		format = "~whois; any";
		syntax = list("player")
		canAlwaysUSE = TRUE
		helpDescription = "Display statistics of a player in the DB."
		cancelsPushups = FALSE;

		command(mob/user, text) {
			var/rowCount = _rowCount("FROM `characters` WHERE `name`='[sanit(text)]' COLLATE NOCASE;")

			if(rowCount > 0){
				var
					database/query/q = _query("SELECT * FROM `characters` WHERE `name`='[sanit(text)]' COLLATE NOCASE;")
					list/rowData = NULL;
					list/playData = NULL;
					foundChar = NULL;

				while(q.NextRow() && !foundChar){
					rowData = q.GetRowData();

					if(__textMatch(lowertext(rowData["name"]), lowertext(text), FALSE, TRUE)){
						foundChar = rowData["name"];
						break;
					}
				}

				if(foundChar){
					playData = params2list(rowData["stats"]);

					send("WHOIS [rankColor(text2num(playData["race"]),rowData["name"])]",user,TRUE)
					if(length(playData["last_seen"]) > 0){ send("Last seen: [playData["last_seen"]]",user,TRUE)  } else { send("Last seen: Unknown",user,TRUE) }
					send("PvP K/D: {R[text2num(playData["pvpk"])]{x/{r[text2num(playData["pvpd"])]{x ([ratio(text2num(playData["pvpk"]),text2num(playData["pvpd"]))]%)",user,TRUE)
					send("Arena W/L: {G[text2num(playData["arenaw"])]{x/{g[text2num(playData["arenal"])]{x ([ratio(text2num(playData["arenaw"]),text2num(playData["arenal"]))]%)",user,TRUE)
					send("Gender: [determineGender(text2num(playData["sex"]))]",user,TRUE)
					send("Alignment: [determineAlignment(text2num(playData["alignment"]))]",user,TRUE)
					send("Race: [rankColor(text2num(playData["race"]),getRaceName(text2num(playData["race"])))]",user,TRUE)
					send("Powerlevel: [rankColor(text2num(playData["race"]),commafy(text2num(playData["maxpl"])))]",user,TRUE)
				}else{
					send(syntax,user);
				}
			}else{
				var
					database/query/q = _query("SELECT * FROM `characters`;")
					list/rowData = NULL;
					list/playData = NULL;
					foundChar = NULL;

				while(q.NextRow() && !foundChar){
					rowData = q.GetRowData();

					if(__textMatch(lowertext(rowData["name"]), lowertext(text), TRUE, TRUE)){
						foundChar = rowData["name"];
						break;
					}
				}

				if(foundChar){
					playData = params2list(rowData["stats"]);

					send("WHOIS [rankColor(text2num(playData["race"]),rowData["name"])]",user,TRUE)
					if(length(playData["last_seen"]) > 0){ send("Last seen: [playData["last_seen"]]",user,TRUE)  } else { send("Last seen: Unknown",user,TRUE) }
					send("PvP K/D: {R[text2num(playData["pvpk"])]{x/{r[text2num(playData["pvpd"])]{x ([ratio(text2num(playData["pvpk"]),text2num(playData["pvpd"]))]%)",user,TRUE)
					send("Arena W/L: {G[text2num(playData["arenaw"])]{x/{g[text2num(playData["arenal"])]{x ([ratio(text2num(playData["arenaw"]),text2num(playData["arenal"]))]%)",user,TRUE)
					send("Gender: [determineGender(text2num(playData["sex"]))]",user,TRUE)
					send("Alignment: [determineAlignment(text2num(playData["alignment"]))]",user,TRUE)
					send("Race: [rankColor(text2num(playData["race"]),getRaceName(text2num(playData["race"])))]",user,TRUE)
					send("Powerlevel: [rankColor(text2num(playData["race"]),commafy(text2num(playData["maxpl"])))]",user,TRUE)
				}else{
					send(syntax,user);
				}
			}
		}