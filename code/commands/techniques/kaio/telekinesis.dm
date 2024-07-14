Command/Technique
	telekinesis
		name = "telekinesis"
		internal_name = "telekinesis"
		format = "~telekinesis; ?~searc(mob@planet); word";
		syntax = list("mobile", "north | south | east | west | northeast | northwest | southeast | southwest")
		priority = 1
		_maxDistance = 8;
		_minDistance = 0;
		tType = MELEE;
		defenses = list()
		canFinish = FALSE;
		comboAble = FALSE;
		breakCombo = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Similar to throw, use your mind to launch a stunned enemy out of the room."
		skillDatum = /atkDatum/sk_throw

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE), direction=pick("north","south","east","west","northeast","northwest","southeast","southwest")) {
			direction=determineThrow(direction);

			if(target && direction && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}

				if(!target.stunned){
					send("They're not stunned!",user,TRUE);
					return FALSE;
				}

				new /atkDatum/sk_throw(user,target,src,world.time,direction)

			}
			else{
				syntax(user, getSyntax())
			}
		}