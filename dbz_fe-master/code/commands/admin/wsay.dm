Command/Wiz
	wsay
		name = "wsay";
		format = "~wsay; any";
		syntax = "{cwsay{x {c\[{x{Cmessage{x{c\]"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 1

		command(mob/user, text) {
			if(length(text) > 0){
				game.immMsg("{Y\[{x{RIMM{x{Y\]{x [user.raceColor(user.name)]{Y, '{x{W[text]{x{Y'{x")
			}
			else{
				send("You can't have a blank message!",user,TRUE)
			}
		}