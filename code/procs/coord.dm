proc
	coord(min, max)
		if (min > (max >> 1))
			return min - max - 1
		return min

proc
	byondcoord(min, max)
		if (min < 0)
			return max + min + 1
		return min
