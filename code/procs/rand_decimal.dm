proc
	rand_decimal(min = 0, max = 0, check = FALSE)
	{
		if (check && min == 0 && max == 0)
			return 0

		var/A = rand(min, max)
		var/B = rand(0, 100)

		if (B == 100)
		{
			A++
			B = 0
		}

		return A + (B / 100)
	}
