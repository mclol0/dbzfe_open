proc
	percent_color(min, max)
	{
		var/p = percent(min, max)

		if (p <= 25)
			return "{R[p]%{x"
		if (p <= 50)
			return "{Y[p]%{x"
		if (p <= 100)
			return "{B[p]%{x"
		if (p)
			return "{C[p]%{x"
	}

proc
	percent_color_nop(v, min, max)
	{
		var/p = percent(min, max)

		if (p <= 25)
			return "{R[v]{x"
		if (p <= 50)
			return "{Y[v]{x"
		if (p <= 100)
			return "{C[v]{x"
		if (p)
			return "{G[v]{x"
	}
