proc
	wcheck(num as num, maxWeight){
		if(num > maxWeight){
			return "{R[num]{x"
		}else if(num == maxWeight){
			return "{Y[num]{x"
		}else if(num < maxWeight){
			return "{C[num]{x"
		}

		return commafy(num);
	}