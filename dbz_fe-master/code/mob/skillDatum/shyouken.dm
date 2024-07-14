atkDatum
	utility
		shyouken
			name = "shyouken"
			cost = 3
			cdTime = 25 SECONDS
			comboExtendChance = fightShyoukenCombo
			duration = 7 SECONDS

			New(mob/caller,Command/c){
				if (caller && c) {
					user = caller
					command = c
					user._doEnergy(-getCost())
					game.addCooldown(user.name,command.internal_name, cdTime);
					goTime = world.time
					..();
				}
			}

			go(){
				user.shyouken((world.time + duration));
			}