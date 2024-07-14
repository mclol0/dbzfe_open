Command/Wiz
	givequest
		name = "givequest";
		format = "givequest; !searc(mob@mobiles)|~searc(mob@mobiles); any";
		syntax = "{cgivequest{x {c\[{x{Cmessage{x{c\]"
		canAlwaysUSE = TRUE
		immCommand = 1
		immReq = 3

		command(mob/user, mob/m, text) {
			if(length(text) > 0){
				qFac.obtainQuest(m,text);
			}
			else{
				send("You can't have a blank message!",user,TRUE)
			}
		}