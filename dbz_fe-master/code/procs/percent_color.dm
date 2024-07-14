proc
	percent_color(min,max){
		var/percent = percent(min,max)
		if(percent <= 25){
			return "{R[percent]%{x"
		}
		else if(percent <= 50){
			return "{Y[percent]%{x"
		}
		else if(percent <= 100){
			return "{B[percent]%{x"
		}
		else if(percent){
			return "{C[percent]%{x"
		}
	}

	percent_color_nop(v,min,max){
		var/percent = percent(min,max)
		if(percent <= 25){
			return "{R[v]{x"
		}
		else if(percent <= 50){
			return "{Y[v]{x"
		}
		else if(percent <= 100){
			return "{C[v]{x"
		}
		else if(percent){
			return "{G[v]{x"
		}
	}