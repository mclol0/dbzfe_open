Command/Wiz
	getquest
		name = "getquest";
		format = "getquest; any";
		syntax = "{cgetquest{x {c\[{x{Cmessage{x{c\]"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 3

		command(mob/user, text) {
			if(length(text) > 0){
				qFac.obtainQuest(user,text);
			}
			else{
				send("You can't have a blank message!",user,TRUE)
			}
		}