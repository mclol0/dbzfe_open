proc/isScanner(obj/item/i, returnLevel=FALSE){
	var/isScouter = ispath(i.type, /obj/item/SCOUTER)
	if(isScouter && returnLevel) {
		return i:SCOUTER_LEVEL
	}

	return isScouter
}
