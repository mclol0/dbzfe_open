Command/Public
	report
		name = "report"
		format = "report; ?any";
		syntax = list("message")
		canAlwaysUSE = TRUE
		helpDescription = "Create a bug report."
		cancelsPushups = FALSE;

		command(mob/user, message) {
			if(message){
				send("Report submitted.",user,TRUE)
				text2file("[user.name]: [message] @ [systemTime()]","./report.log")
			}else{
				syntax(user, src)
			}
		}