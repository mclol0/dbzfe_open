mob/proc/grab(mob/Player/target){
	set waitfor=FALSE;

	if(!isplayer(target)){
		send("You can only grab players!",src);
		return FALSE;
	}

	if(target.grabbers.Find(src)){
		send("You're already grabbing [target.raceColor(target.name)]!",src);
		return FALSE;
	}

	var
		oldLoc = target.loc;
		targetName = target.raceColor(target.name);

	send("You grab onto [target.raceColor(target.name)]'s hand.",src);
	send("[src.raceColor(src.name)] grabs onto your hand.",target);

	target.grabbers.Add(src);

	while(target){
		if(target.loc != oldLoc || src.loc != target.loc){
			break;
		}

		sleep(world.tick_lag);
	}

	send("You let go of [targetName]'s hand.",src);

	if(target){
		target.grabbers.Remove(src);
		send("[src.raceColor(src.name)] lets go of your hand.",target);
	}
}