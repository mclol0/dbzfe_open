atkDatum
	utility
		barrier
			name = "barrier"
			cost = 2

			New(mob/caller,Command/c){
				if (caller && c) {
					user = caller
					command = c
					user._doEnergy(-getCost(), NO_ENERGY=TRUE)
					go()
				}
			}

			go(){
				user.barrier = TRUE;
				user.barrier()
			}