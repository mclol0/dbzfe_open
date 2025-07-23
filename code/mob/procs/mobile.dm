mob
	icon='rsc/mob.dmi'

	var
		race = NULL; // Our race.
		form = "Normal"; // Our current state.
		sex = NULL; // Our gender.
		alignment = NULL; // Alignment (Good or bad?)
		currpl = 0; // Current amount of powerlevel.
		maxpl = 0; // Maximum amount of powerlevel.
		curreng = 0; // Current amount of energy.
		maxeng = 0; // Maximum amount of energy.
		techniques[] = list(); // What techniques has a player learned.
		visuals[] = list(); // What our visuals are.
		channels[] = list("OOC","SCOUTER","TIPS"); // What channels are we using
		zenni = 0; // Zenni holder variable :O
		questData[] = list(); // Our quest data
		equipment[30]; // Equipment contents
		compression = 1; // Default compression level 1 (Show randomize turfs)
		labcredits = 0; // Upgrade points for androids.
		pvpk = 0; // Total pvp kills.
		pvpd = 0; // Total pvp deaths.
		pvek = 0; // Total pve kills.
		pved = 0; // Total pve deaths.
		arenaw = 0; // Total arena wins.
		arenal = 0; // Total arena losses.
		prompt = "<$p_energy> / <$currpl/$maxpl> $def_target" // Default prompt.
		simultaneous = FALSE; // Are we in simultaneous combat or normal.
		hasTail = FALSE; // Do we have a tail?
		showDefense = TRUE; // Do we want to see defense tips?
		frozen = FALSE; // Are we frozen or not?
		shortNUM = FALSE; // Do we have short numbers enabled?
		demonWeapon = NULL;
		insideBuilding = FALSE; // Is the mob inside a non instanced building (house)
		isImm = FALSE; //Is this mob an immortal. Prevents querying the DB as much
		insideMedPod = FALSE // Are we inside a medpod
		lastTell = NULL // Last person we send a tell to. Used for reply
		canReceiveItems = FALSE
		list/skillExp = list()
		sensePL = FALSE
		sensePLMode = "number"

		/* NEW Bonus Stats */
		bonus_ki = 0; // Ki aka powerlevel mod
		bonus_str = 0; // Strength aka damage mod
		bonus_sta = 0; // Stamina aka energy mod
		bonus_arm = 0; // Armor aka defense mod
		bonus_mf = 0; // Magic find aka drop mod
		bonus_tena = 0; // Tenacity this stat will reduce stun time

		//We will be converting our gain mod determined by the weight of items.
		/* END NEW Bonus Stats */

		copyover = FALSE;
		immLevel = 0;
		disableMap = FALSE;
		defenseOnly = FALSE;

		tmp
			in_npc_menu = FALSE;

			lastPLGain = 0;
			lastLCGain = 0;

			aliasList[] = list(); // Temporary holder for our alias list.

			locked = FALSE; // Are our commands locked?

			flightSPEED = 5; // Default flight speed.

			last_seen = NULL; // Last time we saw player

			//tutorial = FALSE;

			/*
				Some new variables for the new skills
			*/
			blind = FALSE;
			shyouken = FALSE;
			barrier = FALSE;

			/* Account Variables */
			email = "" // Temporary email holder.
			password = "" // Temporary password holder
			/* End Account Variables */

			/* Pointer References */
			fCombat/fCombat = NULL; // Pointer to our combat system.
			snooper = NULL; // A pointer to whoever is snooping the player.
			snooping = NULL; // Is the player snooping someone.
			flying = NULL; // Is the player flying TO a mobile (not is he flying we used density for that)
			atkDatum/atkDat = NULL; // Pointer to attack datum.
			fEAttk/kiAttk = NULL; // Pointer to ki attack.
			lFlyT = NULL; // Last flight target.
			traveling = NULL; // What planet are we traveling to?
			senseEnergy/senseDat = NULL; // A pointer to our sensing datum.
			spacePod = NULL; // A point to our spacepod in the world.
			outputBuffer/output = NULL; // A pointer to our outputBuffer datum.
			commandQueue/command = NULL;
			/* End Pointer References */

			linkTime = 0; // When did we go link dead (world.time)
			unconscious = FALSE; // Are we unconscious or not.
			sleeping = FALSE; // Are we sleeping our not.
			resting = FALSE; // Are we resting or not.
			aID = 0; // action ID for attacks etc.
			stunned = FALSE; // Is the player stunned.
			stunTime = NULL; // Temporary variable to hold stun time
			powering = FALSE; // Is the character powering up or not.
			canSave = TRUE; // Can the character save or not.
			iting=FALSE; // Is using instant transmission.
			iming=FALSE; // Is using instantaneous movement
			regenStam = FALSE; // Are we regenerating stamina right now?
			regenPL = FALSE; // Are we regenerating powerlevel right now?
			flyID = 0; // Keep track of our flight ID.
			properExit = FALSE; // Did we exit the game properly?
			grabbers[] = list(); // Who is grabbing us those cheeky basturds.
			bursting = FALSE; // Are we bursting right now?
			isAFK = FALSE; // Are we AFK or NO?
			activatedUI = FALSE; // Have we activated UI in this fight?
			isLSD = FALSE;
			doingPushups = FALSE;
			suffocating = FALSE;
			underGravity = FALSE; // Is the mob in a room with gravity > 15?
			isOverweight = FALSE; // Is the mob carrying more than it's max weight?
			commandList[] = list();
			updateCommands = TRUE;

	proc
		updateCommands(){
			commandList = list();

			for(var/Command/Public/x){
				commandList += list("[x.type]" = x);
			}

			for(var/Command/Technique/x){
				if(techniques.Find(x.type)){
					commandList += list("[x.type]" = x);
				}
			}

			if(isplayer(src) && isImm){
				for(var/Command/Wiz/x){
					if(immLevel >= x.immReq){
						commandList += list("[x.type]" = x);
					}
				}
			}
		}

		transformOozaru(){
			if((race in list(SAIYAN,LEGENDARY_SAIYAN,HALFBREED)) && !unconscious && !sleeping && hasTail && form == "Normal"){
				var/c = percent(currpl,getMaxPL())
				form = "Oozaru"
				currpl = clamp(ret_percent(c,getMaxPL()), 5, getMaxPL())
				send("{RStaring up at the sky, you transform into a giant oozaru!{x",src);
				send("{W*{x {RStaring up into the sky, {x[raceColor(name)]{x{R transforms into a giant oozaru!{x",_ohearers(0,src))

				if(visuals["hair_style"] != "Bald"){
					visuals["hair_color"] = "{yBrown{x"
				} else {
					visuals["hair_style"] = "Short"
					visuals["hair_color"] = "{yBrown{x"
				}

				visuals["height"] = "Giant"
				visuals["build"] = "Muscular"
				visuals["eye_color"] = "{RRed{x"
				_doEnergy(-10)
				CheckForm()
				mOuter("a sudden surge of energy",src,ov_out(1,12,src));
			}
		}

		_underGravityDamageThreshold(gravity) {
			var/minDamage = 2
			var/maxDamage = 8

			var/damage = (gravity * maxDamage) / 100
			damage -= gForm.getGravityResistance(form)
			damage = clamp(damage, minDamage, maxDamage)

			return ret_percent(damage, src.maxpl)
		}

		_underGravity() {
			set waitfor = FALSE;
			set background = TRUE

			if (!isplayer(src) || underGravity) return;

			var/tick = 0

			underGravity = TRUE

			while(src && loc && istype(loc, houseSystem.TURFS[houseSystem.TRAINING]) && underGravity) {
				if (getGravity() <= 15) {
					underGravity = FALSE
					break
				}

				if (src && src.unconscious && getGravity() > 15) {
					underGravity = FALSE
					currpl = MIN_PL
					var/deathMsg = "{Y-->{x [raceColor(name)] has been {RCRUSHED{x under gravity!";
					death(src, NULL, TRUE, deathMsg)
					return
				}

				tick++;

				if(tick >= 100) {
					tick = 0
					send("You feel your body giving up to the gravity of the room.", src)
				}

				// Keep this a round number so that we send messages in a consistent way
				if (tick % 10 == 0) {
					var/gravDamage = _underGravityDamageThreshold(getGravity())
					_doDamage(-gravDamage)
				}

				sleep(world.tick_lag);
			}

			send("You relax as you stop fighting against the gravity pull.", src)
			underGravity = FALSE
		}

		_suffocate(){
			set waitfor = FALSE;
			set background = TRUE;

			var/obj/item/i = equipment[BODY];

			if(!isplayer(src) || suffocating || i && (i.type in list(/obj/item/BASIC_SPACESUIT)) || isplayer(src) && src:spacePod && (src in src:spacePod:passengers) || houseSystem.getOxygenGeneratorByInstance(insideBuilding) || (race in list(ICER,ANDROID,REMORT_ANDROID, BIO_ANDROID,GENIE, SPIRIT))){ return; }

			var/suffocateTime = (world.time + 60 SECONDS);
			var/tick = 0;

			send("{RDanger!{x {YThis planet has no atmosphere get to a source of oxygen fast before you suffocate!{x",src,TRUE);

			suffocating = TRUE;

			while(src && loc && loc.loc && !loc.loc:atmosphere && suffocating){
				i = equipment[BODY];

				if(world.time >= suffocateTime){
					currpl = MIN_PL
					death(src,NULL,TRUE, "{Y-->{x [raceColor(name)] has {Rsuffocated{x!")
					break;
				}

				if(i && (i.type in list(/obj/item/BASIC_SPACESUIT)) || isplayer(src) && src:spacePod && (src in src:spacePod:passengers) || houseSystem.getOxygenGeneratorByInstance(insideBuilding)){
					suffocating = FALSE;
				}

				tick++;

				if(tick >= 50){
					tick = 0;
					send("You gasp for air!",src);
					send("[raceColor(name)] gasps for air!",_ohearers(0,src));
					_doEnergy(-15);
				}

				sleep(world.tick_lag);
			}

			send("You catch your breath and stop suffocating.",src,TRUE);

			suffocating = FALSE;
		}

		bleedDamage(var/mob/attacker, var/time=6 SECONDS){
			set waitfor=FALSE;
			set background = TRUE;

			var/endTime = (world.time + time);

			while(attacker && src){
				_doEnergy(2);
				attacker.fCombat.doDamage(src,1,2,"bleed damage",NULL)

				if(world.time >= endTime){ break; }

				sleep(1.5 SECONDS);
			}
		}

		growTail(){
			set waitfor=FALSE;
			set background = TRUE;

			var/growTime = (world.time + 15 MINUTES);

			if(!hasTail && (race in list(SAIYAN,LEGENDARY_SAIYAN,HALFBREED))){
				while(src){
					if(world.time >= growTime){
						hasTail = TRUE;
						send("Your tail has grown {Gback{x!",src,TRUE);
						send("[raceColor(name)]'s tail has grown {Gback{x!",_ohearers(0,src));
						break;
					}

					sleep(world.tick_lag);
				}

				return TRUE;
			}

			return FALSE;
		}

		gravityThreshold(){
			switch(getGravity()){
				if(1){
					return 50;
				}

				if(2){
					return 100;
				}

				if(3){
					return 800;
				}

				if(4){
					return 1600;
				}

				if(5){
					return 3200;
				}

				if(6){
					return 4200;
				}

				if(7){
					return 5200;
				}

				if(8){
					return 6200;
				}

				if(9){
					return 7200;
				}

				if(10){
					return 10000;
				}
			}

			return 0;
		}

		pushupGainTier(var/maxPL){
			var/calcPowerGain = (1 * (length(commafy(maxPL))*1.2)) + (round(maxPL * (rand(4,6) * 0.000028)));
			var/currentGravity = src.getGravity();

			var/getPowerGain = calcPowerGain * ((currentGravity * 0.18)+1); // Reduce Effectieness of gravity
			if(getPowerGain < 0) { getPowerGain = round(rand(10,50) + (maxPL * 0.05)); }
			if(getPowerGain > (maxPL * 0.04)) {
				getPowerGain = round(maxPL * 0.04);
			}
			return round(getPowerGain);
		}

		pushups(var/amount){
			set waitfor = FALSE;
			set background = TRUE;

			var
				count = 0;
				goTime = (world.time + 1.6 SECONDS);
				pushupMeter = 0;
				gravity = src.getGravity();

			doingPushups = TRUE;

			while(src && doingPushups && count != amount && !unconscious && !sleeping && !resting){
				if(world.time >= goTime){
					alaparser.parse(src,"emo does a pushup.",list());
					alaparser.parse(src,"say [++count]",list());

					pushupMeter += rand(10,11);

					if(pushupMeter >= 100 || count == 100){
						gainPLGrav(pushupGainTier(maxpl),src,TRUE);
						pushupMeter -= 100;
					}

					_doEnergy(-3 - round( gravity * 0.115),FALSE,TRUE);

					goTime = (world.time + 1.6 SECONDS);
				}

				sleep(world.tick_lag);
			}

			alaparser.parse(src,"emo stops doing pushups.",list());
		}

		severeTail(var/damage){
			if(istype(src.loc.loc,/planet/arena)){ return FALSE; }

			if(hasTail && (race in list(SAIYAN,LEGENDARY_SAIYAN,HALFBREED))){
				if(damage >= 0.35*currpl){
					send("Your tail has been {RSEVERED{x!",src,TRUE);
					send("[raceColor(name)]'s tail has been {RSEVERED{x!",_ohearers(0,src));
					hasTail = FALSE;
					growTail();
					return TRUE;
				}
			}

			return FALSE;
		}

		getGravity(){
			if(loc && loc.loc){
				return loc:gravity && src:insideBuilding ? loc:gravity : loc.loc:gravity;
			}

			return 1;
		}

		cancelKi(){
			set waitfor=FALSE;

			if(src && isConcBreak()){
				kiAttk.Conc=FALSE;
				kiAttk.isCharging=FALSE;
				sleep(1 TICK);
				if(src && kiAttk)
					send("Your [kiAttk:name] dissipates!",src);
					kiAttk.clean();
			}
		}

		hasSkill(skillName=NULL){
			if(length(skillName) > 0 && (game.skillList[skillName] in techniques)){
				return TRUE;
			}

			return FALSE;
		}

		canSense(){
			return TRUE;
		}

		areaPlayers(){
			var
				list/mobiles = list();
				planet/area = getArea();

			for(var/mob/Player/m in area.contents){
				mobiles.Add(m);
			}

			return mobiles;
		}

		dropDragonballs(){
			for(var/obj/item/DRAGONBALLS/o in contents){
				dropItem(o);
				send("You drop [o.PREFIX][o.DISPLAY].",src);
				send("[raceColor(name)] drops [o.PREFIX][o.DISPLAY].",_ohearers(0,src));
			}

			for(var/obj/item/NAMEK_DRAGONBALLS/o in contents){
				dropItem(o);
				send("You drop [o.PREFIX][o.DISPLAY].",src);
				send("[raceColor(name)] drops [o.PREFIX][o.DISPLAY].",_ohearers(0,src));
			}
		}

		canPickupNamekBall(){
			var/Count = 0;

			for(var/obj/item/NAMEK_DRAGONBALLS/o in contents){ Count++; }

			if(Count >= 3){
				return FALSE;
			}

			return TRUE;
		}

		hasDB(){
			for(var/obj/item/DRAGONBALLS/o in contents){
				return TRUE;
			}

			for(var/obj/item/NAMEK_DRAGONBALLS/o in contents){
				return TRUE;
			}

			return FALSE;
		}

		isLevel(mob/target){ // To check if we are both on the same plane aka both on ground or both in air to return true or false
			if(src.density && !target.density){
				send("They're in the air you dope!",src);
				return TRUE;
			}else if(!src.density && target.density){
				send("They're on the ground you dope!",src);
				return TRUE;
			}else{ return FALSE; }
		}

		event(var/mob/killer, var/Command/Technique/tech)
		event_say(var/mob/user, var/text)
		event_entered(var/mob/user)

		death(var/mob/killer as mob, var/Command/tech)

		respawn()

		getStyle(){
			switch(simultaneous){
				if(TRUE){
					return "{YSimultaneous{x";
				}

				if(FALSE){
					return "{cSingle{x";
				}
			}
		}

		shyouken(time=(world.time + 30)){
			set waitfor = FALSE;
			set background = TRUE;

			shyouken = TRUE;

			while(world.time < time && shyouken){ sleep(world.tick_lag); }

			send("{B*{x {WYou stop glowing white...{x",src);
			send("{W*{x [raceColor(name)] {Wstops glowing white...{x",_ohearers(0,src))

			shyouken = FALSE;
		}

		skillSet()

		checkLocked(DEF = FALSE){ // Check if our commands are locked (queued).
			if(locked){ return TRUE; }

			if(atkDat && atkDat:locked){
				if(DEF && atkDat:defense){
					return FALSE;
				}
				return TRUE;
			}

			return FALSE;
		}

		chkDef(type){ // Check our defense type and if it has failed or not.
			if(atkDat){
				if(atkDat:type != type || !atkDat:defense){ return FALSE; }
			}else{
				return FALSE;
			}

			return TRUE;
		}

		warpArea(x,y,planet/A){

			if(!isplanet(A)) { A = locate(A); } // Find the area we were asked to locate to.

			if(isplanet(A)){
				if(x > A.getDX() || x < 1 || y > A.getDY() || y < 1){ // Check our area's boundaries to see if its a valid warp.
					game.logger.error("ERROR: Invalid coordinates for area!")
					return FALSE;
				}

				loc=locate(((x - 1) + A.x),((y - 1) + A.y),A.z); // Take our areas minimum coordinates an add to which room we wish to warp to.
			}else{
				game.logger.error("ERROR: Invalid planet.");
				return FALSE;
			}

			return TRUE;
		}

		changeTurf(type,range){
			for(var/turf/T in t_oview(range,src))
				T.Change(type)
		}

		_doEnergy(amount, isKi=FALSE, NO_ENERGY=FALSE){

			//if((locate(/obj/item/SAPPHIRE_GRAVITY_RING) in equipment)) { --amount } // if wearing saphire ring require more energy usage / less energy

			if(isplayer(src) && isImm){ return FALSE; }

			if(isKi && locate(/Command/Technique/onslaught) in techniques){ --amount; }

			if(isplayer(src) && !NO_ENERGY && amount < 0){ amount = (amount - calcExtraStam()); }

			curreng = clamp(curreng + amount, MIN_ENERGY, getMaxEN())

			if(curreng < getMaxEN() && !regenStam){ src:regenStam() }

			if(curreng <= MIN_ENERGY && !unconscious){
				send("Everything goes dark as you lose consciousness!",src)
				var/msg = istype(src, /mob/NPA/HOUSESYSTEM/TrainingBot) ? MSG_BOT_BEATEN : MSG_LOSE_CONSCIOUSNESS
				loseConsciousness(msg)
			}

			return TRUE;
		}

		loseConsciousness(msgId) {
			if(!density){alaparser.parse(src, "fly")}

			switch(msgId) {
				if (MSG_LOSE_CONSCIOUSNESS)
					send("{W*{x [raceColor(name)] has lost consciousness!",_ohearers(0,src))
				if (MSG_KNOCKED_OUT)
					send("{W*{x [raceColor(name)] has been knocked out!",_ohearers(0,src))
				if (MSG_BOT_BEATEN)
					send("{W*{x [raceColor(name)] returns to his charging station and powers down.",_ohearers(0,src))
					if (src:trainingConsole) {
						src:trainingConsole:_stop()
						return
					}
			}

			curreng = 5
			currpl = MIN_PL
			density = TRUE;
			unconscious = TRUE
			stunned = FALSE
			powering = FALSE
			regenPL = FALSE
			activatedUI = FALSE
			regainConscious()
		}

		restore() {
			stunned = FALSE;
			unconscious = FALSE;
			currpl = getMaxPL();
			curreng = getMaxEN();
			powering = FALSE
			regenPL = FALSE
		}

		blind(time=(world.time + 30)){
			set waitfor = FALSE;
			set background = TRUE;

			blind = TRUE;

			while(world.time < time){ sleep(world.tick_lag); }

			send("{B*{x You're no longer blind!",src,TRUE);

			blind = FALSE;
		}

		_doDamage(damage){
			if(isplayer(src) && isImm){ return FALSE; }

			currpl = clamp(currpl + damage, MIN_PL, getMaxPL())

			if(currpl < getMaxPL() && !regenPL){ src:regenPL() }

			if(damage < 1){
				resting = FALSE;
				sleeping = FALSE;
			}

			if(currpl <= MIN_PL && !unconscious && !activatedUI && locate(/Command/Technique/Form/ultrainstinctomen) in techniques) {
				activatedUI = TRUE;
				send("{BEverything goes dark as you nearly lose consciousness, but you maintain your footing and slump forward..{x",src)
				send("{W*{x [raceColor(name)] nearly loses consciousness, but [determineSex(3)] maintains [determineSex(1)] footing and slumps forward..{x",_ohearers(0,src))
				stunned = FALSE;
				powering = FALSE;
				locked = TRUE;
				curreng = ret_percent(75,getMaxEN())
				currpl = ret_percent(50,getMaxPL())
				if(form != "Normal"){ checkForm = FALSE; }
				send("{WYou close your eyes as a faint {Bblue{W and {wsilver{W aura outlines your body...{x",src)
				send("{W* [raceColor(name)] closes [determineSex(1)] eyes as a faint {Bblue{W and {wsilver{W aura outlines [determineSex(1)] body...{x",_ohearers(0,src))
				sleep(10)
				var/c = percent(currpl,getMaxPL())
				form = "Ultra Instinct Omen"
				currpl = clamp(ret_percent(c,getMaxPL()), 5, getMaxPL())

				send("{WA {Rhot {Bblue{W and {wsilver{W aura explodes around you as you open your {wsilver{W eyes.{x",src)
				send("{WYou have achieved an {Romen{W of the divine power known as {BUltra Instinct{W!{x",src)
				send("{W* A {Rhot{W {Bblue{W and {wsilver{W aura explodes around [raceColor(name)] as [determineSex(3)] opens [determineSex(1)] {wsilver{W eyes.{x",_ohearers(0,src))
				send("{W* [raceColor(name)] has achieved an {Romen{W of the divine power known as {BUltra Instinct{W!",_ohearers(0,src))
				if(visuals["hair_style"] != "Bald"){
					visuals["hair_style"] = "Spiked"
				}
				visuals["eye_color"] = "{wSilver{x"
				CheckForm()
				mOuter("an unbelievable surge of energy",src,ov_out(1,12,src));
				locked = FALSE;

			} else if(currpl <= MIN_PL && !unconscious){
				send("{REverything goes dark as you lose consciousness!{x",src)
				var/msg = istype(src, /mob/NPA/HOUSESYSTEM/TrainingBot) ? MSG_BOT_BEATEN : MSG_KNOCKED_OUT
				loseConsciousness(msg)
			}

			return TRUE;
		}

		gainPL(){}
		gainPL_EVENT(){}
		gainPLGrav(){}

		getClient(){
			if(client){
				return "[clientType()] @ [client.address]"
			}else{
				return "{RLINKDEAD{x"
			}
		}

		clientType(){
			if(client.ctype==TELNET){
				return "TELNET"
			}else{
				return "BYOND"
			}
		}

		readBuffer()

		canLearn(technique){ // Very innefficient speed wise.
			for(var/C in skillSet()){
				var/Command/K = new C();
				for(var/X in techniques){
					var/Command/L = new X();
					if(L.internal_name == K.internal_name && L.internal_name == technique){
						return FALSE;
					}
				}
			}

			return TRUE;
		}

		fly(){
			set waitfor = FALSE;

			var/goTime = (world.time + 30);

			while(!density){
				if(currpl < 100){alaparser.parse(src, "fly", list())}
				if(world.time >= goTime){
					// Hikou and Phaserun are similar, but phaserun has very minor PL drain when flying and needs to be taught
					if(hasSkill("hikou") || hasSkill("phaserun")) {
						if(hasSkill("phaserun")) {
							_doDamage(-ret_percent(0.05,currpl))
							goTime = (world.time + 30);
						}
					} else {
						_doDamage(-ret_percent(0.5,currpl))
						goTime = (world.time + 30);
					}
				}
				sleep(world.tick_lag)
			}
		}

		getMaxPL(){
			var/planet/area = getArea();

			if(area && area.powerLocked){
				return area.maxPower;
			}

			return (maxpl + calcBonusPL());
		}

		getPotentialMaxPL() {
			switch(race) {
				if (LEGENDARY_SAIYAN) {
					if (hasSkill("ssj4")) {
						return maxpl + calcBonusPL(gForm.getPLMod("legendary ssj4"))
					}
					if (hasSkill("ssj3")) {
						return maxpl + calcBonusPL(gForm.getPLMod("legendary ssj3"))
					}
					if (hasSkill("ssj2")) {
						return maxpl + calcBonusPL(gForm.getPLMod("legendary ssj2"))
					}
					if (hasSkill("ultrainstinct")) {
						return maxpl + calcBonusPL(gForm.getPLMod("ultra instinct"))
					}
					if (hasSkill("ultrainstinctomen")) {
						return maxpl + calcBonusPL(gForm.getPLMod("ultra instinct omen"))
					}
					if (hasSkill("ssjb")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan blue"))
					}
					if (hasSkill("ssjr")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan red"))
					}
					if (hasSkill("ssjg")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan god"))
					}
					if (hasSkill("ssj")) {
						return maxpl + calcBonusPL(gForm.getPLMod("legendary ssj"))
					}
				}
				if (SAIYAN) {
					if (hasSkill("ultrainstinct")) {
						return maxpl + calcBonusPL(gForm.getPLMod("ultra instinct"))
					}
					if (hasSkill("ultrainstinctomen")) {
						return maxpl + calcBonusPL(gForm.getPLMod("ultra instinct omen"))
					}
					if (hasSkill("ssjb")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan blue"))
					}
					if (hasSkill("ssjr")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan red"))
					}
					if (hasSkill("ssjg")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan god"))
					}
					if (hasSkill("ssj4")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan 4"))
					}
					if (hasSkill("ssj3")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan 3"))
					}
					if (hasSkill("kaioken") && hasSkill("ssj")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super kaioken"))
					}
					if (hasSkill("ssj2")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan 2"))
					}
					if (hasSkill("ssj")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan"))
					}
					if (hasSkill("kaioken")) {
						return maxpl + calcBonusPL(gForm.getPLMod("kaioken x4"))
					}
				}
				if (HALFBREED) {
					if (hasSkill("mystic")) {
						return maxpl + calcBonusPL(gForm.getPLMod("mystic"))
					}
					if (hasSkill("ssj2")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan 2"))
					}
					if (hasSkill("ssj")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super saiyan"))
					}
				}
				if (BIO_ANDROID) {
					if (hasSkill("super perfect")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super perfect"))
					}
					if (hasSkill("perfect")) {
						return maxpl + calcBonusPL(gForm.getPLMod("perfect"))
					}
					if (hasSkill("semi-perfect")) {
						return maxpl + calcBonusPL(gForm.getPLMod("semi-perfect"))
					}
					if (hasSkill("imperfect")) {
						return maxpl + calcBonusPL(gForm.getPLMod("imperfect"))
					}
				}
				if (NAMEK) {
					if (hasSkill("supernamek")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super namek"))
					}
					if (hasSkill("enhancednamek")) {
						return maxpl + calcBonusPL(gForm.getPLMod("enhanced namek"))
					}
				}
				if (KAIO) {
					if (hasSkill("mystic")) {
						return maxpl + calcBonusPL(gForm.getPLMod("mystic"))
					}
					if (hasSkill("fullkaioken")) {
						return maxpl + calcBonusPL(gForm.getPLMod("kaioken"))
					}
				}
				if (ICER) {
					if (hasSkill("goldform") && hasSkill("form5")) {
						return maxpl + calcBonusPL(gForm.getPLMod("golden form 5"))
					}
					if (hasSkill("goldform") && hasSkill("form4")) {
						return maxpl + calcBonusPL(gForm.getPLMod("golden form 4"))
					}
					if (hasSkill("form5")) {
						return maxpl + calcBonusPL(gForm.getPLMod("form 5"))
					}
					if (hasSkill("form4")) {
						return maxpl + calcBonusPL(gForm.getPLMod("form 4"))
					}
					if (hasSkill("form3")) {
						return maxpl + calcBonusPL(gForm.getPLMod("form 3"))
					}
					if (hasSkill("form2")) {
						return maxpl + calcBonusPL(gForm.getPLMod("form 2"))
					}
				}
				if (HUMAN) {
					if (hasSkill("spiritburst")) {
						return maxpl + calcBonusPL(gForm.getPLMod("spirit burst"))
					}
				}
				if (ANDROID) {
					if (hasSkill("overclock")) {
						return maxpl + calcBonusPL(gForm.getPLMod("overclocked"))
					}
					if (hasSkill("neomachine")) {
						return maxpl + calcBonusPL(gForm.getPLMod("neomachine"))
					}
					if (hasSkill("superandroid")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super android"))
					}
				}
				if (GENIE) {
					if (hasSkill("kid")) {
						return maxpl + calcBonusPL(gForm.getPLMod("kid"))
					}
					if (hasSkill("super")) {
						return maxpl + calcBonusPL(gForm.getPLMod("super"))
					}
				}
				if (DEMON) {
					if (hasSkill("deity")) {
						return maxpl + calcBonusPL(gForm.getPLMod("deity"))
					}
					if (hasSkill("aristocrat")) {
						return maxpl + calcBonusPL(gForm.getPLMod("aristocrat"))
					}
					if (hasSkill("noble")) {
						return maxpl + calcBonusPL(gForm.getPLMod("noble"))
					}
				}
				if (ALIEN) {
					if (hasSkill("focused")) {
						return maxpl + calcBonusPL(gForm.getPLMod("focused"))
					}
					if (hasSkill("phase-shift")) {
						return maxpl + calcBonusPL(gForm.getPLMod("phase-shift"))
					}
					if (hasSkill("enhance")) {
						return maxpl + calcBonusPL(gForm.getPLMod("enhanced"))
					}
				}
				if (SPIRIT) {
					if (hasSkill("revenant")) {
						return maxpl + calcBonusPL(gForm.getPLMod("revenant"))
					}
					if (hasSkill("spectre")) {
						return maxpl + calcBonusPL(gForm.getPLMod("spectre"))
					}
					if (hasSkill("shadow")) {
						return maxpl + calcBonusPL(gForm.getPLMod("shadow"))
					}
					if (hasSkill("shade")) {
						return maxpl + calcBonusPL(gForm.getPLMod("shade"))
					}
				}
			}

			return maxpl + calcBonusPL();
		}

		getMaxEN(){
			return (maxeng + calcBonusEnergy());
		}

		pmsg(num, viewer){

			emitPower(src,ov_out(1,20,src));

			// Cache commonly used values for performance
			var/others = _ohearers(0,src)
			var/sex_he = determineSex(1)
			var/sex_him = determineSex(2) 
			var/sex_they = determineSex(3)

			// Determine power level tier and messages
			var/self_msg = ""
			var/other_msg = ""
			var/area_msg = ""
			var/area_range = 0
			var/area_duration = 0

			if(num >= 1e+015){
				self_msg = "Reality itself bends around your incomprehensible power! The fabric of existence warps as universes tremble before your divine might!"
				other_msg = "Reality warps around [name] as [sex_he] transcends mortal comprehension! The very laws of physics seem to break down!"
				area_msg = "{WREALITY FRACTURES...{x"
				area_range = 512
				area_duration = 5 MINUTES
			}else if(num >= 5e+014){
				self_msg = "Your power eclipses that of angels! Stars begin to collapse in distant galaxies as your energy ripples through the cosmos!"
				other_msg = "[name]'s power rivals that of cosmic entities! Distant stars flicker and die as [sex_him] energy spreads across the universe!"
				area_msg = "{WTHE COSMOS SHUDDERS...{x"
				area_range = 400
				area_duration = 4.5 MINUTES
			}else if(num >= 1e+014){
				self_msg = "Galaxies spiral faster in your presence! Your power threatens to tear holes in the dimensional barrier itself!"
				other_msg = "Galaxies visibly accelerate their rotation as [name]'s power reaches across space-time itself!"
				area_msg = "{WGALAXIES SHIFT...{x"
				area_range = 350
				area_duration = 4 MINUTES
			}else if(num >= 5e+013){
				self_msg = "Solar systems in nearby sectors begin to feel your influence! Your aura creates gravitational anomalies that bend light itself!"
				other_msg = "[name]'s power creates gravitational distortions that bend light around [sex_him]! Solar systems tremble!"
				area_msg = "{YLIGHT ITSELF BENDS...{x"
				area_range = 300
				area_duration = 4 MINUTES
			}else if(num >= 1e+013){
				self_msg = "Your power transcends planetary limits! The solar system's gravity wells fluctuate as your energy radiates outward!"
				other_msg = "The entire solar system feels [name]'s power! Planetary orbits begin to wobble slightly!"
				area_msg = "{RTHE SOLAR SYSTEM TREMBLES...{x"
				area_range = 280
				area_duration = 3.5 MINUTES
			}else if(num >= 5e+012){
				self_msg = "Moons in orbit shift their paths! Your energy signature can be detected from the edge of the solar system!"
				other_msg = "[name]'s power reaches astronomical levels! Orbital mechanics begin to destabilize!"
				area_msg = "{RMOONS SHIFT THEIR ORBITS...{x"
				area_range = 260
				area_duration = 3.5 MINUTES
			}else if(num >= 1e+012){
				self_msg = "Your power resonates through the planet's core! Tectonic plates groan under the immense pressure of your aura!"
				other_msg = "[name]'s power penetrates to the planet's core! The very foundations of the world shake!"
				area_msg = "{rTHE PLANET'S CORE RESONATES...{x"
				area_range = 240
				area_duration = 3 MINUTES
			}else if(num >= 5e+011){
				self_msg = "Continental drift accelerates beneath your feet! Your power creates aurora displays in the upper atmosphere!"
				other_msg = "Continental plates shift as [name]'s power reaches geological scales! Aurora lights dance overhead!"
				area_msg = "{GCONTINENTS SHIFT...{x"
				area_range = 220
				area_duration = 3 MINUTES
			}else if(num >= 1e+011){
				self_msg = "Seismic activity, the blinding aura and your roaring voice are something to behold; something wicked this way comes!"
				other_msg = "Seismic activity, a blinding flash, and [name]'s roaring voice are something to behold; something wicked this way comes!"
				area_msg = "{DYou feel the planet shake...{x"
				area_range = 256
				area_duration = 2.5 MINUTES
			}else if(num >= 5e+010){
				self_msg = "Weather patterns worldwide begin to shift! Your energy creates electromagnetic storms in the ionosphere!"
				other_msg = "[name]'s power affects global weather patterns! Lightning dances between [sex_him] fingers!"
				area_msg = "{CWEATHER PATTERNS SHIFT GLOBALLY...{x"
				area_range = 200
				area_duration = 2.5 MINUTES
			}else if(num >= 1e+010){
				self_msg = "The clouds start to rip open with the amount of power engulfing you!"
				other_msg = "The clouds start to rip open with the amount of power engulfing [name]!"
				area_msg = "{CCLOUDS RIP APART...{x"
				area_range = 180
				area_duration = 2 MINUTES
			}else if(num >= 5e+009){
				self_msg = "The atmosphere itself begins to glow! Your power creates a visible distortion in the air for miles around!"
				other_msg = "The atmosphere glows around [name]! [sex_him] power creates visible distortions for miles!"
				area_msg = "{YTHE ATMOSPHERE GLOWS...{x"
				area_range = 160
				area_duration = 2 MINUTES
			}else if(num >= 1e+009){
				self_msg = "The sky begins to darken against the brightness of your aura as the clouds swirl around you overhead!"
				other_msg = "The sky begins to darken against the brightness of [name]'s aura as the clouds swirl around [sex_him] overhead!"
				area_msg = "{DThe sky darkens...{x"
				area_range = 256
				area_duration = 2.5 MINUTES
			}else if(num >= 5e+008){
				self_msg = "Mountains in the distance visibly shake! Your power creates pressure waves that flatten forests!"
				other_msg = "Distant mountains shake as [name]'s power creates devastating pressure waves!"
				area_msg = "{rMOUNTAINS TREMBLE...{x"
				area_range = 140
				area_duration = 1.5 MINUTES
			}else if(num >= 1e+008){
				self_msg = "The ground quakes as violent wind whips away from you!  The aura surrounding you flares as it grows in intensity!"
				other_msg = "The ground quakes as violent wind whips away from [name]!  The aura surrounding [sex_him] flares as it grows in intensity!"
				area_msg = "{rThe ground quakes...{x"
				area_range = 50
				area_duration = 2.5 MINUTES
			}else if(num >= 5e+007){
				self_msg = "Massive boulders float effortlessly around you! Your aura creates a shimmering heat haze that distorts vision!"
				other_msg = "Massive boulders float around [name] like they're weightless! Heat haze distorts [sex_him] image!"
				area_msg = "{rBOULDERS FLOAT IN THE AIR...{x"
				area_range = 45
				area_duration = 1.5 MINUTES
			}else if(num >= 1e+007){
				self_msg = "A crater begins to form beneath your feet as your aura brightens immensely."
				other_msg = "A crater begins to form beneath [name]'s feet as [sex_he] aura brightens immensely."
				area_msg = "{yA CRATER FORMS...{x"
				area_range = 40
				area_duration = 1 MINUTE
			}else if(num >= 5e+006){
				self_msg = "The air around you begins to ionize! Small lightning bolts dance between your fingers as your power surges!"
				other_msg = "The air ionizes around [name]! Lightning crackles between [sex_him] fingers!"
				area_msg = "{cLIGHTNING CRACKLES...{x"
				area_range = 35
				area_duration = 1 MINUTE
			}else if(num >= 1e+006){
				self_msg = "Dust scatters throughout the air from large rocks floating up and disintegrating around you."
				other_msg = "Dust scatters throughout the air from large rocks floating up and disintegrating around [name]."
				area_msg = "{yDUST CLOUDS FORM...{x"
				area_range = 30
				area_duration = 45 SECONDS
			}else if(num >= 5e+005){
				self_msg = "Your aura becomes visible to the naked eye! Stone and metal begin to crack under the pressure!"
				other_msg = "[name]'s aura becomes blindingly visible! Stone and metal crack under the pressure!"
				area_msg = "{YAURA BLAZES BRIGHTLY...{x"
				area_range = 25
				area_duration = 30 SECONDS
			}else if(num >= 1e+005){
				self_msg = "The ground trembles faintly as rocks start to break away and lift into the air."
				other_msg = "The ground trembles beneath [name] as rocks start to break away and lift into the air."
				area_msg = "{yROCKS LIFT INTO THE AIR...{x"
				area_range = 20
				area_duration = 30 SECONDS
			}else if(num >= 5e+004){
				self_msg = "Your power creates a faint wind! Loose debris swirls around you in a growing vortex!"
				other_msg = "Wind swirls around [name] as debris forms a vortex around [sex_him]!"
				area_msg = "{cWIND SWIRLS...{x"
				area_range = 15
				area_duration = 20 SECONDS
			}else if(num >= 1e+004){
				self_msg = "Small pebbles float up into the air and disintegrate as a faint aura forms around you."
				other_msg = "Small pebbles float up into the air and disintegrate as a faint aura forms around [name]."
			}else if(num >= 5e+003){
				self_msg = "Your energy begins to manifest visibly! The air shimmers with heat around your body!"
				other_msg = "[name]'s energy manifests visibly! The air shimmers with heat around [sex_him]!"
			}else if(num >= 1e+003){
				self_msg = "You feel the power building within you! Your muscles tense as energy courses through your veins!"
				other_msg = "[name]'s muscles visibly tense as power builds within [sex_him]!"
			}else if(num >= 500){
				self_msg = "Your heart pounds as you focus your inner energy! Adrenaline surges through your system!"
				other_msg = "[name]'s breathing becomes heavy as [sex_they] focus [sex_him] energy!"
			}else{
				self_msg = "Sweat rolls down your brow as you begin to focus."
				other_msg = "Sweat rolls down [name]'s brow as [sex_they] begin to focus!"
			}

			// Send messages efficiently
			if(viewer == SELF){
				send(raceColor(self_msg), src)
			}else{
				send(raceColor(other_msg), others)
			}

			// Send area message if applicable
			if(area_msg && area_range > 0 && area_duration > 0){
				emitMessage(src, ov_out(16, area_range, src), area_msg, area_duration)
			}
		}

		power(num,MAX=FALSE){
			set waitfor = FALSE;

			var
				refreshTick = (world.time + 25);
				maximum=FALSE;

			while(powering){
				var
					uCalc = ret_percent(10,getMaxPL())
					dCalc = ret_percent(20,getMaxPL())

				if(MAX){num=getMaxPL()}

				if(world.time >= refreshTick){
					if(num > currpl){
						currpl = clamp(currpl + uCalc, MIN_PL, num)
						_doEnergy(-5)
						pmsg(currpl,SELF)
						pmsg(currpl,NULL;)
					}else{
						currpl = clamp(currpl - dCalc, num, getMaxPL())
					}

					if(currpl == num){
						maximum=TRUE;
						powering = FALSE;
					}
					refreshTick = (world.time + 25);
				}

				sleep(world.tick_lag)
			}

			if(maximum){
				send("You have reached your desired powerlevel!",src)
				send("[raceColor(name)] stops altering [determineSex(1)] powerlevel!",_ohearers(0,src))
			}else{
				send("You stop altering your powerlevel.",src)
				send("[raceColor(name)] stops altering [determineSex(1)] powerlevel!",_ohearers(0,src))
			}
		}

		defenseTips(Command/Technique/c, show=showDefense){
			if(show) {
				return view_list(c.defenses, "defense", src);
			}
		}

		isSafe(){
			if(loc && game.safeTypes[loc.type] || insideMedPod){ return TRUE; }

			return FALSE;
		}

		isGero(){
			if(loc && game.geroTypes[loc.type]){ return TRUE; }

			return FALSE;
		}

		flyDirection(atom/m, DIRECTION){
			set waitfor = FALSE;

			var
				time=4;
				refreshTime=6;
				flID = ++flyID;
				oldArea = getArea()

			while(src && flying && flID == flyID && getArea() == oldArea){

				if(checkTargeted() || atkDat || !(game.dir2text_map(DIRECTION) in src.Exits())){
					flying = NULL;
					lFlyT = NULL;
					break;
				}


				var/obj/trail/A = new(loc)
				A.setDisplay(gForm.getAuraColor(src,form,"~"))
				Move(get_step(src,DIRECTION), DIRECTION,0,0,TRUE)

				if(time>=refreshTime){
					send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)
					time=0;
				}

				time++;

				sleep(flightSPEED - clamp(ret_percent(calcFlightBonus(),flightSPEED),0,flightSPEED - world.tick_lag))
			}

			if(!flying) send("You stop flying.",src)
			if(bursting){ bursting=FALSE; }
		}

		flyToCoord(atom/m){
			set waitfor = FALSE;

			var
				time=4;
				refreshTime=6;
				flID = ++flyID;
				oldArea = getArea()

			while(src && flying && flID == flyID && getArea() == oldArea){

				if(checkTargeted() || atkDat || !(game.dir2text_map(a_get_dir(src,m)) in src.Exits())){
					flying = NULL;
					lFlyT = NULL;
					break
				}

				var/obj/trail/A = new(loc)
				A.setDisplay(gForm.getAuraColor(src,form,"~"))
				Move(get_step(src,a_get_dir(src,m)), a_get_dir(src,m),0,0,TRUE)

				if(x == m.x && y == m.y){
					flying=NULL;
					lFlyT=NULL;
					send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)
					send("You arrive at [coord(m.getX(),m.loc:getDX())]{C.{x[coord(m.getY(),m.loc:getDY())].",src)
					if(bursting){ bursting=FALSE; }
					break;
				}

				if(time>=refreshTime){
					send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)
					time=0;
				}

				time++;

				sleep(flightSPEED - clamp(ret_percent(calcFlightBonus(),flightSPEED),0,flightSPEED - world.tick_lag))
			}

			if(!flying) send("You stop flying towards [coord(m.getX(),m.loc:getDX())]{C.{x[coord(m.getY(),m.loc:getDY())].",src)
		}

		flyTo(mob/m){
			set waitfor = FALSE;

			var
				time=4;
				refreshTime=6;
				saveRef = m.raceColor(m.name);
				flID = ++flyID;

			while(src && flying && flID == flyID){

				if(checkTargeted() || atkDat || getArea() != m.getArea() || !m.canSense(src) || !(game.dir2text_map(a_get_dir(src,m)) in src.Exits())){
					flying = NULL;
					lFlyT = NULL;
					break
				}

				var/obj/trail/A = new(loc)
				A.setDisplay(gForm.getAuraColor(src,form,"~"))
				Move(get_step(src,a_get_dir(src,m)), a_get_dir(src,m),0,0,TRUE)

				if(isloc(src,m)){
					flying=NULL;
					lFlyT=NULL;
					send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)
					send("You arrive at [saveRef]'s location.",src)
					if(bursting){ bursting=FALSE; }
					break;
				}

				if(time>=refreshTime){
					send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)
					time=0;
				}

				time++;

				sleep(flightSPEED - clamp(ret_percent(calcFlightBonus(),flightSPEED),0,flightSPEED - world.tick_lag))
			}

			if(!m || getArea() != m.getArea()) send("You lost [saveRef]'s power signal.",src)
			if(!flying) send("You stop flying towards [saveRef].",src); return;
			if(m.density && !src.density) {
				alaparser.parse(src,"fly", list());
			}
		}

		zMobs(OR=FALSE, noPlaneCheck=FALSE){
			var/list/mobs[] = list();

			for(var/mob/m in getArea()){
				if(!m.canSense(src) && !OR || m.invisible || !checkPlane(src, m) && !noPlaneCheck){
					continue
				}else{ mobs.Add(m); } }

			return distance_order(src,mobs) - src;
		}

		superHearing(){
			if(locate(/Command/Technique/super_hearing) in techniques){
				return 4;
			}

			return 0;
		}

		energyMessage(){
			if(percent(curreng,getMaxEN()) <= 20){
				send("{yYou feel dizzy...{x", src)
				send("{y[name] feels dizzy...{x", _ohearers(0, src))
				if(!resting && !sleeping) { _doDamage(-ret_percent(5,getMaxPL())) } // Added a check to not do damage if the player is resting or sleeping.
			}
			else if(percent(curreng,getMaxEN()) <= 30){
				send("{yYou take a deep breath...{x", src)
				send("{y[name] takes a deep breath...{x", _ohearers(0, src))
			}
			else if(percent(curreng,getMaxEN()) <= 50){
				send("{yA drop of sweat rolls down your face...{x", src)
				send("{yA drop of sweat rolls down [name]'s face...{x", _ohearers(0, src))
			}
		}

		sleeping(){
			set waitfor = FALSE;
			set background = TRUE;

			var/refreshTime=(world.time + 35);

			while(src && sleeping){
				if(curreng >= getMaxEN() && currpl >= getMaxPL()){sleeping=FALSE;}

				if(world.time >= refreshTime){
					_doEnergy(ret_percent(6,getMaxEN()))
					currpl = clamp(currpl + ret_percent(5,getMaxPL()), MIN_PL, getMaxPL())
					refreshTime = (world.time + 35);
				}
				sleep(world.tick_lag)
			}
			if(src && !sleeping && !resting){
				send("You wake up!", src)
				send("[raceColor(name)] wakes up!", _ohearers(0, src))
			}
		}

		bursting(){
			set waitfor = FALSE;
			set background = TRUE;

			var/refreshTime=(world.time + 35);

			while(src && bursting){
				if(unconscious){ bursting = FALSE; }

				if(world.time >= refreshTime){
					_doEnergy(-1,NO_ENERGY=TRUE)
					refreshTime = (world.time + 35);
				}

				sleep(world.tick_lag)
			}

			if(src && !bursting){
				send(raceColor("Your aura fades!"), src,TRUE)
				send(raceColor("[name]'s aura fades!"), _ohearers(0, src))
			}
		}

		barrier(){
			set waitfor = FALSE;
			set background = TRUE;

			var/refreshTime=(world.time + 30);

			while(src && barrier){
				if(unconscious){ barrier = FALSE; }

				if(world.time >= refreshTime){
					_doEnergy(-3,NO_ENERGY=TRUE)
					refreshTime = (world.time + 30);
				}

				sleep(world.tick_lag)
			}

			if(src && !barrier){
				send("Your shields are down!", src,TRUE)
				send("[raceColor(name)]'s shields fall!", _ohearers(0, src))
			}
		}

		resting(){
			set waitfor = FALSE;
			set background = TRUE;

			var/refreshTime=(world.time + 35);

			while(src && resting){
				if(curreng >= getMaxEN()){resting=FALSE;}

				if(world.time >= refreshTime){
					_doEnergy(ret_percent(3,getMaxEN()))
					refreshTime=(world.time + 35);
				}
				sleep(world.tick_lag)
			}
			if(src && !resting && !sleeping){
				send("You stand up!", src)
				send("[raceColor(name)] stands up!", _ohearers(0, src))
			}
		}

		teleportMob(mob/target, imm=FALSE) {
			if(src.invisible == FALSE) {
				send("{W*{x [raceColor(name)] vanishes into thin air!",_ohearers(0,src))
			}

			_teleport(target, imm)
			send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)
			var/msg = imm ? "You warp to [target.raceColor(target.name)]!" : "{B* You appear before {x[target.raceColor(target.name)]{B!{x"
			send(msg,src)
			if(src.invisible == FALSE) {
				send("{W*{x [raceColor(name)] appears before you out of thin air!",_ohearers(0,src))
			}


			for(var/mob/Player/g in grabbers){
				if(!g.hasDB()){
					send(buildMap(g,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),g)
					send("{B* You appear before {x[target.raceColor(target.name)]{B!{x", g)
					if(src.invisible == FALSE) {
						send("{W*{x [raceColor(name)] appears before you out of thin air!",_ohearers(0,g))
					}
				}

			}
		}

		_teleport(atom/target, imm){
			iting=FALSE
			insideMedPod = FALSE
			loc=target.loc
			insideBuilding = target:insideBuilding
			var/destDensity = insideBuilding ? TRUE : target.density
			density=destDensity

			for(var/mob/Player/g in grabbers){
				if(!g.hasDB()){
					g.loc=target.loc;
					g.density=destDensity
					g.insideBuilding = insideBuilding
				}
			}

			if (!imm)
				game.addCooldown(name,"teleport",10 SECONDS);
		}

		teleportObj(obj/target, imm=FALSE) {
			send("{W*{x [raceColor(name)] vanishes into thin air!",_ohearers(0,src))
			_teleport(target, imm)
			send(buildMap(src,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),src)
			send("{B* You appear on top of {x[target:DISPLAY]{B!{x", src)
			send("{W* [raceColor(name)] appears on top of {x[target:DISPLAY]{B!{x", _ohearers(0, src))

			for(var/mob/Player/g in grabbers){
				if(!g.hasDB()){
					send(buildMap(g,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),g)
					send("{B* You appear on top of {x[target:DISPLAY]{B!{x", g)
					send("{W* [raceColor(name)] appears on top of {x[target:DISPLAY]{B!{x", _ohearers(0, g))
				}
			}
		}

		regainConscious(OR=FALSE){
			set waitfor = FALSE;
			set background = TRUE;

			while(src && unconscious){
				if(curreng >= 25 || OR){
					curreng = ret_percent(25.00,getMaxEN())
					unconscious = FALSE;
					send("Ugh... You slowly regain consciousness.",src)
					send("[raceColor(name)] has regained consciousness!", _ohearers(src,0))
				}
				sleep(world.tick_lag)
			}
		}

		createCommand(path){
			try{
				var/Command/p = new path;

				return p;
			}

			catch(var/exception/e){
				world.log << "[e.file]:[e.line] createCommand() tried to create an command that doesn't exist."
				return FALSE
			}
		}

		calcMeleeRange(base){
			if(race == NAMEK || (race == GENIE)){
				return base + namekMelee
			}
			else{
				return base
			}
		}

		getStatus(){
			if(isplayer(src) && !client){
				return "{RLINKDEAD{x"
			}
			else if(isAFK){
				return "{YAFK{x"
			}
			else if(unconscious){
				return "unconscious"
			}
			else if(stunned){
				return "stunned"
			}
			else if(flying){
				return "flying"
			}
			else if(sleeping){
				return "sleeping"
			}
			else if(iting || iming){
				return "teleporting"
			}
			else if(resting){
				return "resting"
			}
			else if(!density){
				return "floating in the air"
			}
			else if(loc && loc:tType == WATER){
				return "swimming"
			}
			else{
				return "standing"
			}

			return "status error"
		}

		getRoom(){
			var
				mobiles[] = list()

			for(var/mob/P in loc){
				if(P == src || !P.visible || P.invisible || !checkPlane(src, P)){continue}
				mobiles.Add(P)
			}

			return mobiles
		}

		getAllRoom(){
			var
				mobiles[] = list()

			for(var/mob/P in loc){
				if(!P.visible || P.invisible || !checkPlane(src, P)){continue}
				mobiles.Add(P)
			}

			return mobiles
		}

		getItemRoom(var/ignorePlane=FALSE){
			var
				items[] = list()

			for(var/obj/I in loc){
				if(istype(I,/obj/item/DRAGONBALLS) && !DBDatum.areActive()) { continue; }
				if(istype(I,/obj/item/NAMEK_DRAGONBALLS) && !DBDatum_NAMEK.areActive()) { continue; }
				if(!ignorePlane && !checkPlane(src, I)) { continue }
				items.Add(I)
			}

			return stackList(items, list("name", "type", "DISPLAY"))
		}

		getMobiles(top,bottom,left,right){
			if(!loc) return NULL;

			var
				mobiles[] = list()

			for(var/yy in top to bottom step -1){
				for(var/xx in left to right){
					var
						aY = Wrap(yy,loc.loc:y,loc.loc:getMaxY(),loc.loc:hideEdges)
						aX = Wrap(xx,loc.loc:x,loc.loc:getMaxX(),loc.loc:hideEdges)
						turf/T = locate(aX,aY,z)

					for(var/mob/M in T){
						if(M == src || !checkPlane(src, M)){continue}
						mobiles.Add(M)
					}
				}
			}

			return distance_order(src,mobiles)
		}

		Exits(OR=FALSE){
			var/list/EXITS = list("north","south","east","west","nw","ne","sw","se")

			// Because I am lazy, if the mob is inside, return an empty list. Need to fix this later
			for(var/turf/T in t_oview(1,src)){
				var/hsCheck = houseSystem.canEnterTurf(src, T)
				if(density && !hsCheck || insideMedPod || insideBuilding && !houseSystem.isPlayerTurf(T) || istype(T,/turf/void) || src.density && T.density && !src.insideBuilding || src.hasDB() && (T.type in game.safeTypes) || src.fCombat.hostileTargets.len && (T.type in game.safeTypes) || src.loc.loc:hideEdges && src.loc.loc != T.loc) {
					EXITS.Remove(game.dir2text_map(a_get_dir(src,T)))
				}
			}

			if(istype(src,/mob/Player) && checkPod()){ EXITS = list("Exit.") }

			if(!EXITS.len || checkTargeted() && !OR){ EXITS = list("None.") }

			return EXITS
		}

		mobMark(mob/m){
			if(isplayer(m) && m.isAFK){
				return "{YAFK{x";
			}

			if(isplayer(m) && m.isImm){
				return "{RIMM{x";
			}

			if(m.hasDB()){
				return "{Y({x{R*{x{Y){x"
			}

			if(src == m){
				return "{C*{x"
			}

			if(m.getMaxPL() < 10000){
				return "{MN{x"
			}

			if(getMaxPL() >= (m.getMaxPL() + 0.50*m.getMaxPL())){
				return "{y*{x"
			}
			else{
				return "{M*{x"
			}

			if(getMaxPL() <= (m.getMaxPL() - 0.50*m.getMaxPL())){
				return "{y*{x"
			}
			else{
				return "{M*{x"
			}
		}

		general_mark(mob/m){
			var/obj/item/i = equipment[EYE]

			if(i && isScanner(i,FALSE) || isAndroid(src)){
				if(shortNUM){
					return m.raceColor(short_num(m.currpl))
				}else{
					return m.raceColor(commafy(m.currpl))
				}
			}

			if(currpl >= (m.currpl * game.settings.map["veryWeakModifier"])) {
				return "{yVERY WEAK{x";
			}
			else if(currpl >= (m.currpl * game.settings.map["weakModifier"])) {
				return "{yWEAK{x";
			}
			else if(currpl >= (m.currpl * game.settings.map["equalModifier"])) {
				return "{BEQUAL{x";
			}
			else if(currpl >= (m.currpl * game.settings.map["strongModifier"])) {
				return "{RSTRONG{x";
			} else {
				return "{rGODLIKE{x";
			}
		}

		enCheck(mob/m,FORMAT=FALSE){
			var/obj/item/i = equipment[EYE]

			if(i && isScanner(i,FALSE) && isScanner(i,TRUE) > 1/* || hasSkill("perception")*/){
				if(FORMAT){
					return "<al13>([percent_color(m.curreng,m.getMaxEN())])</a>";
				}else{
					return "([percent_color(m.curreng,m.getMaxEN())]) ";
				}
			}else{
				return NULL;
			}

			return NULL;
		}

		enCheck_PROMPT(mob/m){
			var/obj/item/i = equipment[EYE]

			if(i && isScanner(i,FALSE) && isScanner(i,TRUE) > 1 || hasSkill("perception")){
				return "<[percent_color(m.curreng,m.getMaxEN())]> ";
			}
		}

		powerMark(mob/m){
			if(isplayer(m) && m.isImm){
				return "{RIMM{x";
			}

			return formatSensePower(src, m)
		}

		map_mobMark(mob/m){
			if(isplayer(m) && m.isImm){
				return "{o*{x";
			}

			if(src == m){
				return "{C*{x"
			}

			if(isplayer(m)){
				return "{R*{x"
			}

			if(isnpc(m) && !m:hostile){
				return "{M*{x"
			}

			if(getMaxPL() >= (m.getMaxPL() + 0.50*m.getMaxPL())){
				return "{y*{x"
			}
			else{
				return "{M*{x"
			}

			if(getMaxPL() <= (m.getMaxPL() - 0.50*m.getMaxPL())){
				return "{Y*{x"
			}
			else{
				return "{M*{x"
			}
		}

		receive_item(obj/item/I, mob/giver) {}

	Cross(atom/theAtom){
		if(istype(theAtom,/mob)){
			return TRUE;
		}
		else{
			return ..();
		}
	}

	Move(new_loc, new_dir, step_x=0, step_y=0, override=FALSE, moveMessage=TRUE)
	{
		if(kiAttk) cancelKi()

		if(flying && !override){flying=NULL;lFlyT=NULL;}

		if(resting && !override || sleeping && !override){return FALSE;}

		if(!density){ emitSelf(src,ov_out(16,34,src)); }

		if(src && src.loc && src.loc.contents && playersInRoom(src.loc.contents, src) && !density && moveMessage){
			if(visible && !invisible) send("[raceColor(name)] flies [game.dir2text(new_dir,0)].", _ohearers(0, src))
		}
		else if(src && src.loc && src.loc.contents && playersInRoom(src.loc.contents, src) && loc && loc:tType == WATER && moveMessage){
			if(visible && !invisible) send("[raceColor(name)] swims [game.dir2text(new_dir,0)].", _ohearers(0, src))
		}
		else if(src && src.loc && src.loc.contents && playersInRoom(src.loc.contents, src) && moveMessage){
			if(visible && !invisible) send("[raceColor(name)] moves [game.dir2text(new_dir,0)].", _ohearers(0, src))
		}

		var nx = x
		var ny = y

		if(new_dir & EAST){
			nx ++
		}
		else if(new_dir & WEST){
			nx --
		}
		if(new_dir & NORTH){
			ny ++
		}
		else if(new_dir & SOUTH){
			ny --
		}

		if(loc && loc.loc && isplanet(loc.loc)){
			if(nx > loc.loc:getMaxX()){
				nx = (loc.loc:x + x - loc.loc:getMaxX())
			}
			else if(nx < loc.loc:x){
				nx = (loc.loc:x - x + loc.loc:getMaxX())
			}

			if(ny > loc.loc:getMaxY()){
				ny = (loc.loc:y + y - loc.loc:getMaxY())
			}
			else if(ny < loc.loc:y){
				ny = (loc.loc:y - y + loc.loc:getMaxY())
			}
		}else{
			if(nx > world.maxx){
				nx -= world.maxx
			}
			else if(nx < 1){
				nx += world.maxx
			}
			if(ny > world.maxy){
				ny -= world.maxy
			}
			else if(ny < 1){
				ny += world.maxy
			}
		}

		..(locate(nx, ny, z), new_dir)

		if(src && src.loc && src.loc.contents && playersInRoom(src.loc.contents, src) && !density && moveMessage){
			if(visible && !invisible) {
				send("[raceColor(name)] flies in from the [game.dir2text(new_dir,1)].", _ohearers(0, src))
			}
		}
		else if(src && src.loc && src.loc.contents && playersInRoom(src.loc.contents, src) && loc && loc:tType == WATER && moveMessage){
			if(visible && !invisible) {
				send("[raceColor(name)] swims in from the [game.dir2text(new_dir,1)].", _ohearers(0, src))
			}
		}
		else if(src && src.loc && src.loc.contents && playersInRoom(src.loc.contents, src) && moveMessage){
			if(visible && !invisible) {
				send("[raceColor(name)] moves in from the [game.dir2text(new_dir,1)].", _ohearers(0, src))
			}
		}

		// Event Entered
		if(src.invisible == FALSE) {
			for(var/mob/m in loc){
				if(isnpc(m)) {
					m.event_entered(src);
				}
			}
		}

	}
