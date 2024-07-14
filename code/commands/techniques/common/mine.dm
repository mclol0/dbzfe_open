Command/Technique
	proc
		findEnemies(mob/p){
			for(var/mob/m in p.loc){
				if(m == p){ continue; }

				return TRUE;
			}

			return FALSE;
		}

	energy_mine
		name = "mine"
		internal_name = "energy mine"
		format = "~mine";
		priority = 1;
		_minDistance = 0;
		_maxDistance = 0;
		tType = ENERGY;
		defenses = NULL;
		helpCategory = "Advanced Combat"
		helpDescription = "Create a landmine of energy that explodes on an unaware opponent as he enters the room."
		skillDatum = /fEAttk/energyMine

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {

			if(..(user,target,TRUE,name)){
				return;
			}

			if(findEnemies(user)){
				send("You can't place a mine in the same room as an enemy!",user);
				return FALSE;
			}

			send("{B* You aim your hand at the ground and fire an energy mine into the ground!{x\n",user)
			send("{W*{x [user.raceColor(user.name)] aims [user.determineSex(1)] hand at the ground and fires an energy mine into the ground!\n",a_oview_extra(0,user,target))

			new /fEAttk/energyMine(user,src);
		}