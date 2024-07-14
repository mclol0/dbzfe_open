proc/syntax(mob/m, cmdOrSyntax){
	if (istype(cmdOrSyntax, /Command)) {
		send("Syntax: [cmdOrSyntax:getSyntax()]",m,TRUE)
		return
	}
	
	send("Syntax: [cmdOrSyntax]", m, TRUE)
}