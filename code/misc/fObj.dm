obj
	trail
		display = "~"
		text = "~"
		density = 0
		var/SHOW_IN_MAP = TRUE;

		proc
			decay(){
				set waitfor = FALSE;
				set background = TRUE;

				var/decayTime = 6.5 SECONDS;

				spawn(decayTime){
					loc = NULL;
				}
			}

		New(){
			..()
			decay()
		}

		Del(){
			..()
		}