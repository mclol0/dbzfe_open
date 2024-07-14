Appender
	var/Layout/layout = NULL;

	New(Layout/_layout)
		layout = _layout

	proc
		startLog() if(layout) append(layout.startLog(), 0, "", FALSE)
		endLog() if(layout) append(layout.endLog(), 0, "", FALSE)

		append(log, level, name, format = TRUE)
			if(!layout) layout = new/Layout/PlaintextLayout

		setLayout(Layout/_layout)
			ASSERT(_layout)
			layout = _layout

		getLayout() return layout

	FileAppender
		var/output_file = ""

		New(Layout/_layout, _output_file)
			layout = _layout
			output_file = _output_file

			..()

		append(log, level, name, format = TRUE)
			..(log, level, name, format)

			if(format) log = layout.formatLog(log, level, name)
			if(output_file)
				/*if (!fexists(output_file))
					var/preamble = layout.formatLog(layout.startLog(),  0, "")
					text2file(preamble, output_file)*/
				text2file(log, output_file)

			return log

		proc
			setOutputFile(_output_file) output_file = _output_file
			getOutputFile() return output_file

		DailyFileAppender
			append(log, level, name, format = TRUE)
				var/set_output = output_file
				var/time = time2text(world.realtime, "YYYY-MM-DD")
				output_file = "[set_output]/[time].[layout.getFileExtension()]"
				..(log, level, name, format)
				output_file = set_output

				return log

	WorldLogAppender
		append(log, level, name,  format = TRUE)
			..(log, level, name,  format)

			if(format) log = layout.formatLog(log, level, name)
			world.log << log