proc
	time(time=world.time){
		var
			s = round((time % 600 / 10))
			m = round((time % 36000 / 600))
			h = round((time / 36000))

		return "[h]h [m]m [s]s"
	}

	systemTime() return call(textLib,"systemTime")()