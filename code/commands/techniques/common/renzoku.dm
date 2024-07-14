Command/Technique
	renzoku
		name = "renzoku"
		internal_name = "renzoku"
		format = "~renzoku; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT,ABSORB,DEFLECT,BARRIER)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Release a barrage of continuous energy blasts against your foe."
		skillDatum = /fEAttk/renzoku
		canChangeBarrage = FALSE

		command(mob/user, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || !target){
				syntax(user, getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}

			send("{B* You extend your hand out and aim at {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{W*{x [user.raceColor(user.name)] extends [user.determineSex(1)] hands out and aims at [target.raceColor(target.name)]...\n",_ohearers(0,user))

			user.kiAttk = new /fEAttk/renzoku(user,target,src)
		}