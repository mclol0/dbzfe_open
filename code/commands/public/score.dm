Command/Public
	score
		name = "score"
		format = "~score;";
		canAlwaysUSE = TRUE
		canUseWhileRESTING = TRUE;
		priority = 3
		helpDescription = "Display detailed information about your character."
		cancelsPushups = FALSE;

		command(mob/user) {
			var/buffer[] = list();
			buffer += "\n{Y [uppertext(user.name)]'S PROFILE{x\n"
			buffer += "<al2></a><al12>Race:</a> <al41>[user.raceColor(determineRace(user.race))]</a>\n"
			buffer += "<al2></a><al12>Form:</a> <al41>[gForm.getColor(user.form,user.form)]</a>\n"
			buffer += "<al2></a><al12>Style:</a> <al37>[user.getStyle()]</a>\n"
			buffer += "<al2></a><al12>Gender:</a> <al37>[determineGender(user.sex)]</a>\n"
			buffer += "<al2></a><al12>Alignment:</a> <al37>[determineAlignment(user.alignment)]</a>\n"
			if(user.shortNUM){
				buffer += "<al2></a><al12>Powerlevel:</a> <al43>[user.raceColor(short_num(user.getMaxPL()))]</a>\n"
			}else{
				buffer += "<al2></a><al12>Powerlevel:</a> <al43>[user.raceColor(commafy(user.getMaxPL()))]</a>\n"
			}
			buffer += "<al2></a><al12>Fly Speed:</a> <al37>[user.calcFlySpeed()] ({G[user.calcFlightBonus()]%{x FASTER FLYTO)</a>\n"
			buffer += "<al2></a><al12>Energy:</a> <al43>{C[user.curreng]{x/{C[user.getMaxEN()]{x ([percent_color(user.curreng,user.getMaxEN())])</a>\n"
			buffer += "<al2></a><al12>PvP:</a> <al43>{R[commafy(user.pvpk)]K{x/{r[commafy(user.pvpd)]D{x</a>\n"
			buffer += "<al2></a><al12>PvE:</a> <al43>{M[commafy(user.pvek)]K{x/{m[commafy(user.pved)]D{x</a>\n"
			buffer += "<al2></a><al12>Arena:</a> <al43>{G[commafy(user.arenaw)]W{x/{g[commafy(user.arenal)]L{x</a>\n"
			buffer += "<al2></a><al12>Zenni:</a> <al43>{G[commafy(user.zenni)]{x</a>\n"
			buffer += "<al2></a><al12>Weight:</a> <al43>{G[user.totalWeight()]{x/{G[user.calcMaxWeight()] kgs.{x</a>\n"
			if((user.race in list(SAIYAN,LEGENDARY_SAIYAN,ICER,HALFBREED))){buffer += "<al2></a><al12>Tail:</a> <al43>[user.hasTail ? "{GPresent{x" : "{RSevered{x"]</a>\n";}
			if(isAndroid(user)){
				buffer += "<al2></a><al12>Lab Credits:</a> <al43>[ncheck(user.labcredits,7)]</a>\n"
				buffer += "<al2></a><al12>Gero's Lab :</a> <al43>25.-33</a>\n"
			}
			buffer += "{Y [uppertext(user.name)]'S STATS{x\n"
			buffer += "<al2></a><al12>Stamina:</a> <al37>[commafy(user.totalSta())] ([pcheck(ret_percent(user.calcBonusEnergy(),user.maxeng))])</a>\n"
			buffer += "<al2></a><al12>Ki:</a> <al50>[commafy(user.totalKi())] ([ncheck(user.calcBonusPL(),999,user,TRUE)])</a>\n"
			buffer += "<al2></a><al12>Gain Mod:</a> <al50>[pcheck(user.calcBonusGain())]</a>\n"
			buffer += "<al2></a><al12>Strength:</a> <al37>[commafy(user.totalStr())] ([pcheck(user.calcBonusDamage())])</a>\n"
			buffer += "<al2></a><al12>Armor:</a> <al37>[commafy(user.totalArmor())] ([pcheck(user.calcBonusDefense())])</a>\n"
			buffer += "<al2></a><al12>Magic Find:</a> <al37>[commafy(user.totalMF())] ([pcheck(user.calcBonusMF())])</a>\n"
			buffer += "{Y [uppertext(user.name)]'S VISUAL APPEARANCE{x\n"
			buffer += "<al2></a><al12>Hair Length:</a> <al37>[user.visuals["hair_length"]]</a>\n"
			buffer += "<al2></a><al12>Hair Color:</a> <al37>[user.visuals["hair_color"]]</a>\n"
			buffer += "<al2></a><al12>Hair Style:</a> <al37>[user.visuals["hair_style"]]</a>\n"
			buffer += "<al2></a><al12>Eye Color:</a> <al37>[user.visuals["eye_color"]]</a>\n"
			buffer += "<al2></a><al12>Height:</a> <al37>[user.visuals["height"]]</a>\n"
			buffer += "<al2></a><al12>Build:</a> <al37>[user.visuals["build"]]</a>\n"
			buffer += "<al2></a><al12>Skin Color:</a> <al37>[user.visuals["skin_color"]]</a>\n"

			send(implodetext(formatList(buffer),""),user,TRUE)
		}
