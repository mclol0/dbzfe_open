proc
	pick_type(type, list/list){
		var/list/result[] = list();

		for(var/datum/t in list){
			if(t.type == type){
				result.Add(t);
			}
		}

		return pick(result);
	}