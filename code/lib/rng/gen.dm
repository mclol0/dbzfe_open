proc
	exportMap(zlevel){
		set waitfor=FALSE;

		var
			buffer[] = list()

		buffer += "<body bgcolor=#000000><h1 style=\"font-family:Fixedsys;\">"

		for(var/YY=1,YY!=world.maxy+1,YY++){
			for(var/XX=1,XX!=world.maxx+1,XX++){
				world << "[XX],[YY]"
				var
					turf/t = locate(XX,YY,zlevel)

				if(t){
					buffer += call(textLib,"ByondColors")(t.display)
				}

				if(XX >= world.maxx){ buffer += "<br />"; }
			}
		}

		buffer += "</h1></body>"

		if(fexists("[zlevel].html")){fdel("[zlevel].html")}

		text2file(join(buffer,""),"[zlevel].html")
	}

	genWorld(seed as num,zlevel as num)
		var/Noise/biome_1 = new(world.maxx - 15, world.maxy - 15)
		biome_1.frequency = 32
		biome_1.amplitude = 256
		biome_1.smoothness = 8
		biome_1.Randomize(seed)

		var/Noise/biome_2 = new(world.maxx - 15, world.maxy - 15)
		biome_2.frequency = 16
		biome_2.amplitude = 256
		biome_2.smoothness = 4
		biome_2.Randomize(seed)

		var/Noise/biome_3 = new(world.maxx - 15, world.maxy - 15)
		biome_3.frequency = 8
		biome_3.amplitude = 256
		biome_3.smoothness = 2
		biome_3.Randomize(seed)

		for(var/turf/t in block(locate(1,1,zlevel),locate(world.maxx,world.maxy,zlevel)))
			switch(round(biome_1.Noise(t.x,t.y)))
				if(0 to 85) new /turf/freezer/water (t)
				if(86 to 200) new /turf/freezer/grass(t)
				if(201 to 256) new /turf/freezer/sand(t)

			if(istype(t, /turf/freezer/grass)){
				if(round(biome_2.Noise(t.x,t.y))>=150){
					new /turf/freezer/mountain (t)
				}
			}

			if(istype(t, /turf/freezer/mountain)){
				if(round(biome_3.Noise(t.x,t.y))>=185){
					new /turf/freezer/river (t)
				}
			}
Noise
	var
		// This matrix stores the amount of noise for each point in the block
		list/noise[][]

		// amount of a noise in one wavelength
		frequency

		// max value of noise
		amplitude

		// matrix size
		width
		height

		// ammount to smooth results
		smoothness
	New(Width, Height)
		width  = Width
		height = Height
		noise = new/list(width, height)
	proc/Noise(x, y)
		if(x > 0 && x <= width && y > 0 && y <= height)
			return noise[x][y]
	proc/SmoothPoint(x, y)
		var/corners = ( Noise(x-1, y-1)+Noise(x+1, y-1)+Noise(x-1, y+1)+Noise(x+1, y+1) ) / 16
		var/sides   = ( Noise(x-1, y)  +Noise(x+1, y)  +Noise(x, y-1)  +Noise(x, y+1) ) /  8
		var/center  =  Noise(x, y) / 4
		return corners + sides + center
	proc/Blend()
		var/Noise/n = args[1]
		for(var/x = 1 to width)
			for(var/y = 1 to height)
				noise[x][y] = n.noise[x][y]
		for(n in args - args[1])
			for(var/x = 1 to width)
				for(var/y = 1 to height)
					noise[x][y] =(noise[x][y] + n.noise[x][y])/2

	proc/Smooth()
		for(var/x = 1 to width)
			for(var/y = 1 to height)
				noise[x][y] = SmoothPoint(x, y)
	proc/Randomize(seed)
		if(seed) rand_seed(seed)
		var/wavelength = 1/frequency
		var/x
		var/y
		var/list/x_nodes = list()
		var/list/y_nodes = list()
		x = 1
		while(x < width)
			y=1
			while(y < height)
				var/rx = round(x)
				var/ry = round(y)
				noise[rx][ry] = rand(1,amplitude)
				x_nodes += rx
				y_nodes += ry
				y += wavelength*height
			x += wavelength*height
		x_nodes += height
		y_nodes += width
		var/px
		var/cx
		var/py
		var/cy
		for(x = 1, x <= x_nodes.len-1, x++)
			cx = x_nodes[x]
			px = x_nodes[x+1]
			for(y = 1, y <= y_nodes.len-1, y++)
				cy = y_nodes[y]
				py = y_nodes[y+1]
				if(px == width) px ++
				if(py == height) py ++
				for(var/tx = cx to px-1)
					for(var/ty = cy to py-1)
						noise[tx][ty] = noise[cx][cy]
		for(var/s = 1 to smoothness)
			Smooth()