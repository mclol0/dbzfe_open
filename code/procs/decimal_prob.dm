proc/decimal_prob(probability as num)
	return rand(1, 100000) <= round(probability * 1000)
