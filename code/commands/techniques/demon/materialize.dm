proc
	fixDemonSkills(mob/Player/M){
		M.forgetSkill("lure",TRUE);
		M.forgetSkill("stab",TRUE);
		M.forgetSkill("slash",TRUE);

		switch(M.demonWeapon){
			if(DEMON_SWORD){
				M.learnSkill("stab",FALSE,TRUE);
				M.learnSkill("slash",FALSE,TRUE);
			}

			if(DEMON_WHIP){
				M.learnSkill("lure",FALSE,TRUE);
			}
		}
	}

Command/Technique
	materialize
		name = "materialize"
		internal_name = "materialize"
		format = "~materialize; word;";
		syntax = list("sword | whip | shield")
		priority = 1;
		_maxDistance = 8;
		_minDistance = 0;
		tType = UTILITY;
		helpCategory = "Utility"
		helpDescription = "Demon's unique skill. Materialize specific equipment to use in combat."
		skillDatum = /atkDatum/utility/materialize

		command(mob/user, choice) {
			if(TextMatch(choice, "sword", 1, 1)){
				user.demonWeapon = DEMON_SWORD;
				fixDemonSkills(user);
				send("{B* You materialize a {x{RDemonic Sword{x{B!{x",user)
				send("{W*{x [user.raceColor(user.name)] materializes a {RDemonic Sword{x!\n",_ohearers(0,user))
			}else if(TextMatch(choice,"whip",1,1)){
				user.demonWeapon = DEMON_WHIP;
				fixDemonSkills(user);
				send("{B* You materialize a {x{RDemonic Whip{x{B!{x",user)
				send("{W*{x [user.raceColor(user.name)] materializes a {RDemonic Whip{x!\n",_ohearers(0,user))
			}else if(TextMatch(choice,"shield",1,1)){
				user.demonWeapon = DEMON_SHIELD;
				fixDemonSkills(user);
				send("{B* You materialize a {x{RDemonic Shield{x{B!{x",user)
				send("{W*{x [user.raceColor(user.name)] materializes a {RDemonic Shield{x!\n",_ohearers(0,user))
			}else{
				syntax(user, getSyntax())
			}
		}