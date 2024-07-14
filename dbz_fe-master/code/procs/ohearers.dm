/proc/_ohearers(Depth=world.view, Center=usr){
	. = ohearers(Depth,Center);

	if(istype(Center,/mob)){
		for(var/A in .){
			if(istype(A,/mob) && istype(Center,/mob) && (A:insideBuilding != Center:insideBuilding)){
				. -= A;
			}
		}
	}
}