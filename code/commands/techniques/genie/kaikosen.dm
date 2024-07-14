Command/Technique
	kaikosen
		name = "kaikosen"
		internal_name = "kaikosen"
		format = "~kaikosen; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		helpCategory = "KI Attacks"
		helpDescription = "Genie's unique skill. Shot a bolt of electricity to your enemy from the antennae on your head."
		skillDatum = /fEAttk/kaikosen

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
				syntax(user,getSyntax());
				return
			}

			if(..(user,target,TRUE,name)){
				return;
			}

			send("{B* You flick your antennae and an electrical bolt arcs towards {x[target.raceColor(target.name)]{B...{x\n",user)
			send("{R* {x[user.raceColor(user.name)]{R flicks their antennae at you and an electrical bolt arcs towards you!...{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] flicks their antennae and sends an electrical bolt at [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))

			user._doEnergy(-8)

			user.kiAttk = new /fEAttk/kaikosen(user,target,src)
		}