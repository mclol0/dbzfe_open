Option/prefix
    forceValue
    optional
    caseSensitive
    partial
Option/postfix/range
	proc
		_filterList(list/L) {
			. = new /list();
			for(var/entry in L) {
				if(src._isCorrectType(entry)) . += entry;
			}
		}

		_isCorrectType(entry) {
			for(var/typeVal in _types) {
				if(istype(entry, typeVal)) {
					return TRUE;
				}
			}
			return FALSE;
		}

		_generateTypes() {
			src._types = new();
			var/list/entries = __textToList(src._typeFilterStr, "|");
			for(var/a in entries) {
				src._types += text2path("/[a]");
			}
		}

		getListFromKey(mob/M) {
			. = new /list();
			switch(_key) {
				if("clients") {
					for(var/client/cli) . += cli;
				}
				if("corpse") {
					for(var/obj/item/corpse/c in M.loc)
						if (checkPlane(M, c)) . += c;
				}
				if("mob_loc") {
					. = M.getRoom();
				}
				if("all_mob_loc") {
					. = M.getAllRoom();
				}
				if("item_loc") {
					. = M.getItemRoom();
				}
				if("container"){
					for(var/obj/o in M.loc) 
						if (checkPlane(M, o)) . += o;
				}
				if("inventory"){
					for(var/obj/o in M.contents) . += o;
				}
				if("equipment"){
					for(var/obj/o in M.equipment) . += o;
				}
				if("melee_range_0")	{
					for(var/mob/A in radius_out(0,M.calcMeleeRange(0),M)){ if(M.density && !A.density || !M.density && A.density || M == A || !checkPlane(M, A)){continue}else{. += A;} }
				}
				if("melee_range_1")	{
					for(var/mob/A in radius_out(0,M.calcMeleeRange(1),M)-M){ 
						if (checkPlane(M, A)) . += A; 
					}
				}
				if("melee_range_2")	{
					for(var/mob/A in radius_out(0,M.calcMeleeRange(2),M)-M){ 
						if (checkPlane(M, A)) . += A; 
					}
				}
				if("world") {
					for(var/atom/A in world) . += A;
				}
				if("planet") {
					. += M.zMobs(TRUE);
				}
				if("planet_all") {
					. += M.zMobs(TRUE, TRUE);
				}
				if("mobiles") {
					for(var/mob/A in game.mobiles) . += A;
				}
				if("players") {
					for(var/atom/A in game.players) . += A;
				}
			}

			. = distance_order(M,.);
		}

		_getPossibles(mob/M) {
			. = getListFromKey(M);
			. = _filterList(.);
		}

	var
		list/_types
		_typeFilterStr;
		_key;

	New(typeFilterStr, key) {
		src._typeFilterStr = typeFilterStr;
		src._key = key;
		_generateTypes();
	}
