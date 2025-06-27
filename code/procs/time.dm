proc
	time(time=world.time){
		var
			s = round((time % 600 / 10))
			m = round((time % 36000 / 600))
			h = round((time / 36000))

		return "[h]h [m]m [s]s"
	}

	// Convert C systemTime to BYOND (returns "Sun Jan 15 14:30:25 2025" format)
	systemTime()
	{
		// Use BYOND's built-in time2text function with the exact C format
		return time2text(world.realtime, "DDD MMM DD hh:mm:ss YYYY")
	}