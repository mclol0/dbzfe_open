Command/Technique
	timeskip
		name = "timeskip"
		internal_name = "timeskip"
		format = "~timeskip; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 15;
		_minDistance = 0;
		tType = MELEE;
		comboAble = FALSE;
		comboName = "ts";
		defenses = list(PARRY_HIGH,DUCK,BARRIER)
		breakCombo = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Stop time around your target and then make an attack of opportunity against him. This attack can either {WStun{x {Cor {RDamage{x {Cyour opponent.\n\n{YNote:{x {CIf damage occurs, cooldown time is halved."
		skillDatum = /atkDatum/timeskip

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=FALSE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance) && a_get_dist(user,target) >= _minDistance){
				if(..(user,target)){
					return FALSE;
				}

				send("{B*{x {BTime {x{Rstops{x{B...{x\n",user)
				send("{W*{x Time {Rstops{x as [user.raceColor(user.name)]{W vanishes into thin air...\n{x",a_oview_extra(0,user,target))
				send("{R*{x Time {Rstops{x as [user.raceColor(user.name)]{R vanishes into thin air...\n{x",target)
				game.addCooldown(user.name,"timeskip",4 SECONDS);
				new /atkDatum/timeskip(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax());
			}
		}