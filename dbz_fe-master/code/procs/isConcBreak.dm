mob/proc
	isConcBreak(){

		if(kiAttk && kiAttk:isCharging || kiAttk && !kiAttk:isCharge || kiAttk && kiAttk:isMultiProjectile || kiAttk && kiAttk:MULTI_PROJECTILE || atkDat && atkDat:Conc){ return TRUE; }

		return FALSE;
	}