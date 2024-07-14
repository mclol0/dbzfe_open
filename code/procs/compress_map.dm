proc
	compressMap(list/mapBuffer=list(),mapCompression){
		switch(mapCompression){
			if(TRUE){
				var
					lastDisplay = NULL;

				for(var/display=1,display<mapBuffer.len,display++){
					if(mapBuffer[display] == lastDisplay && length(mapBuffer[display]) > 1){
						mapBuffer[display] = copytext(mapBuffer[display],3,length(mapBuffer[display])-1) + "{x"
						mapBuffer[display-1] = copytext(mapBuffer[display-1],1,length(mapBuffer[display-1])-1)
					}else{
						lastDisplay = mapBuffer[display]
						continue
					}
				}
			}
		}
		return mapBuffer;
	}