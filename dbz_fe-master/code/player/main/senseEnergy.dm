
#define SENSE_DELAY 6 SECONDS

senseEnergy

	New(mob/Player/m){
		..()
		p = m;
		start();
	}

	var
		mob/Player/p;

		recentMessages[] = list()
		junkMessages[] = list()

	proc
		addMessage(ID,message,senseMessage=FALSE,DELAY=SENSE_DELAY){
			switch(senseMessage){
				if(TRUE){
					if((locate(/Command/Technique/sense) in p.techniques) && !("[ID] sense" in junkMessages)){
						junkMessages += list("[ID] sense" = (world.time + DELAY))
						recentMessages += list(ID = message)
					}
				}

				if(FALSE){
					if((locate(/Command/Technique/sense) in p.techniques) && !("[ID] [message]" in junkMessages)){
						junkMessages += list("[ID] [message]" = (world.time + DELAY))
						recentMessages += list(ID = message)
					}
				}
			}
		}

		start(){
			set waitfor = FALSE;
			set background = TRUE;

			while(p){
				for(var/x in recentMessages){
					send(recentMessages[x],p);
					recentMessages.Remove(x);
				}

				for(var/y in junkMessages){
					if(world.time >= junkMessages[y]){
						junkMessages.Remove(y);
					}
				}

				sleep(world.tick_lag);
			}

			del(src);
		}