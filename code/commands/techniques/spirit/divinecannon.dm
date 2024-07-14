Command/Technique
	divinecannon
		name = "divinecannon"
		internal_name = "divinecannon"
		format = "~divinecannon; ?num; ?~searc(mob@planet)";
		priority = 1;
		_maxDistance = 5;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DUCK, JUMP)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Fire a barrage of celestial cannon balls at your opponent with immense spiritual pressure."
		skillDatum = /fEAttk/divinecannon

		command(mob/user, amount, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}


			if(amount < 0 || amount > 4){

				syntax(user, getSyntax());
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || target && a_get_dist(user,target) < _minDistance || !target){
				syntax(user,getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}
			send("{B* You start forming celestial projectiles swirling around your hand and aim them at {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{R* [user.raceColor(user.name)] creates swirling celestial balls in [user.determineSex(1)] hand and points them at you!{x [target.defenseTips(src)]\n",target)
			send("{W* [user.raceColor(user.name)] creates swirling celestial spheres with immense pressure in [user.determineSex(1)] hand...\n{x",_ohearers(0,user))

			user.kiAttk = new /fEAttk/divinecannon(user,target,src,amount)
		}
