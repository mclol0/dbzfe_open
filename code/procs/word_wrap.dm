proc
	wordwrap(string, width=80)
		var/list/lines = new
        // breaks will be associative; a TRUE value means to display it
		var/list/breaks = list(" ", "\t", "-" = TRUE)

		while(string)   // string will gradually be pulled apart
        // First step: pull out lines that fit within the width
			var/pos = findtext(string, "\n")
			while(pos && pos <= width)
				lines.Add(copytext(string, 1, pos))
				string = copytext(string, pos+1)
				pos = findtext(string, "\n")

			var/len = length(string)

			if(len <= width)    // If we're in the width, we're done
				lines.Add(string)
				break

			var/broken = FALSE
            // Step two: start at the end of the width, and come back
            // until we find a break-point
			BreakLoop:
				for(var/index = width, index, index--)
					for(var/linebreak in breaks)
						var/lbLen = length(linebreak)

                    // If this break is too long, move on
						if(index+lbLen > len)
							continue

						if(cmpText(linebreak, \
							copytext(string, index, index+lbLen)))

							lines.Add(copytext(string, 1, index + \
								(breaks[linebreak] ? lbLen : 0)))

							string = copytext(string, index+lbLen)
							broken = TRUE
							break BreakLoop

			if(broken)  // Time to start at step 1? Sure!
				continue

        // If nothing break-worthy was found, just pull a string
        // that matches the width in length, and go back to step 1
			else
				lines.Add(copytext(string, 1, width+1))
				string = copytext(string, width+1)

        // Add each line to the return value
		for(var/index in 1 to lines.len)
			lines[index] = " " + lines[index] + format_text("<ar[34-length(rStrip_Escapes(lines[index]))]></a>")
			. += "[index != 1 ? "^d{d****{x{x\n^d{d****{x{x^r{W" : ""][lines[index]]"