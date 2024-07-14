Command/Wiz
	add_change
		name = "addchange";
		immCommand = 1
		immReq = 4
		format = "addchange; any";
		syntax = "{caddchange{x {c<{x{Cchange{x{c>{x"

		command(mob/user, change) {
			if(user && length(change) > 0){
				send("{CA new change is available, type 'changes' for more information!{x",game.players,TRUE)
				_query("INSERT INTO `changes` (change, date) VALUES (\"[sanit(change)]\", \"[time2text(world.timeofday,"MM-DD-YY")]\")")
			}
			else{
				syntax(user,getSyntax());
			}
		}