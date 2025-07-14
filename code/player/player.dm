mob
	Player
		Move(){
			..();

			if(totalWeight() > calcMaxWeight()){ _doEnergy(-1,NO_ENERGY=TRUE); }

			var/mob/NPA/m = locate(/mob/NPA) in a_oview(6,src);

			if(m && m.AGGRO){
				if(src.getMaxPL() >= m.getMaxPL()*4 || m.getMaxPL() >= src.getMaxPL()*4){ return; }

				m.aggroPlayer(src);
			}
		}

		proc/fixInventory(){
			for(var/atom/I in contents){
				if(!istype(I,/obj/item)){
					del I
				}
			}
		}

		proc/rebirthRace(){
			switch(race){
				if(LEGENDARY_SAIYAN){
					return TRUE;
				}
			}

			return FALSE;
		}

		proc/_changeName(_newName){
			var/rowCount = _rowCount("FROM `characters` WHERE `name`='[_newName]';");

			if(!rowCount){
				_query("UPDATE `characters` SET `name`='[_newName]' WHERE `name`='[name]';");
				_query("UPDATE `aliases` SET `owner`='[_newName]' WHERE `owner`='[name]';");
				_query("UPDATE `corpses` SET `name`='[_newName]' WHERE `name`='[name]';");
				_query("UPDATE `inventory` SET `owner`='[_newName]' WHERE `owner`='[name]';");
				_query("UPDATE `player_storage` SET `PLAYER`='[_newName]' WHERE `PLAYER`='[name]';");
				_query("UPDATE `quest_data` SET `owner`='[_newName]' WHERE `owner`='[name]';");
				_query("UPDATE `playerhouses` SET `owner`='[_newName]' WHERE `owner`='[name]';");
				_query("UPDATE `playerhouseupgrades` SET `owner`='[_newName]' WHERE `owner`='[name]';");

				name = _newName;

				return TRUE;
			}else{
				game.logger.error("SQL ERROR: Duplicate name found when trying to rename a player.")
			}

			return FALSE;
		}

		proc/_lsd(){
			set waitfor=FALSE;
			set background = TRUE;

			var/_duration = (world.time + 1 MINUTE);

			isLSD = TRUE;

			while(client){
				if(world.time >= _duration){
					break;
				}

				sleep(world.tick_lag);
			}

			send("You feel normal again...",src,TRUE);

			isLSD = FALSE;
		}

		proc/immTag(){
			switch(immLevel){
				if(1){
					return "{GHLP{x";
				}

				if(2){
					return "{CHLP{x";
				}

				if(3){
					return "{YGOD{x";
				}

				if(4){
					return "{RIMM{x";
				}

				if(5){
					return "{oDEV{x";
				}
			}

			return FALSE;
		}

		proc/disconnect(){
			properExit=TRUE;
			Logout();
		}

		proc/spawnHomeWorld(race){
			switch(race){
				if(LEGENDARY_SAIYAN){
					var/planet/area = get_area("vegeta");
					if(area){ warpArea(rand(1,area.dx),rand(1,area.dy),area); }
				}else{
					var/planet/area = get_area("earth");
					if(area){ warpArea(rand(1,area.dx),rand(1,area.dy),area); }
				}
			}
		}

		proc/checkAFK(){
			set waitfor=FALSE;
			set background = TRUE;

			var/_AFKTIME = 5 MINUTES;

			if(client){ client.lastCMD = world.time; }

			while(client){
				if(!isAFK && (world.time - client.lastCMD) >= _AFKTIME){
					isAFK = TRUE;
					send("You're now AFK.",src,TRUE);
				}
				sleep(world.tick_lag);
			}
		}

		proc/linkDead(){
			set waitfor=FALSE;
			set background = TRUE;

			var/_timeout = 2 MINUTES;

			while(!client){
				if((world.time - linkTime) >= _timeout){
					properExit=TRUE;
					Logout();
				}
				sleep(world.tick_lag);
			}
		}

		respawn(){
			var/planet/area = getArea();

			if(area.startX && area.startY){
				loc=locate(area.startX,area.startY,z)
			}else{
				warpArea(rand(1,area.dx),rand(1,area.dy),loc.loc)
			}
		}

		proc/plCheck(){
			if(currpl >= getMaxPL()){
				currpl = getMaxPL();
			}
		}

		canSense(mob/searcer=NULL){
			if(hasDB() || fCombat._hostiles() && unconscious){
				return TRUE;
			}

			if(!unconscious && currpl <= 5 || searcer && isplayer(searcer) && (locate(/Command/Technique/mask) in techniques)){
				return FALSE;
			}

			return TRUE;
		}

		proc/sendDeath(mob/killer, deathMsg) {
			send("{R*{x [src.raceColor(src.name)]{c is {x{CDEAD{x{c!{x",a_oview_extra(0,src,killer))
			send("{R*{x [src.raceColor(src.name)]{c is {x{CDEAD{x{c!{x",killer)
			send("{R*{x {cYou are{x {CDEAD{x{c!{x",src,TRUE)

			if (!deathMsg) {
				send("{Y-->{x [src.raceColor(src.name)] has been [pick("{MNULLIFIED{x","defeated","{Rslain{x","{rrekt{x","{Wpwned{x","{ydestroyed{x","{Gganked{x","{rfra{x{Rgged{x","{ymurked{x")] by [killer.raceColor(killer:name)]!",game.players,TRUE)
				return
			}

			send(deathMsg, game.players,TRUE)
		}

		death(var/mob/killer as mob, var/Command/tech, OR=FALSE, deathMsg = NULL){
			if(tech && tech.canFinish && src.currpl <= MIN_PL || OR){

				if(loc.loc:finishLocked && !OR){ return FALSE; }

				dropDragonballs();

				new /obj/item/corpse(src, killer)

				var/calc = ret_percent(killPlayerPercent,src.maxpl)
				var/calc2 = ret_percent(deathPlayerPercent,src.maxpl)

				sendDeath(killer, deathMsg)

				src.fCombat.removeHostile(killer)
				killer.fCombat.removeHostile(src)

				src.curreng = ret_percent(25,src.getMaxEN())
				src.currpl = ret_percent(15,src.getMaxPL())
				src.unconscious = FALSE;
				src.density = TRUE;
				src.resting = FALSE;
				src.sleeping = FALSE;
				src.insideBuilding = 0;

				emitDeath(src,ov_out(1,12,src));

				if(killer:activatedUI == TRUE){
					killer:activatedUI = FALSE;
				}

				if(istype(killer:loc.loc,/planet/arena)){
					var/planet/arena/a = killer:getArea();
					killer:arenaw++;
					src.arenal++;
					src.loc=locate(a.exitX,a.exitY,5);
					send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src);
				}else{
					if(isnpc(killer)){
						src.pved++
					}else{
						if(killer != src){
							game.addCooldown(src.name,"instantaneousmovement",45 SECONDS);
							game.addCooldown(src.name,"teleport",45 SECONDS);
							game.addPK(killer,src);
							src.pvpd++
							killer:pvpk++
						}
					}

					/* Respawn Checks */
					if(src.getArea() == get_area("hfil") || !qFac.isCompleted(src, "SQ006_PURIFICATION") && src.getArea() != get_area("king kai's planet") && isnpc(killer) && src.maxpl > 1000 && isnpc(killer) && src.maxpl < 20000 && src.alignment == EVIL){
						var/planet/area = get_area("hfil");
						warpArea(rand(1,area.dx),rand(1,area.dy),area)
						send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src);
						qFac.obtainQuest(src,"SQ006_PURIFICATION");
					}else if(src.getArea() == get_area("snakeway") || src.getArea() != get_area("king kai's planet") && isnpc(killer) && src.maxpl > 1000 && isnpc(killer) && src.maxpl < 20000 && src.alignment == GOOD){
						loc=locate(97,4,4); // spawn at the begining of snakeway
						send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src);
						qFac.obtainQuest(src,"SQ003_TRAVEL_SNAKEWAY");
					}else if(src.getArea() == get_area("snakeway") || src.getArea() != get_area("king kai's planet") && isnpc(killer) && src.maxpl > 20000 && isnpc(killer) && src.maxpl < 30000 && race == KAIO){
						loc=locate(97,4,4); // spawn at the begining of snakeway
						send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src);
						qFac.obtainQuest(src,"SQ003_TRAVEL_SNAKEWAY");
					}else if(src.getArea() == get_area("korin's tower")){
						var/planet/area = get_area("earth");
						warpArea(rand(1,area.dx),rand(1,area.dy),area)
						send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src);
					}else{
						respawn();
					}

					if(isplayer(killer) && (killer.race == ANDROID || killer.race == REMORT_ANDROID) && killer != src){
						killer:gainlc(pick(2,3),src)
					}

					if (killer != src) {
						killer:gainPL(calc,src)
					}

					if(src.getArea() != get_area("snakeway") && src.getArea() != get_area("hfil") && src.getArea() != get_area("king kai's planet")) { src.gainPL(-calc2,killer) }
				}

				return TRUE;
			}

			return FALSE;
		}

		proc/fixSkills(list/skills){
			for(var/i=1,i<skills.len + 1,i++){
				if(!(skills[i] in techniques)){
					techniques += skills[i]
				}
			}
		}

		proc/startingSkills(){
			var/list/startingSkills[] = list(/Command/Technique/fly,
									/Command/Technique/punch,
									/Command/Technique/roundhouse,
									/Command/Technique/sweep,
									/Command/Technique/parry,
									/Command/Technique/jump,
									/Command/Technique/duck,
									/Command/Technique/dodge,
									/Command/Technique/deflect,
									/Command/Technique/sense,
									/Command/Technique/power,
									/Command/Technique/snapneck)

			fixSkills(startingSkills);
		}

		cColor = 1
		display = "{C*{x"
		text = "<font color=#00ffff>*</font>"

		New(){
			..()
			game.mobiles += src;
			canReceiveItems = TRUE
			loc=locate(1,1,world.maxz)
		}

		Del(){
			game.mobiles -= src;
			game.players.Remove(src)
			..()
		}

		Login(){
			..()

			client.state = STATE_PLAYING

			new /outputBuffer(src);
			new /commandQueue(src);

			/*if(copyover){
				init()
				copyover=FALSE;
				send(" {Y({x{R*{x{Y){x  And before you know it, everything has changed  {Y({x{R*{x{Y){x ",src,TRUE);
			}
			else */

			if(linkTime > 0){
				send("You take over a body already in use.",src)
				send("[raceColor(name)] has {YRECONNECTED{x.",_ohearers(src,0))
				linkTime = 0
			}
			else{
				init()
				if(visible || !invisible) send("{Y-->{x [raceColor(name)] has entered [game.name]",game.players)
				send("Welcome to [game.name]!",src)
				send(readFile("motd"),src)
			}

			qFac.obtainQuest(src,"OG001_GLOBAL_TAKEOVER");
			qFac.obtainQuest(src,"Q001_BREAKING_IT_IN");
			qFac.obtainQuest(src,"SAIYANQ001_THE_LEGEND");
			qFac.obtainQuest(src,"G001_REACH_FOR_GODHOOD");
			qFac.obtainQuest(src,"AL001_AFTER_LIFE");
			qFac.obtainQuest(src,"AD001_AFTER_DEATH");
			qFac.obtainQuest(src,"S001_THE_LEGEND");
			qFac.obtainQuest(src,"LS_01");
			qFac.questCheck(src);
			qFac.completeCheck(src);

			if(client && client.address){
				game.logger.info("([client.address]) [name] entered the game.");
			}else{
				game.logger.info("[name] entered the game.");
			}

			checkAFK();
			fixInventory();
			spawn() if(z == 3){ loc=locate(5,5,1); } // if a user is stuck in space we port em to urf
		}

		Logout(){
			..()
			if(properExit){
				if(DBDatum_NAMEK.WISHING == src){ DBDatum_NAMEK.WISHING = FALSE; }
				if(DBDatum.WISHING == src){ DBDatum.WISHING = FALSE; }
				if(visible || !invisible) send("{Y-->{x [raceColor(name)] has exited [game.name]",game.players)
				dropDragonballs()
				saveSQLCharacter()
				game.logger.info("[name] exited the game.");
				del(src)
			}else{
				if(DBDatum_NAMEK.WISHING == src){ DBDatum_NAMEK.WISHING = FALSE; }
				if(DBDatum.WISHING == src){ DBDatum.WISHING = FALSE; }
				linkTime = world.time
				linkDead()
				game.logger.info("[name] went linkdead.");
				send("[raceColor(name)] went {RLINKDEAD{x.",_ohearers(src,0))
			}
		}

		gainPL(amount,mob/target,OR=FALSE){
			if(!canGain(target,OR,amount)){ return  FALSE; }

			if(amount > 0){ amount = (amount + ret_percent((calcBonusGain()),amount)) }
			maxpl = clamp(maxpl + amount, getMinPL(race), MAX_PL)
			lastPLGain = amount;

			if(target.client){ target.client.bust_prompt = TRUE; }
			qFac.checkPower(src);

			saveSQLCharacter();
		}

		gainPL_EVENT(amount,mob/target,OR=FALSE){
			if(!canGain(target,OR,amount)){ return  FALSE; }

			if(amount > 0){ amount = (amount) }
			maxpl = clamp(maxpl + amount, getMinPL(race), MAX_PL)
			lastPLGain = amount;

			if(target.client){ target.client.bust_prompt = TRUE; }
			qFac.checkPower(src);

			saveSQLCharacter();
		}

		gainPLGrav(amount,mob/target,OR=FALSE){
			if(!canGain(target,OR,amount)){ return  FALSE; }

			if(amount > 0){ amount = (amount + ret_percent((calcBonusGain(TRUE)),amount)) }
			maxpl = clamp(maxpl + amount, getMinPL(race), MAX_PL)
			lastPLGain = amount;

			if(target.client){ target.client.bust_prompt = TRUE; }
			qFac.checkPower(src);

			saveSQLCharacter();
		}


		learnSkill(skName,or=FALSE, nomsg=FALSE){
			if((race in list(ANDROID,REMORT_ANDROID)) && !or) return FALSE;

			if(!hasSkill(skName) && (game.skillList[skName] in skillSet()) || or){
				if(!nomsg){ send("{G*{x You learn {R[game.skillNames[skName]]{x!",src,TRUE); }
				techniques.Add(game.skillList[skName]);
				qFac.checkSkill(src);
				saveSQLCharacter();
				updateCommands = TRUE;
				return TRUE;
			}

			return FALSE;
		}

		proc
			retLastPL(){
				var/oldVal = lastPLGain;
				lastPLGain = 0;
				return oldVal;
			}

			retLastLC(){
				var/oldVal = lastLCGain;
				lastLCGain=0;
				return oldVal;
			}

			canGain(mob/victim, over_ride = FALSE, amount){
				if(over_ride){ return TRUE; }

				if(isSafe() || istype(victim, /mob/NPA/HOUSESYSTEM) || victim.isSafe() || isplayer(src) && isplayer(victim) && victim.getMaxPL() >= (getMaxPL() * 10) || maxpl > (victim.getMaxPL() * 6) && amount > 0 || victim.getMaxPL() > (getMaxPL() * 6) && amount < 0){ return FALSE; }

				return TRUE;
			}

			loadQuests(){
				var/rowCount = _rowCount("FROM `quest_data` WHERE `owner`='[name]';");

				if(rowCount){
					var/database/query/quests = _query("SELECT `quest`, `data` FROM `quest_data` WHERE `owner`='[name]';")
					var/list/rowData;

					while(quests.NextRow()){
						rowData = quests.GetRowData();
						var/list/params = params2list(rowData["data"]);

						// Convert params to numbers if needed.
						for(var/x in params){
							if(isnum(text2num(params[x]))){ params[x] = text2num(params[x]); }
						}

						questData += list("[rowData["quest"]]" = params);
					}

					return TRUE;
				}

				return FALSE;
			}

			update_ranking(){
				set waitfor = FALSE;

				var/rowCount = _rowCount("FROM `power_ranking` WHERE `name`='[rankColor(race,name)]'");

				if(rowCount > 0){
					_query("UPDATE `power_ranking` SET `powerlevel`='[maxpl]' WHERE `name`='[rankColor(race,name)]'");
				}else{
					_query("INSERT INTO `power_ranking` (`name`, `powerlevel`) VALUES ('[rankColor(race,name)]', '[maxpl]')");
				}
			}

			init(){
				startingSkills()
				regenStam()
				regenPL()
				checkEq()
				CheckForm()
				checkForItems()
				checkSk()
				growTail()
				game.players.Add(src)
			}

			parsePrompt(var/text as text){
				if(findtextEx(text,"$curreng")){
					text = replacetext(text,"$curreng","[percent_color_nop(curreng,curreng,getMaxEN())]");
				}

				if(findtextEx(text,"$maxeng")){
					text = replacetext(text,"$maxeng","[percent_color_nop(getMaxEN(),curreng,getMaxEN())]");
				}

				if(findtextEx(text,"$p_energy")){
					text = replacetext(text,"$p_energy",percent_color(curreng,getMaxEN()));
				}

				if(findtextEx(text,"$p_powerlevel")){
					text = replacetext(text,"$p_powerlevel",percent_color(currpl,getMaxPL()));
				}

				if(findtextEx(text,"$currpl_short")){
					text = replacetext(text,"$currpl_short",raceColor(short_num(currpl)));
				}else if(findtextEx(text,"$currpl")){
					if(shortNUM){
						text = replacetext(text,"$currpl",raceColor(short_num(currpl)));
					}else{
						text = replacetext(text,"$currpl",raceColor(commafy(currpl)));
					}
				}

				if(findtextEx(text,"$maxpl_short")){
					text = replacetext(text,"$maxpl_short",raceColor(short_num(getMaxPL())));
				}else if(findtextEx(text,"$maxpl")){
					if(shortNUM){
						text = replacetext(text,"$maxpl",raceColor(short_num(getMaxPL())));
					}else{
						text = replacetext(text,"$maxpl",raceColor(commafy(getMaxPL())));
					}
				}

				if(findtextEx(text,"$pl_bar")){
					//text = replacetext(text,"$pl_bar",meter(currpl,maxpl,raceColor("|"),"{D|{x","{r|{x"));
					//text = replacetext(text,"$pl_bar",meter(currpl,maxpl),raceColor("|"),"{D","{r");
					text = replacetext(text,"$pl_bar",meter(currpl,maxpl));
				}

				if(findtextEx(text,"$en_bar")){
					//text = replacetext(text,"$en_bar",meter(curreng,getMaxEN(),percent_color_text(curreng,getMaxEN(),"|"),"{D|{x","{r|{x"));
					text = replacetext(text,"$en_bar",newMeter(curreng,getMaxEN(),percent_color_noTex(curreng,getMaxEN()),"{D","{r"));
				}

				if(findtextEx(text,"$target_short")){
					text = replacetext(text,"$target_short",fCombat._getCustPromptTarget(TRUE));
				}else if(findtextEx(text,"$target")){
					text = replacetext(text,"$target",fCombat._getCustPromptTarget());
				}

				if(findtextEx(text,"$def_target_short")){
					text = replacetext(text,"$def_target_short",fCombat._getPromptTarget(TRUE));
				}else if(findtextEx(text,"$def_target")){
					text = replacetext(text,"$def_target",fCombat._getPromptTarget());
				}

				if(findtextEx(text,"$user")){
					text = replacetext(text,"$user",raceColor(name));
				}

				return text;
			}

			checkForItems(){
				var
					RowCount = _rowCount("FROM `corpses` WHERE `name`='[name]';")

				if(RowCount > 0){
					var
						database/query/q = _query("SELECT * FROM `corpses` WHERE `name`='[name]';")
						list/RowData

					while(q.NextRow()){
						RowData = q.GetRowData();
						var
							item = text2path(RowData["item"]);
							obj/item/i = new item;

						send("You obtain [i.PREFIX][i.DISPLAY]!",src,TRUE);
						addInv(i);

						_query("DELETE FROM `corpses` WHERE `CID`='[text2num(RowData["CID"])]';")
					}
				}
			}

			forgetSkill(skName, nomsg=FALSE){
				if(hasSkill(skName) && (game.skillList[skName] in skillSet())){
					if(!nomsg){ send("{G*{x You forget {R[game.skillNames[skName]]{x!",src,TRUE); }
					techniques.Remove(game.skillList[skName]);
					saveSQLCharacter();
					return TRUE;
				}

				return FALSE;
			}

			checkSkill(mob/m,FORMAT=FALSE){
				if((race in list(ANDROID,REMORT_ANDROID))) return NULL;

				if(isnpc(m)){

					for(var/C in m:teach){
						if((game.skillList[C] in skillSet()) && !hasSkill(C)){
							if(FORMAT){
								return "{Y<al2>*</a>{x"
							}else{
								return "{Y*{x "
							}
						}
					}

					for(var/C in m:teachShow) {
						if((game.skillList[C] in skillSet()) && !hasSkill(C)){
							if(FORMAT){
								return "{C<al2>*</a>{x"
							}else{
								return "{C*{x "
							}
						}
					}
				}

				return NULL;
			}

			checkSk(){
				for(var/x in techniques){
					if(!(x in skillSet())){
						techniques.Remove(x);
					}
				}
			}

			checkEq(){
				for(var/x=1,x!=equipment.len,x++){
					var/obj/item/i = equipment[x];

					if(i && i.SLOT == FINGERS){ continue; }

					if(i && i.SLOT != x){
						equipment[x] = NULL;
						addInv(i)
					}
				}
			}

			regenStam(){
				set waitfor = FALSE;

				var
					refreshTime=(world.time + 65);

				regenStam = TRUE;

				while(src && curreng < getMaxEN()){
					if(world.time >= refreshTime){
						if(!unconscious) energyMessage()
						_doEnergy(1)
						refreshTime=(world.time + 65);
					}
					sleep(world.tick_lag)
				}

				regenStam = FALSE;
			}

			regenPL(){
				set waitfor = FALSE;

				var
					regenPercent = NORMAL_REGEN_PERCENT;
					frequency = NORMAL_REGEN_FREQUENCY;
					regenType = techniques.Find(/Command/Technique/namek_regeneration) ? "namek" : techniques.Find(/Command/Technique/genie_regeneration) ? "genie" : "none";

				switch(regenType){
					if("namek"){
						regenPercent = NORMAL_REGEN_PERCENT;
						frequency = NORMAL_REGEN_FREQUENCY;
					}

					if("genie"){
						regenPercent = GENIE_REGEN_PERCENT;
						frequency = GENIE_REGEN_FREQUENCY;
					}
				}

				if(regenType != "none"){
					var
						refreshTime=(world.time + frequency);

					regenPL = TRUE;

					while(src && currpl < getMaxPL() && regenPL){
						if(world.time >= refreshTime){
							_doDamage(cround(ret_percent(regenPercent,getMaxPL())))
							refreshTime=(world.time + frequency);
						}
						sleep(world.tick_lag)
					}
				}

				regenPL = FALSE;
			}
