Command/Technique
	pulse
		name = "pulse"
		internal_name = "pulse"
		format = "~pulse; ~searc(mob@planet)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 4;
		_minDistance = 0;
		tType = MELEE;
		comboAble = FALSE;
		defenses = list(JUMP,ABSORB,BARRIER)
		breakCombo = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Release your spiritual pressure with devestating vibrations into a pulse to stun your enemy."
		skillDatum = /atkDatum/pulse

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=FALSE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance) && a_get_dist(user,target) >= _minDistance){
				if(..(user,target)){
					return FALSE;
				}

				send("{B* You begin to release your spiritual energy in pulses around you.{x\n",user)
				send("{W* [user.raceColor(user.name)]{W begins to release spiritual energy towards [target.name]...\n{x",a_oview_extra(0,user,target))
				send("{R*{x[user.raceColor(user.name)]{R begins to release spritual energy in pulses around you...\n{x",target)
				game.addCooldown(user.name,"pulse",3 SECONDS);
				new /atkDatum/pulse(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax());
			}
		}
