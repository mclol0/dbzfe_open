proc
	bubbleSort(list/L)
		var
			num1
			num2
		if(L.len > 0)
			for(var/x=1 to L.len-1)
				for(var/y=x+1 to L.len)
					num1 = text2num(L[L[x]])
					num2 = text2num(L[L[y]])
					if(num1 < num2)
						L.Swap(x,y)
		return L