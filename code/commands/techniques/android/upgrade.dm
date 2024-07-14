var/list/android_skills = list("super hearing" = 5, "blast" = 1,"mask" = 10,"drain" = 8,"elbow" = 12,"eye laser" = 8,"hikou" = 6,"summon" = 6,"hammer"=8,"uppercut"=10,"zanzoken"=6,"throw"=6,"spin kick"=6,"rocketpunch"=11,"barrage"=8,"teleport"=12,"power blitz"=8)

proc
	upgradePrice(skill){
		return android_skills[skill];
	}

	buildUpgrade_menu(mob/Player/m){
		var
			list/upgrade_menu[] = list()

		upgrade_menu += "{Dpower{x ~ {G2 lab credits{x"

		if(m.form == "Normal"){ upgrade_menu += "{Dsuper android{x ~ {G30 lab credits{x"; }

		for(var/x in android_skills){
			if(!m.hasSkill(x)){
				upgrade_menu += "{D[x]{x ~ {G[android_skills[x]] lab credits{x"
			}
		}

		upgrade_menu += "{RExit{x"

		return upgrade_menu;
	}

Command/Technique
	upgrade
		name = "upgrade"
		internal_name = "upgrade"
		format = "~upgrade";
		syntax = list("upgrade #")
		priority = 2
		_maxDistance = 0;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Android's unique utility. Upgrade your body and OS to learn new skills and upgrade your system. This skill can only be used at Gero's Lab."

		command(mob/Player/user) {
			if(user.isGero()){
				upgrade:

				var
					options = buildUpgrade_menu(user)
					choice = rStrip_Escapes(input_menu("{yDr. Gero's{x {GLab{x \[Lab Credits: {C[user.labcredits]{x\]",options,"fancy",45,user))

				choice = copytext(choice,1,findtext(choice," ~"))

				if(choice == "Exit"){
					send("Upgrade system uninitialized.",user)
				}else if(choice == "power"){
					if(user.maxpl >= MAX_PL){
						send("You powerlevel is already at the maximum server allowed value.",user)
						goto upgrade:
					}
					else if(user.labcredits >= 2){
						user.gainPL(ret_percent(2.50,user.getMaxPL()),user,TRUE)
						user.labcredits -= 2
						goto upgrade:
					}else{
						send("You don't have enough lab credits!",user)
						goto upgrade:
					}
				}else if(choice == "super android"){
					if(user.labcredits >= 30){
						user.form = "Super Android";
						user.labcredits -= 30
						goto upgrade:
					}else{
						send("You don't have enough lab credits!",user)
						goto upgrade:
					}
				}else{
					if(user.labcredits >= upgradePrice(choice))
						if(user.canLearn(choice)){
							user:learnSkill(choice,TRUE)
							user.labcredits -= upgradePrice(choice)
							goto upgrade:
						}else{
							send("You already know {D[choice]{x!",user)
							goto upgrade:
						}
					else
						send("You don't have enough lab credits!",user)
						goto upgrade:
				}
			}else{
				send("You are not at gero's lab!",user)
			}
		}
