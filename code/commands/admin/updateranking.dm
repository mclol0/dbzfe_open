Command/Wiz
	updateranking
		name = "updateranking";
		format = "updateranking";
		syntax = "{cupdateranking{x"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 3

		command(mob/user, text) {
			send("Updating ranking..",game.players);
			game.forceRankUpdate();
		}