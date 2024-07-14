atkDatum/barrier

	name = "barrier";

	defense = TRUE;

	New(mob/caller,mob/objective,Command/c,gTime){
		user = caller
		user.atkDat = src
		target = objective
		AID = ++user.aID
		goTime = gTime
		command = c
		locked = TRUE;
		..()
	}