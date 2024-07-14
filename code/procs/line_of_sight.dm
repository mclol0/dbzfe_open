proc
	los(x0, y0, x1, y1, z = 1, xray)
		//line of sight
		//returns 1 if x0, y0 has line of sight to x1, y1
		//returns 0 otherwise
		//blocking is determined by turf.opaque only

		if(xray) return FALSE

		var/dx,dy,x,y,n,x_inc,y_inc,error,turf/t

		dx = abs(x1 - x0)
		dy = abs(y1 - y0)

		x = x0
		y = y0
		n = 1 + (dx + dy)
		x_inc = (x1 > x0) ? 1 : -1
		y_inc = (y1 > y0) ? 1 : -1
		error = dx - dy
		dx *= 2
		dy *= 2


		for(var/i=1;i<n;i++)
			if(i>1)
				t = locate(wrap(x,world.maxx), wrap(y,world.maxy), z)
				if(t.opacity) return FALSE
			if(error > 0)
				x += x_inc
				error -= dy
			else
				y += y_inc
				error += dx

		return TRUE