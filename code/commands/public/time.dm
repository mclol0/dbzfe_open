Command/Public
	time
		name = "time"
		format = "time";
		canUseWhileRESTING = TRUE;
		helpDescription = "Display the current date and time."

		command(mob/user) {
			send("System Time: [timeGetTime("month")]/[timeGetTime("date")]/[timeGetTime("year")] [timeGetTime("time")].",user)
		}