proc
	rand_decimal(min=0,max=0,check=FALSE){

		if(check){
			if(min == 0 && max == 0)
			{
				return 0
			}
		}

		var
			A = rand(min,max)
			B = rand(0,100)
			C = 0

		if(B == 100){
			A++
			B=0
		}

		if(B == 0){
			C=text2num("[A]")
		}else{
			C=text2num("[A].[B]")
		}

		return C
	}