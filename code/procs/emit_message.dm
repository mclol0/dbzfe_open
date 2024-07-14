proc
	emitMessage(mob/m, range, message, delay){
		for(var/mob/Player/p in range){
			if(!m.canSense(p)) { continue; }

			p.senseDat.addMessage(m.ID,message,FALSE,delay)
		}

		return TRUE;
	}
