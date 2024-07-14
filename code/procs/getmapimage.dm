proc
	GetMapImage(zlevel=1,size=1)
		var x_size = size * world.maxx
		var y_size = size * world.maxy
		while(x_size>4096){size=round(size/2);x_size = size * world.maxx}
		while(y_size>4096){size=round(size/2);y_size = size * world.maxy}
		var/icon/img = new('A.dmi')
		img.Crop(1,1,world.maxx*size,world.maxy*size)
		. = 0
		for(var/Y=1 to world.maxy)
			for(var/X=1 to world.maxx)
				var
					turf/T = locate(X,Y,zlevel)

				if(T && T.icon)
					world << T
					var/icon/A = new(T.icon,T.icon_state,T.dir,1)

					A.Scale(1*size,1*size)
					img.Blend(A,ICON_OVERLAY,X*size,Y*size)

		return img