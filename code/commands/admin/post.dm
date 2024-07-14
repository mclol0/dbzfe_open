Command/Wiz
	post
		name = "post";
		format = "post; any";
		syntax = "{cpost{x {c\[{x{Cmessage{x{c\]"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 3

		command(mob/user, text) {
			if(length(text) > 0){
				send(text,game.players,TRUE)
			}
			else{
				send("You can't have a blank message!",user,TRUE)
			}
		}