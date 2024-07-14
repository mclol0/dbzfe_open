proc
	pcheck(n){
		if(n>0){
			return "{G+[n]%{x"
		}else if (n<0){
			return "{R[n]%{x"
		}else{
			return "[n]%"
		}
	}