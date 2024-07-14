Command/Technique
	eye_laser
		name = "eyelaser"
		internal_name = "eye laser"
		format = "~eyelaser; ?~searc(mob@planet)";
		syntax = list("mobile")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 4;
		tType = ENERGY;
		defenses = list(DODGE_LEFT,DODGE_RIGHT)
		canFinish = TRUE;
		skillDatum = /fEAttk/eye_laser
		helpCategory = "KI Attacks"
		helpDescription = "A piercing energy attack fired from the eyes.\n\n{YNote:{x {CAt 4+ range, this attack is incredibly fast.{x"

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

			send("{B* You glare at {x[target.raceColor(target.name)]{B...{x\n",user)
			send("{R* {x[user.raceColor(user.name)]{R glares at you...{x [target.defenseTips(src)]\n",target)
			send("{W*{x [user.raceColor(user.name)] glares at [target.raceColor(target.name)]...\n",a_oview_extra(0,user,target))

			user._doEnergy(-6)

			user.kiAttk = new /fEAttk/eye_laser(user,target,src)
		}