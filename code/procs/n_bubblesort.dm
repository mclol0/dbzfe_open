proc
	bubbleSort(list/L)
	{
		if (!L || L.len < 2)
			return L

		for (var/x = 1 to L.len - 1)
			for (var/y = x + 1 to L.len)
				var/num1 = text2num(L[x])
				var/num2 = text2num(L[y])
				if (num1 < num2)
					L.Swap(x, y)

		return L
	}
