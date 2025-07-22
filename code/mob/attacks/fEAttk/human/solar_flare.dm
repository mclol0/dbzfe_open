fEAttk
	solarflare
		name = "solarflare"
		enPerTick = 3
		blindTime = 3 SECONDS
		stunChance = 25
		cdTime = 30 SECONDS

		New(mob/user, mob/target, Command/c){
			if (user && target) {
				..()
				mobRef = user
				targetRef = target
				cRef = c
				user._doEnergy(-enPerTick,TRUE)
				game.addCooldown(mobRef.name,c.internal_name,cdTime);
				fire();
			}
		}

		proc/fire() {
			targetRef:blind((world.time + blindTime));

			send("{R*{x You were blinded by [mobRef.raceColor(mobRef.name)]'s [cRef:internal_name]!",targetRef,TRUE);

			if(decimal_prob(stunChance)){
				stunned(targetRef,mobRef,(world.time + 45))
			}
		}