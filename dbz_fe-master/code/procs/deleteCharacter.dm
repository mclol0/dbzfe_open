proc
	DeleteCharacter(var/mob/Player/user){
		var/playerName = user.name;

		user.canSave = FALSE;
		user.properExit = TRUE;
		user.Logout();

		_query("DELETE FROM `characters` WHERE `name`='[playerName]';");
		_query("DELETE FROM `aliases` WHERE `owner`='[playerName]';");
		_query("DELETE FROM `inventory` WHERE `owner`='[playerName]';");
		_query("DELETE FROM `corpses` WHERE `name`='[playerName]';");
		_query("DELETE FROM `quest_data` WHERE `owner`='[playerName]';");
		_query("DELETE FROM `player_storage` WHERE `PLAYER`='[playerName]';");
		houseSystem.deletePlayer(playerName)
		houseSystem._removeFromSharedHouses(playerName)
		world.SetScores(playerName,"")
	}