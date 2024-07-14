proc
	ncheck(num as num, sigFIG = 999, var/mob/m=NULL, var/shortNUM=FALSE){
		if(m != null && shortNUM){
			if(num>0){
				return "{G+[short_num(num)]{x"
			}else if(num<0){
				return "{R-[short_num(abs(num))]{x"
			}else{
				return "[short_num(num)]"
			}
		}else{
			if(num>0){
				return "{G+[commafy(num,sigFIG)]{x"
			}else if(num<0){
				return "{R-[commafy(abs(num),sigFIG)]{x"
			}else{
				return "[commafy(num,sigFIG)]"
			}
		}
	}