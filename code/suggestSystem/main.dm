proc

	addSuggestion(var/player,var/suggestion){
		_query("INSERT INTO `suggestions` (suggestion, player, staff, priority, accepted) VALUES (\"[sanit(suggestion)]\", \"[sanit(player)]\", \"No reply.\", '0', '0');")
	}

	replySuggestion(var/ID, var/staff, var/priority, var/reply, var/accept){
		_query("UPDATE `suggestions` SET `staff`='[staff], replied, \"[reply]\"', `priority`='[priority]', `accepted`='[accept]' WHERE `ID`='[ID]';")
	}