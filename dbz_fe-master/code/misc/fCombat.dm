fTimer
	var
		RUNNING = FALSE;
		mob/MOB_1 = NULL;
		mob/MOB_2 = NULL;
		endTime = NULL;

	proc
		loop()
		updateTime(time)
		end()

	updateTime(time){
		endTime = (world.time + time);
	}

	clean(){
		..()
		RUNNING = FALSE;
		MOB_1 = NULL;
		MOB_2 = NULL;
		endTime = NULL;
	}

	end(){
		RUNNING = FALSE;
	}

	loop(){
		set waitfor=FALSE;

		while(RUNNING && MOB_1 && MOB_2){
			if(world.time >= endTime || MOB_1.getArea() != MOB_2.getArea()){
				MOB_1.fCombat.removeHostile(MOB_2);
				MOB_2.fCombat.removeHostile(MOB_1);
				break;
			}
			sleep(world.tick_lag);
		}

		clean();
	}

	New(mob/M1, mob/M2){
		MOB_1 = M1;
		MOB_2 = M2;
		updateTime(fightTimerDefault);
		RUNNING = TRUE;
		loop();
	}

	Del(){
		..();
	}

fCombat

	New(mob/owner){
		..()
		mobRef = owner
		owner.fCombat = src
		addAlly(owner)
	}

	Del(){
		..()
	}

	var
		mobRef = NULL;
		hostileTargets[] = list()
		alliedTargets[] = list()
		fightTimers[] = list()
		lastTarget = NULL;
		comboList[] = list()
		comboCount[] = list()
		BROKEN_DEFENSE = FALSE;


		//NPA Variables//
		groupedTypes[] = list()

	proc
		_hostiles(){
			var/_mobiles = 0;

			for(var/mob/m in hostileTargets){
				_mobiles++;
			}

			return _mobiles;
		}

		calcDefense(mob/m){
			return m.calcBonusDefense();
		}

		_getLastTarget(checkDensity=FALSE){
			if(mobRef && lastTarget){
				if(checkDensity){
					if(mobRef:density && !lastTarget:density || !mobRef:density && lastTarget:density){
						return NULL;
					}
				}

				return lastTarget;
			}else{
				return NULL;
			}
		}

		_getPromptTarget(){
			if(_getLastTarget()){
				return "/ vs. [mobRef:enCheck_PROMPT(_getLastTarget())]<[mobRef:powerMark(_getLastTarget())]>";
			}
			else{
				return NULL;
			}
		}

		_getCustPromptTarget(){
			if(_getLastTarget()){
				return mobRef:powerMark(_getLastTarget());
			}
			else{
				return "no target";
			}
		}

		dmgName(mob/_target,_damage){
			if(_damage >= ret_percent(15,_target.currpl)){
				return pick("{x>{G>{x{g>{x{WE{x{DR{x{GA{x{gDIC{x{GA{x{DT{x{wES{x{g<{x{G<{x<","{yFU{x{YCKI{x{wN{x{WG TH{x{YRAS{x{yHES{x")
			}
			else if(_damage >= ret_percent(10,_target.currpl)){
				return pick("{w*{x{W*{x{w*{x {wDO{x{WMIN{x{RAT{x{rES{x {w*{x{W*{x{w*{x","{r*{x{R*{x{r*{x {bR{x{BA{x{WP{x{BE{x{bS{x {r*{x{R*{x{r*{x")
			}
			else if(_damage >= ret_percent(5,_target.currpl)){
				return pick("{Mthrashes{x","{Rdevastates{x","{RDISMEMBERS{x")
			}
			else if(_damage >= ret_percent(2.5,_target.currpl)){
				return pick("{wscratches{x","{rhits{x")
			}
			else if(_damage >= ret_percent(0,_target.currpl)){
				return pick("{Dtickles{x","{Wcaresses{x")
			}
		}

		damageMessage(mob/_target, _damage, _attack){
			var/dmgMSG = dmgName(_target,_damage);

			if(mobRef) send("{B*{x{B Your [_attack] {x[dmgMSG] [_target.raceColor(_target.name)]{B!{x {G={x{C\[{x{W[commafy(_damage)]{x{C\]{x{G={x",mobRef);
			if(_target) send("{R* [mobRef:name]'s [_attack] {x[dmgMSG] {Ryou!{x {G={x{C\[{x{W[commafy(_damage)]{x{C\]{x{G={x",_target,TRUE);
			if(mobRef && _target) send("{W*{x [mobRef:raceColor(mobRef:name)]'s [_attack] [dmgMSG] [_target.raceColor(_target.name)]! {G={x{C\[{x{W[commafy(_damage)]{x{C\]{x{G={x",a_oview_extra(0,_target,mobRef));
			if(mobRef && _target && mobRef:loc != _target.loc){ send("{W*{x [mobRef:raceColor(mobRef:name)]'s [_attack] [dmgMSG] [_target.raceColor(_target.name)]! {G={x{C\[{x{W[commafy(_damage)]{x{C\]{x{G={x",_ohearers(0,mobRef)); }
		}

		checkUIAttack(mob/attacker, mob/defender){
			if(prob(fightUIAttack)){
				if(attacker.form == "Ultra Instinct"){
					send("{R*{x{C [attacker.raceColor(attacker.name)] has maneuvered through your defense!", defender)
					send("{B*{x{C You have maneuvered through [defender.raceColor(defender.name)]'s defense!", attacker)
					send("{W*{x{C [attacker.raceColor(attacker.name)] has maneuvered through [defender.raceColor(defender.name)]'s defense!",a_oview_extra(0,attacker,defender))
					attacker._doEnergy(-10)
					return TRUE;
				}
			}
			return FALSE;
		}

		checkBreakDefense(mob/user, mob/target, damage=0, attack=NULL){
			if(damage >= ret_percent_notrunc(40,target.currpl)){
				BROKEN_DEFENSE = TRUE;

				if(attack != NULL){
					send("{B*{x Your [attack] smashes through [target.raceColor(target.name)]'s defense!",user)
					send("{R*{x [user.raceColor(user.name)]'s [attack] smashes through your defense!",target)
					send("{W*{x [user.raceColor(user.name)]'s [attack] smashes through [target.raceColor(target.name)]'s defense!",a_oview_extra(0,user,target))
				}
				return TRUE;
			}

			return FALSE;
		}

		checkBreakBarrier(mob/user, mob/target, damage=0, attack=NULL){

			if(damage >= ret_percent_notrunc(25,target.currpl)){
				BROKEN_DEFENSE = TRUE;

				if(attack != NULL){
					send("{B*{x Your [attack] smashes through [target.raceColor(target.name)]'s barrier!",user)
					send("{R*{x [user.raceColor(user.name)]'s [attack] smashes through your barrier!",target)
					send("{W*{x [user.raceColor(user.name)]'s [attack] smashes through [target.raceColor(target.name)]'s barrier!",a_oview_extra(0,user,target))
					target.barrier = FALSE;
				}
				return TRUE;
			}

			return FALSE;
		}

		doDefense(attack, mob/user=mobRef,mob/target=_getLastTarget(),Command/Technique/c,kiAttack=NULL, damage=0){
			if(!c || target.stunned){ return FALSE; }

			if(attack != "collision damage"){
				if(c.tType == MELEE && user.blind || c.tType == MELEE && a_get_dist(user,target) > user.calcMeleeRange(c._maxDistance) || c.tType == MELEE && !user.calcMeleeRange(c._maxDistance) && (user.density && !target.density || target.density && !user.density) || user.z != target.z){
					send("{B*{x Your [attack] misses [target.raceColor(target.name)]!",user)
					send("{R*{x [user.raceColor(user.name)]'s [attack] misses you!",target)
					send("{W*{x [user.raceColor(user.name)]'s [attack] misses [target.raceColor(target.name)]!",a_oview_extra(0,user,target))
					return TRUE;
				}else if((target.form in list("Ultra Instinct", "Ultra Instinct Omen")) && !c.canFinish && !target.resting && !target.sleeping){
					if(prob(fightStunChance) && c.tType == MELEE && c.canSTUN){stumble(user,target)}
					target._doEnergy(-4);
					send("{B*{x [user.raceColor(target.name)] instinctively dodges your [attack]! [target.raceColor(target.name)]!",user)
					send("{R*{x You instinctively dodge [user.raceColor(user.name)]'s [attack]!",target)
					send("{W*{x [user.raceColor(target.name)] instinctively dodges [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,user,target))
					return TRUE;
				}


				if((PARRY_HIGH in c.defenses) || (PARRY_LOW in c.defenses)){
					if(isnpc(target) && (PARRY_HIGH in c.defenses) && prob(target:defenceChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "parry high", list());
					}
					if(isnpc(target) && (PARRY_LOW in c.defenses) && prob(target:defenceChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "parry low", list());
					}

					if((PARRY_HIGH in c.defenses) && target.chkDef(/atkDatum/parry/parry_high) || (PARRY_LOW in c.defenses) && target.chkDef(/atkDatum/parry/parry_low)){
						if(checkBreakDefense(user,target,damage,attack)){
							target.atkDat:defense = FALSE;

							return FALSE;
						}

						if(!checkUIAttack(user,target)){
							send("{B*{x You tech block [user.raceColor(user.name)]'s [attack]!",target)
							send("{R*{x [target.raceColor(target.name)] tech blocked your [attack]!",user)
							send("{W*{x [target.raceColor(target.name)] tech blocked [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
							if(prob(fightStunChance) && c.tType == MELEE && c.canSTUN){stunned(user,target)}
							if(prob(fightOffenseGainChance) && !user.stunned){ user.gainPL(ret_percent((offenseGainPercent),user.getMaxPL()),target) }
							target.atkDat:defense = FALSE;
							return TRUE;
						}else{
							return FALSE;
						}
					}
				}

				if((DEFLECT in c.defenses)){
					if(isnpc(target) && (DEFLECT in c.defenses) && prob(target:defenceKiChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "deflect", list());
					}

					if(target.chkDef(/atkDatum/deflect)){

						if(checkBreakDefense(user,target,damage,attack)){
							target.atkDat:defense = FALSE;

							return FALSE;
						}

						target._doEnergy(1)
						send("{B*{x You have deflected [user.raceColor(user.name)]'s [attack]!",target)
						send("{R*{x [target.raceColor(target.name)] has deflected your [attack]!",user)
						send("{W*{x [target.raceColor(target.name)] has deflected [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
						target.atkDat:defense = FALSE;
						return TRUE;
					}
				}

				if((DODGE_LEFT in c.defenses) || (DODGE_RIGHT in c.defenses)){
					if(isnpc(target) && (DODGE_LEFT in c.defenses) && prob(target:defenceKiChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "dodge left", list());
					}
					if(isnpc(target) && (DODGE_RIGHT in c.defenses) && prob(target:defenceKiChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "dodge right", list());
					}
					if((DODGE_LEFT in c.defenses) && target.chkDef(/atkDatum/dodge_left) || (DODGE_RIGHT in c.defenses) && target.chkDef(/atkDatum/dodge_right)){
						if(!checkUIAttack(user,target)){
							target._doEnergy(1)
							send("{B*{x You have dodged [user.raceColor(user.name)]'s [attack]!",target)
							send("{R*{x [target.raceColor(target.name)] has dodged your [attack]!",user)
							send("{W*{x [target.raceColor(target.name)] has dodged [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
							target.atkDat:defense = FALSE;
							return TRUE;
						}else{
							return FALSE;
						}
					}
				}

				if((DUCK in c.defenses)){
					if(isnpc(target) && (DUCK in c.defenses) && prob(target:defenceChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "duck", list());
					}
					if(target.chkDef(/atkDatum/duck) && !checkUIAttack(user,target)){
						target._doEnergy(1)
						send("{B*{x You have ducked under [user.raceColor(user.name)]'s [attack]!",target)
						send("{R*{x [target.raceColor(target.name)] has ducked under your [attack]!",user)
						send("{W*{x [target.raceColor(target.name)] has ducked under [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
						target.atkDat:defense = FALSE;
						return TRUE;
					}
				}

				if((JUMP in c.defenses)){
					if(isnpc(target) && (JUMP in c.defenses) && prob(target:defenceChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "jump", list());
					}
					if(target.chkDef(/atkDatum/jump) && !checkUIAttack(user,target)){
						target._doEnergy(1)
						send("{B*{x You have jumped over [user.raceColor(user.name)]'s [attack]!",target)
						send("{R*{x [target.raceColor(target.name)] has jumped over your [attack]!",user)
						send("{W*{x [target.raceColor(target.name)] has jumped over [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
						target.atkDat:defense = FALSE;
						return TRUE;
					}
				}

				if((SWEEP in c.defenses)){
					if(target.chkDef(/atkDatum/sweep)){
						send("{B*{x You have swept under [user.raceColor(user.name)]'s [attack]!",target)
						send("{R*{x [target.raceColor(target.name)] has swept under your [attack]!",user)
						send("{W*{x [target.raceColor(target.name)] has swept under [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
						return TRUE;
					}
				}

				if((SPIN_KICK in c.defenses)){
					if(target.chkDef(/atkDatum/spin_kick)){
						send("{B*{x You have jumped over [user.raceColor(user.name)]'s [attack]!",target)
						send("{R*{x [target.raceColor(target.name)] has jumped over your [attack]!",user)
						send("{W*{x [target.raceColor(target.name)] has jumped over [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
						return TRUE;
					}
				}

				if((ABSORB in c.defenses)){
					if(isnpc(target) && (ABSORB in c.defenses) && prob(target:defenceKiChance) && !(target:getStatus() in list("unconscious","stunned","sleeping"))){
						alaparser.parse(target, "absorb", list());
					}
					if(target.chkDef(/atkDatum/absorb)){
						send("{B*{x You have absorbed [user.raceColor(user.name)]'s [attack]!",target)
						send("{R*{x [target.raceColor(target.name)] has absorbed your [attack]!",user)
						send("{W*{x [target.raceColor(target.name)] has absorbed [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
						target.atkDat:defense = FALSE;
						if(kiAttack)
							target._doEnergy(kiAttack:enPerTick*kiAttack:chCount)
							target._doDamage(ret_percent(10,kiAttack:powerRating))
						return TRUE;
					}
				}

				if(c.tType == MELEE && target.barrier || c.tType == ENERGY && target.barrier || target.chkDef(/atkDatum/barrier)){
					user._doEnergy(-1)
					target._doEnergy(-4)

					if(target.barrier && checkBreakBarrier(user,target,damage,attack)){
						target.barrier = FALSE;
						target.atkDat:defense = FALSE;

						return FALSE;
					}

					send("{B*{x You have shielded [user.raceColor(user.name)]'s [attack]!",target)
					send("{R*{x [target.raceColor(target.name)] has shielded against your [attack]!",user)
					send("{W*{x [target.raceColor(target.name)] has shielded against [user.raceColor(user.name)]'s [attack]!",a_oview_extra(0,target,user))
					if(kiAttack)
						target._doDamage(ret_percent(2,kiAttack:powerRating))
					return TRUE;
				}
			}

			return FALSE;
		}

		doDamage(mob/target, min, max, attack, Command/Technique/c, kiAttack=NULL){

			var/fTimer/srcTimer = fightTimers["[target.ID]"];
			var/fTimer/tarTimer = target.fCombat.fightTimers["[mobRef:ID]"];

			if(target.unconscious && !c.canFinish){
				send("You can't attack [target.raceColor(target.name)], you must finish [target.determineSex(2)]!",mobRef)
				return FALSE;
			}

			if(isnpc(target) && !target:hostile || mobRef:fCombat.checkAlly(target) && mobRef != target || target.fCombat.hostileTargets.len && !mobRef:fCombat.findAlly(target) && mobRef != target){
				send("You can't attack [target.raceColor(target.name)]!",mobRef)
				return FALSE;
			}

			var/damage = cround((rand_decimal(min,max)*mobRef:currpl/100))

			if(c && c.tType == MELEE){
				damage = cround(clamp((damage + ret_percent(mobRef:calcBonusDamage(),damage)) - ret_percent(calcDefense(target),damage), 1, (damage + ret_percent(mobRef:calcBonusDamage(),damage))))
			}else if(c){
				damage = cround(clamp((damage + ((ret_percent(mobRef:calcBonusDamage(),damage)) / 2) - (ret_percent(calcDefense(target),damage) / 3)), 1, (damage + ret_percent(mobRef:calcBonusDamage(),damage))))
			}

			if(comboCount.Find("[target.ID]") && comboCount["[target.ID]"] > 4){
				damage = cround(clamp(cround(damage / comboCount["[target.ID]"]), 1, damage))
			}

			if(!doDefense(attack,mobRef,target,c,kiAttack,damage)){

				if(BROKEN_DEFENSE){
					if(isnpc(target) && isplayer(mobRef)){
						damage = cround((damage / 2));
					}else{
						damage = cround((damage / 3));
					}

					BROKEN_DEFENSE = FALSE;
				}

				damageMessage(target,cround(damage),attack)
				target.powering = FALSE;

				if(!target.isSafe() && !mobRef:isSafe()){
					if(!(target in mobRef:fCombat.hostileTargets)){mobRef:fCombat.addHostile(target)}
					if(srcTimer) srcTimer.updateTime(fightTimerDefault);
					if(tarTimer) tarTimer.updateTime(fightTimerDefault);
					target.severeTail(damage)
					target._doDamage(-damage)
					target._doEnergy(-3)
					if(isplayer(target) && target:spacePod && (target in target:spacePod:passengers)){target:spacePod:destroy(mobRef,c.name)}
					if(prob((fightOffenseGainChance + 3))){mobRef:gainPL(ret_percent((offenseGainPercent / 2),mobRef:getMaxPL()),target)}
					target.death(mobRef,c)
				}

				if(target.kiAttk){ target.cancelKi() }

				return TRUE;
			}else{
				return FALSE;
			}
		}

		buildCombo(mob/target,zanzoken=FALSE){
			var
				combolst[] = list();
				comboAbleSkills[] = list();

			for(var/c in mobRef:techniques){
				var/Command/Technique/cmd = new c()
				if(cmd.comboAble){
					if(cmd.comboOptions){
						comboAbleSkills.Add("[pick(cmd.comboOptions)][cmd.comboName]")
					}else{ comboAbleSkills.Add(cmd.comboName) }
				}
			}

			if(zanzoken){ combolst.Add("zw"); }

			var/comboAmount = rand(2,4);

			for(var/i=0,i<comboAmount){
				combolst.Add(pick(comboAbleSkills));

				i++;
			}

			comboList += list("[target.ID]" = combolst)
			comboCount += list("[target.ID]" = 1)


			send("Combination! {B({x [view_list(comboList["[target.ID]"],"combo",mobRef)] {B){x",mobRef)
		}

		addHostile(mob/target){
			hostileTargets.Add(target)
			fightTimers.Add(list("[target.ID]" = new /fTimer(mobRef,target)))

			if(!(mobRef in target.fCombat.hostileTargets)){
				target.fCombat.addHostile(mobRef)
			}

			if(isnpc(target) && !target:AI){
				target:AI = new /aiDatum(target)
				target:AI:start()
			}

			if(isnpc(mobRef) && !mobRef:AI){
				mobRef:AI = new /aiDatum(mobRef)
				mobRef:AI:start()
			}

		}

		removeHostile(mob/target){
			var/fTimer/timer = fightTimers["[target.ID]"];
			fightTimers.Remove("[target.ID]");
			hostileTargets.Remove(target)
			if(target == _getLastTarget()){
				if(length(hostileTargets) > 0){
					lastTarget = pick(hostileTargets);
				}else{
					lastTarget = NULL;
				}
			}
			if(timer) timer.end();
		}

		addAlly(mob/target){
			alliedTargets.Add(target)
			if(!(mobRef in target.fCombat.alliedTargets)){
				target.fCombat.addAlly(mobRef)
			}
		}

		removeAlly(mob/target){
			alliedTargets.Remove(target)
		}

		findAlly(mob/target){
			for(var/mob/t in target.fCombat.hostileTargets){
				if(checkAlly(t)){
					return TRUE;
				}
			}
			return FALSE;
		}

		checkAlly(mob/target){
			if(target in alliedTargets){
				return TRUE;
			}
			else{
				return FALSE;
			}
		}
