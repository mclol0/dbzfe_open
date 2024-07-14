proc
	/*
	This procedure is just for the admin server command.
	*/
	eff_color(min,max){
		var/percent = percent(min,max)
		if(percent <= 25){
			return "{C[percent]%{x"
		}
		else if(percent <= 60){
			return "{Y[percent]%{x"
		}
		else if(percent <= 100){
			return "{R[percent]%{x"
		}
		else if(percent){
			return "{Y[percent]%{x"
		}
	}