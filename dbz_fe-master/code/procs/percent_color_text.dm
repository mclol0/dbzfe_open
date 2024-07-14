proc
	percent_color_text(min,max,text){
		var/percent = percent(min,max)
		if(percent <= 25){
			return "{R[text]{x"
		}
		else if(percent <= 50){
			return "{Y[text]{x"
		}
		else if(percent <= 100){
			return "{B[text]{x"
		}
		else if(percent){
			return "{C[text]{x"
		}
	}

	percent_color_noTex(min,max){
		var/percent = percent(min,max)
		if(percent <= 25){
			return "{R"
		}
		else if(percent <= 50){
			return "{Y"
		}
		else if(percent <= 100){
			return "{B"
		}
		else if(percent){
			return "{C"
		}
	}