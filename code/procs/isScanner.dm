//2nd number is scanner level a scanner level of 1 will reveal powerlevel a level of 2 will reveal energy and power.

var/list/scanners[] = list(/obj/item/SCOUTER = 1,
							/obj/item/RED_SCOUTER = 2,
							/obj/item/GENERAL_TAO_POWER_GOGGLES = 1,
							/obj/item/MASTER_ROSHIS_SUNGLASSES = 1,
							/obj/item/SHENRONS_LENSES_OF_WISDOM = 2,
							/obj/item/PORUNGAS_LENSES_OF_DEFIANCE = 2,
							/obj/item/BLACK_STAR_LENSES_OF_MALICE = 2,
							/obj/item/GOLDEN_SCOUTER = 2,
							/obj/item/GODLY_FLAME_SCOUTER = 2);

proc/isScanner(obj/item/i, returnLevel=FALSE){
	if(scanners[i.type]){
		if(returnLevel){
			return scanners[i.type];
		}else{
			return TRUE;
		}
	}

	return FALSE;
}
