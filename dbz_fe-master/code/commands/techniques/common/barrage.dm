Command/Technique
	barrage
		name = "barrage"
		internal_name = "barrage"
		format = "~barrage|br; ?~searc(mob@melee_range_0)";
		syntax = list("mobile")
		priority = 2
		_maxDistance = 0;
		tType = MELEE;
		defenses = list(PARRY_HIGH, PARRY_LOW, DODGE_LEFT, DODGE_RIGHT, BARRIER)
		helpCategory = "Advanced Combat"
		helpDescription = "Throw a fast sequence of random punches and kicks against your enemy. Defenses will vary depending on the kind of attack being used."
		skillDatum = /atkDatum/barrage

		command(mob/user, mob/target=user:fCombat._getLastTarget(checkDensity=TRUE)) {

			if(target && a_get_dist(user,target) <= user.calcMeleeRange(_maxDistance)){
				if(..(user,target)){
					return;
				}
				if(user.atkDat && user.atkDat:name == "barrage"){
					send("You can't start another barrage!",user);
					return;
				}

				var
					attackType = rand(PUNCH_LEFT,KICK_RIGHT);
				switch(attackType){
					if(PUNCH_LEFT){
						send("{B*{x {BYou begin a barrage by retracting your left arm...{x\n",user)
						send("{W*{x [user.raceColor(user.name)] begins a barrage by retracting [user.determineSex(1)] left arm...\n",a_oview_extra(0,user,target))
						send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R begins a barrage by retracting [user.determineSex(1)] left arm...{x"] [target.defenseTips(src)]\n",target)
						src.defenses = list(PARRY_HIGH,DODGE_LEFT,BARRIER)
					}
					if(PUNCH_RIGHT){
						send("{B*{x {BYou begin a barrage by retracting your right arm...{x\n",user)
						send("{W*{x [user.raceColor(user.name)] begins a barrage by retracting [user.determineSex(1)] right arm...\n",a_oview_extra(0,user,target))
						send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R begins a barrage by retracting [user.determineSex(1)] right arm...{x"] [target.defenseTips(src)]\n",target)
						src.defenses = list(PARRY_HIGH,DODGE_RIGHT,BARRIER)
					}
					if(KICK_LEFT){
						send("{B*{x {BYou begin a barrage by retracting your left leg...{x\n",user)
						send("{W*{x [user.raceColor(user.name)] begins a barrage by retracting [user.determineSex(1)] left leg...\n",a_oview_extra(0,user,target))
						send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R begins a barrage by retracting [user.determineSex(1)] left leg...{x"] [target.defenseTips(src)]\n",target)
						src.defenses = list(PARRY_LOW,DODGE_LEFT,BARRIER)
					}
					if(KICK_RIGHT){
						send("{B*{x {BYou begin a barrage by retracting your left leg...{x\n",user)
						send("{W*{x [user.raceColor(user.name)] begins a barrage by retracting [user.determineSex(1)] left leg...\n",a_oview_extra(0,user,target))
						send("{R*{x [target.defenseOnly ? "" : "[user.raceColor(user.name)]{R begins a barrage by retracting [user.determineSex(1)] left leg...{x"] [target.defenseTips(src)]\n",target)
						src.defenses = list(PARRY_LOW,DODGE_RIGHT,BARRIER)
					}
				}

				new /atkDatum/barrage(user,target,src,getAttackDelay(src, user.fCombat, target),attackType)
			}
			else{
				syntax(user, getSyntax())
			}
		}
