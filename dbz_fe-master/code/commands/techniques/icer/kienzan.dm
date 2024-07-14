Command/Technique
	kienzan
		name = "kienzan"
		internal_name = "kienzan"
		format = "~kienzan; ?num; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 0;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Create two discs of energy that will fly and slice through your opponent."
		skillDatum = /fEAttk/kienzan

		command(mob/user, amount=2, mob/target=user:fCombat._getLastTarget()) {

			if(!target && user.kiAttk || user.kiAttk && user.kiAttk:name != name){
				send("You are already charging a [uppertext(copytext(user.kiAttk:name,1,2)) + copytext(user.kiAttk:name, 2)]!",user)
				return;
			}

			if(user.kiAttk && user.kiAttk:Conc){
				send("You are already firing an attack!",user)
				return
			}

			if(target && a_get_dist(user,target) > _maxDistance || target && a_get_dist(user,target) < _minDistance || !target || amount > 2 || amount < 2){
				syntax(user, getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}
			send("{B* You form two {x{Menergy{x {Bdiscs in your hands and face {x[target.raceColor(target.name)]{B...\n{x",user)
			send("{W*{x [user.raceColor(user.name)] forms {x{Menergy{x{B in [user.determineSex(1)] hands and locks on to [target.raceColor(target.name)]...\n",_ohearers(0,user))

			user.kiAttk = new /fEAttk/kienzan(user,target,src,amount)
		}