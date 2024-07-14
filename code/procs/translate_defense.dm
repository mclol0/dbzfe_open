proc
	translateDefense(defense){
		switch(defense){
			if(PARRY_HIGH) return "parry high"
			if(PARRY_LOW) return "parry low"
			if(JUMP) return "jump"
			if(DUCK) return "duck"
			if(DODGE_LEFT) return "dodge left"
			if(DODGE_RIGHT) return "dodge right"
			if(SWEEP) return "sweep"
			if(ABSORB) return "absorb"
			if(DEFLECT) return "deflect"
			if(ZANZOKEN) return "zanzoken"
			if(SPIN_KICK) return "spin kick"
			if(BARRIER) return "barrier"
		}
	}

	translateDefenseSKILL(defense){
		switch(defense){
			if(PARRY_HIGH) return /Command/Technique/parry
			if(PARRY_LOW) return /Command/Technique/parry
			if(JUMP) return /Command/Technique/jump
			if(DUCK) return /Command/Technique/duck
			if(DODGE_LEFT) return /Command/Technique/dodge
			if(DODGE_RIGHT) return /Command/Technique/dodge
			if(SWEEP) return /Command/Technique/sweep
			if(ABSORB) return /Command/Technique/absorb
			if(DEFLECT) return /Command/Technique/deflect
			if(ZANZOKEN) return /Command/Technique/zanzoken
			if(SPIN_KICK) return /Command/Technique/spin_kick
			if(BARRIER) return /Command/Technique/barrier
		}
	}