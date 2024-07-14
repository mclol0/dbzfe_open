Command/Wiz
	notice
		name = "notice";
		format = "~notice; any";
		syntax = "{cnotice{x {c\[{x{Cmessage{x{c\]"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 2

		command(mob/user, text) {
			if(length(text) > 0){
				var/a = format_text("<ar20>{WNOTICE</a><ar13></a>{W- x{x")
				var/b = format_text("{W[wordwrap(rStrip_Escapes(text),34)]{x")
				var/c = "^d{d*******************************************{x{x"

				send(c,game.players,TRUE)
				send("^d{d****{x{x^b [a] {x{x^d{d****{x{x",game.players,TRUE)
				send("^d{d****{x{x^r[b]{x{x{x^d{d****{x{x",game.players,TRUE)
				send(c,game.players,TRUE)
			}
			else{
				send("You can't have a blank message!",user,TRUE)
			}
		}
