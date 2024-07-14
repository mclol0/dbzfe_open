Command/Technique
	zanzoken
		name = "zanzoken"
		internal_name = "zanzoken"
		format = "~zanzoken; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 15;
		_minDistance = 0;
		tType = MELEE;
		comboAble = FALSE;
		comboName = "zw";
		defenses = list(PARRY_HIGH,DUCK,BARRIER)
		breakCombo = FALSE;
		helpCategory = "Advanced Combat"
		helpDescription = "Use your incredible speed to move faster than the eye can see and reappear next to your opponent.\n\n{YNote:{x {CWhen used while your enemy is far from you, stamina cost and combo chance are halved."
		skillDatum = /atkDatum/zanzoken

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=FALSE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance) && a_get_dist(user,target) >= _minDistance){
				if(..(user,target)){
					return FALSE;
				}

				if(user.chkDef(/atkDatum/zanzoken)){
					send("{B* You reappear and vanish into thin air again...\n{x",user);
					send("{R*{x [user.raceColor(user.name)] reappears and vanishes into thin air again...\n{x",a_oview_extra(0,user,target))
				} else {
					send("{B*{x {BYou vanish into thin air...{x\n",user)
					send("{W*{x [user.raceColor(user.name)]{W vanishes into thin air...\n{x",a_oview_extra(0,user,target))
					send("{R*{x [user.raceColor(user.name)]{R vanishes into thin air...\n{x",target)
				}

				if(user.density == target.density && user.loc == target.loc){
					delay = 30;
				} else {
					delay = 1;
				}

				new /atkDatum/zanzoken(user,target,src,getAttackDelay(src, user.fCombat, target))
			}
			else{
				syntax(user, getSyntax())
			}
		}