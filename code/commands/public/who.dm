Command/Public
	who
		name = "who"
		format = "~who";
		priority = 1
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		helpDescription = "Display the list of currently connected players. The list contains 6 different columns, displaying the following information:\n\n<al2></a><al11>?:</a>Player character in map. If the player is holding any Dragon Balls, this will be around parenthesis.\n<al2></a><al11>Name:</a>The name of the player.\n<al2></a><al11>PvP W/L:</a>Win ratio in PvP battles.\n<al2></a><al11>Arena W/L:</a>Win ratio in Arena battles.\n<al2></a><al11>Race:</a>Player race.\n<al2></a><al11>Form:</a>Current form."
		cancelsPushups = FALSE;

		command(mob/user) {
			var
				buffer_players[] = list()
				buffer[] = list()

			buffer_players.Add(format_text("<al4></a><al[3+(length("{Y?{x") - length(rStrip_Escapes("{Y?{x")))]>{Y?{x</a> <al[15+(length("Name") - length(rStrip_Escapes("Name")))]>Name</a><al[9+(length("{RPvP W/L{x") - length(rStrip_Escapes("{RPvP W/L{x")))]>{RPvP W/L{x</a><al[11+(length("{GArena W/L{x") - length(rStrip_Escapes("{GArena W/L{x")))]>{GArena W/L{x</a><al[13+(length("{YRace{x") - length(rStrip_Escapes("{YRace{x")))]>{YRace{x</a><al[11+(length("{WForm{x") - length(rStrip_Escapes("{cForm{x")))]>{cForm{x</a>\n"))

			for(var/mob/Player/P in game.players){
				if(!P.invisible){
					if(P.immLevel > 0){
						buffer_players.Add(format_text("<al4></a><al[3+(length("[P.immTag()]") - length(rStrip_Escapes("[P.immTag()]")))]>[P.immTag()]</a> <al[15+(length("[P.raceColor(P.name)]") - length(rStrip_Escapes("[P.raceColor(P.name)]")))]>[P.raceColor(P.name)]</a><al[9+(length("{R[ratio(P.pvpk,P.pvpd)]%{x") - length(rStrip_Escapes("{R[ratio(P.pvpk,P.pvpd)]%{x")))]>{R[ratio(P.pvpk,P.pvpd)]%{x</a><al[11+(length("{G[ratio(P.arenaw,P.arenal)]%{x") - length(rStrip_Escapes("{G[ratio(P.arenaw,P.arenal)]%{x")))]>{G[ratio(P.arenaw,P.arenal)]%{x</a><al[13+(length("[rankColor(P.race,getRaceName(P.race))]") - length(rStrip_Escapes("[rankColor(P.race,getRaceName(P.race))]")))]>[rankColor(P.race,getRaceName(P.race))]</a><al[19+(length("[P.raceColor(P.form)]") - length(rStrip_Escapes("[P.raceColor(P.form)]")))]>[P.raceColor(P.form)]</a>\n"))
					}else{
						buffer_players.Add(format_text("<al4></a><al[3+(length("[user.mobMark(P)]") - length(rStrip_Escapes("[user.mobMark(P)]")))]>[user.mobMark(P)]</a> <al[15+(length("[P.raceColor(P.name)]") - length(rStrip_Escapes("[P.raceColor(P.name)]")))]>[P.raceColor(P.name)]</a><al[9+(length("{R[ratio(P.pvpk,P.pvpd)]%{x") - length(rStrip_Escapes("{R[ratio(P.pvpk,P.pvpd)]%{x")))]>{R[ratio(P.pvpk,P.pvpd)]%{x</a><al[11+(length("{G[ratio(P.arenaw,P.arenal)]%{x") - length(rStrip_Escapes("{G[ratio(P.arenaw,P.arenal)]%{x")))]>{G[ratio(P.arenaw,P.arenal)]%{x</a><al[13+(length("[rankColor(P.race,getRaceName(P.race))]") - length(rStrip_Escapes("[rankColor(P.race,getRaceName(P.race))]")))]>[rankColor(P.race,getRaceName(P.race))]</a><al[19+(length("[P.raceColor(P.form)]") - length(rStrip_Escapes("[P.raceColor(P.form)]")))]>[P.raceColor(P.form)]</a>\n"))
					}
				}
			}

			buffer +="{Y({x{R*{x{Y){x {c:::::::{x {CClients connected to{x [game.name] {c:::::::{x {Y({x{R*{x{Y){x\n\n"

			if(buffer_players.len > 1){
				buffer += buffer_players
			}

			if(buffer_players.len <= 1){
				buffer += format_text("<al4></a>There are currently no players connected.")
			}
			else{
				buffer += format_text("\n\n<al4></a>{CPlayers Found:{x {c[buffer_players.len - 1]{x")
			}

			buffer +="\n\n{Y({x{R*{x{Y){x {c::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::{x {Y({x{R*{x{Y){x\n\n"

			send(implodetext(buffer,""),user,TRUE)
		}