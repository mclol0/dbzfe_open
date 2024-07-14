Layout
	proc
		formatLog(log, level, name)
		startLog()
		endLog()
		getFileExtension()

	PlaintextLayout
		startLog(name = "SERVER") return "\[[name]\] \[[timeGetTime("month")]/[timeGetTime("date")]/[timeGetTime("year")] [timeGetTime("time")] EST\] Logging started at [time2text(world.timeofday)]"

		formatLog(log, level, name = "SERVER")
			if(log)
				log = "\[[name]\] \[[timeGetTime("month")]/[timeGetTime("date")]/[timeGetTime("year")] [timeGetTime("time")] EST\] \[[level2text(level)]([level])\]: [log]\n"

				return log

		endLog(name = "SERVER") return "\[[name]\] \[[timeGetTime("month")]/[timeGetTime("date")]/[timeGetTime("year")] [timeGetTime("time")] EST\] Logging ended at [time2text(world.timeofday)]"

		getFileExtension() return "log"

	HTMLLayout
		startLog() return {"
			<title>[world.name] System LOG</title>
			<body bgcolor=#000000></body>
			<i><font color=#FFFFFF>Logging started at [timeGetTime("month")]/[timeGetTime("date")]/[timeGetTime("year")] [timeGetTime("time")] EST</font></i><br>
			<style type="text/css">
			.tftable {font-size:12px;color:#fbfbfb;width:100%;border-width: 1px;border-color: #686767;border-collapse: collapse;}
			.tftable th {font-size:12px;background-color:#171515;border-width: 1px;padding: 8px;border-style: solid;border-color: #686767;text-align:left;}
			.tftable tr {background-color:#2f2f2f;}
			.tftable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #686767;}
			.tftable tr:hover {background-color:#171515;}
			</style>

			<table class="tftable" border="1">
			<tr><th>TIME</th><th>LEVEL</th><th>LOGGER</th><th>MESSAGE</th></tr>
			"}

		formatLog(log, level, name = "SERVER")
			var
				time_format = "[world.time] ([timeGetTime("month")]/[timeGetTime("date")]/[timeGetTime("year")] [timeGetTime("time")] EST)"
				level_format = "[level2text(level)] ([level])"
				name_format = "[name]"
				log_format = "[log]"

			if(level == LOG_FATAL)
				time_format = "<b><font color=#FF0000>[time_format]</font><b>"
				level_format = "<b><font color=#FF0000>[level_format]</font><b>"
				name_format = "<b><font color=#FF0000>[name_format]</font><b>"
				log_format = "<b><font color=#FF0000>[log_format]</font><b>"

			if(level == LOG_ERROR)
				time_format = "<font color=#FF0000>[time_format]</font>"
				level_format = "<font color=#FF0000>[level_format]</font>"
				name_format = "<font color=#FF0000>[name_format]</font>"
				log_format = "<font color=#FF0000>[log_format]</font>"

			if(level == LOG_WARN)
				time_format = "<b>[time_format]</b>"
				level_format = "<b>[level_format]</b>"
				name_format = "<b>[name_format]</b>"
				log_format = "<b>[log_format]</b>"

			log = "<tr><td>[time_format]</td><td>[level_format]</td><td>[name_format]</td><td>[log_format]</td></tr>"

			return log

		endLog() return "</table><i><font color=#FFFFFF>Logging ended at [time2text(world.timeofday)]</font></i><hr>"

		getFileExtension() return "html"