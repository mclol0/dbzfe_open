proc
	compressMap(list/mapBuffer = list(), mapCompression)
	{
		if (!mapCompression)
			return mapBuffer

		var/lastDisplay = null

		for (var/display = 1; display < mapBuffer.len; display++)
		{
			var/current = mapBuffer[display]
			if (current == lastDisplay && length(current) > 1)
			{
				var/currentLen = length(current)
				mapBuffer[display] = copytext(current, 3, currentLen - 1) + "{x"

				var/prev = mapBuffer[display - 1]
				mapBuffer[display - 1] = copytext(prev, 1, length(prev) - 1)
			}
			else
			{
				lastDisplay = current
			}
		}

		return mapBuffer
	}
