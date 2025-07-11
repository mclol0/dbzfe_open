mob
	NPA
		proc
			getBonusSTR(){
				switch(difficultyLevel){
					if(VERY_EASY){
						return 0;
					}

					if(EASY){
						return 75;
					}

					if(MEDIUM){
						return 150;
					}

					if(HARD){
						return 400;
					}

					if(VERY_HARD){
						return 1000;
					}

					if(INSANE){
						return 2200;
					}

					if(FUSION){
						return 2500;
					}

					if(GOD){
						return 2650;
					}

					if(HEROIC){
						return 2625;
					}

					if(EVENT_MOB){
						return 3000;
					}
				}

				return 0;
			}


			getBonusARM(){
				switch(difficultyLevel){
					if(VERY_EASY){
						return 0;
					}

					if(EASY){
						return 75;
					}

					if(MEDIUM){
						return 250;
					}

					if(HARD){
						return 500;
					}

					if(VERY_HARD){
						return 700;
					}

					if(INSANE){
						return 1100;
					}

					if(FUSION){
						return 1200;
					}

					if(GOD){
						return 1400;
					}

					if(HEROIC){
						return 1450;
					}

					if(EVENT_MOB){
						return 1650;
					}
				}

				return 0;
			}

		var
			defenceChance = 11
			defenceKiChance = 11
			fakeChance = 5
			//failedAttacks = 0;// After so many failed attacks lets for the lulz fake at 3 seconds...because why not.
			difficultyLevel = VERY_EASY
			alliedType[] = list();
			kiAttks[] = list();
			meleeAttks[] = list("punch left","punch right","sweep","roundhouse");
			aiDatum/AI = NULL;


aiDatum
	var
		refreshTime = NULL;
		mob/NPA/mobRef;
		FAKING = FALSE;
		RUNNING = FALSE;
		LOCK_COMMANDS = FALSE;

	proc/getFakeChance(){
		switch(mobRef.difficultyLevel){
			if(VERY_EASY) return 0.00;
			if(EASY) return 10.00;
			if(MEDIUM) return 25.00;
			if(HARD) return 45.00;
			if(VERY_HARD) return 50.00;
			if(INSANE) return 50.00;
			if(FUSION) return 60.00;
			if(GOD) return 75.00;
			if(HEROIC) return 70.00;
			if(EVENT_MOB) return 70.00
		}
	}

	proc/getDefenceChance(){
		switch(mobRef.difficultyLevel){
			if(VERY_EASY) return 0.00;
			if(EASY) return 10.00;
			if(MEDIUM) return 25.00;
			if(HARD) return 35.00;
			if(VERY_HARD) return 40.00;
			if(INSANE) return 50.00;
			if(FUSION) return 65.00;
			if(GOD) return 65.00;
			if(HEROIC) return 60.00;
			if(EVENT_MOB) return 65.00;
		}
	}

	New(mob/NPA/ref){
		..()
		mobRef = ref
		mobRef.checkForm();
		mobRef.defenceChance = getDefenceChance();
		mobRef.defenceKiChance = (getDefenceChance() / 1.15);
		mobRef.fakeChance = getFakeChance();
		for(var/x in mobRef.techniques){
			var/Command/C = new x()
			if(C.tType == ENERGY){
				mobRef.kiAttks += C.name
			}

			del(C);
		}

		if(locate(/Command/Technique/uppercut) in mobRef.techniques){
			mobRef.meleeAttks += "uppercut"
		}

		if(locate(/Command/Technique/elbow) in mobRef.techniques){
			mobRef.meleeAttks += "elbow"
		}

		if(locate(/Command/Technique/hammer) in mobRef.techniques){
			mobRef.meleeAttks += "hammer"
		}
	}

	Del(){
		..()
	}

	proc

		checkFlightDensity(){
			set waitfor = FALSE;
			set background = TRUE;

			sleep(8 TICKS);

			while(src && mobRef && length(mobRef.fCombat.hostileTargets) > 0 && RUNNING){

				//while(mobRef && mobRef.kiAttk || mobRef && mobRef.checkTargeted(ENERGY) && mobRef.loc != mobRef.fCombat.lastTarget:loc){ sleep(world.tick_lag) }

				if(LOCK_COMMANDS){
					sleep(world.tick_lag);
				}else if(mobRef && mobRef.fCombat.lastTarget && mobRef.loc == mobRef.fCombat.lastTarget:loc && mobRef.density && !mobRef.fCombat.lastTarget:density && !mobRef.flying && mobRef.currpl > 100 || mobRef && mobRef.fCombat.lastTarget && mobRef.loc == mobRef.fCombat.lastTarget:loc && !mobRef.density && mobRef.fCombat.lastTarget:density && !mobRef.flying){
					alaparser.parse(mobRef, "fly", list());
				}

				sleep(world.tick_lag*5);
			}
		}

		checkTarget(){
			set waitfor = FALSE;
			set background = TRUE;

			sleep(5 TICKS)

			while(src && mobRef && length(mobRef.fCombat.hostileTargets) > 0 && RUNNING){

				if(mobRef && mobRef.difficultyLevel > EASY && percent(mobRef.curreng,mobRef.getMaxEN()) >= 70 && !mobRef.powering && percent(mobRef.currpl,mobRef.getMaxPL()) < 60){alaparser.parse(mobRef, "power up", list());}

				if(mobRef && mobRef.powering && percent(mobRef.curreng,mobRef.getMaxEN()) <= 50 && mobRef.fCombat.lastTarget && mobRef.loc == mobRef.fCombat.lastTarget:loc){alaparser.parse(mobRef, "power stop", list());}

				//while(mobRef && mobRef.kiAttk || mobRef && mobRef.checkTargeted(ENERGY) && mobRef.loc != mobRef.fCombat.lastTarget:loc){ sleep(world.tick_lag) }

				if(LOCK_COMMANDS){
					sleep(world.tick_lag);
				}else if(mobRef && mobRef.fCombat.lastTarget && !mobRef.atkDat && mobRef.loc != mobRef.fCombat.lastTarget:loc && !mobRef.flying && mobRef.currpl > 100){
					if(mobRef.density){alaparser.parse(mobRef, "fly", list());}
					alaparser.parse(mobRef, "fly [mobRef.fCombat.lastTarget:name]", list());
				}

				sleep(world.tick_lag);
			}

			if(mobRef && !mobRef.fCombat.hostileTargets.len){
				reset();
				RUNNING = FALSE;
			}
		}

		reset(relocate=TRUE){
			if(mobRef){
				if (relocate)
					mobRef.loc=locate(mobRef.startx,mobRef.starty,mobRef.startz);

				mobRef.flying=NULL;
				mobRef.lFlyT=NULL;
				mobRef.unconscious=FALSE;
				mobRef.stunned=FALSE;
				mobRef.density=TRUE;
				mobRef.currpl=mobRef.getMaxPL();
				mobRef.curreng=mobRef.getMaxEN();
				mobRef.AI = NULL;
			}
		}

		_matchPL(mod=0.45) {
			var/enemyMaxPl = mobRef.fCombat.lastTarget:getPotentialMaxPL()
			if(mobRef && mobRef.fCombat.lastTarget && enemyMaxPl > mobRef.maxpl){
				var/targetPl = enemyMaxPl*mod
				mobRef.maxpl = targetPl;
				mobRef.currpl = mobRef.getMaxPL();
			}
		}

		start(){
			set waitfor = FALSE;
			set background = TRUE;

			var
				fakeCount = fakeDifficulty(mobRef.difficultyLevel);
				cFake = 0;
				fakeTime = 0;

			checkFlightDensity();
			checkTarget();

			refreshTime = (world.time + 1 SECONDS);

			if(mobRef.difficultyLevel == EVENT_MOB){
				_matchPL()			}

			RUNNING = TRUE;

			sleep(5); // AI initial delay.

			while(RUNNING && src && mobRef){

				if(mobRef && !mobRef.fCombat.hostileTargets.len){
					reset();
					RUNNING = FALSE;
				}

				if(mobRef && istype(mobRef,/mob/NPA/HOUSESYSTEM/TrainingBot) && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:unconscious){
					if (mobRef.fCombat.lastTarget:trainingConsole) {
						mobRef.fCombat.lastTarget:loseConsciousness(MSG_BOT_BEATEN)
					}
				}

				if(mobRef && mobRef.fCombat.lastTarget && !mobRef.resting && mobRef.fCombat.lastTarget:stunned && !mobRef.fCombat.comboList["[mobRef.fCombat.lastTarget:ID]"] && mobRef.curreng < 50){
					alaparser.parse(mobRef, "rest", list());
					while(mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:stunned){ sleep(world.tick_lag); }
				}

				if(mobRef && mobRef.resting && mobRef.loc == mobRef.fCombat.lastTarget:loc || mobRef && mobRef.resting && mobRef.fCombat.lastTarget:loc != mobRef.loc && mobRef.curreng > 50){
					alaparser.parse(mobRef, "wake", list());
				}

				if(prob(20) && mobRef && mobRef.fCombat.lastTarget && !mobRef.checkTargeted() && length(mobRef.kiAttks) > 0 && mobRef.curreng > 40 && !cooldownLen(mobRef.name) && mobRef.difficultyLevel > EASY || prob(40) && mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:kiAttk && !mobRef.checkTargeted() && length(mobRef.kiAttks) > 0 && mobRef.curreng > 40 && !cooldownLen(mobRef.name) && mobRef.difficultyLevel > EASY){
					/* GOTO DIFF ROOM? */
					var/dir = pick("n","s","e","w");
					if(mobRef.density){ alaparser.parse(mobRef, "fly", list()); }
					alaparser.parse(mobRef, "fly 5 [dir]", list());
					/* GOTO DIFF ROOM? */

					LOCK_COMMANDS = TRUE;

					/* CHARGE OUR ATTACK? */
					var/kiAttkx = pick(mobRef.kiAttks);
					alaparser.parse(mobRef, "[kiAttkx] [mobRef.fCombat.lastTarget:name]", list());
					while(mobRef.kiAttk && mobRef.kiAttk.chCount < mobRef.kiAttk.mnCh) { sleep(world.tick_lag); }
					alaparser.parse(mobRef, "yell ARE YOU READY FOR THIS!?", list())
					sleep(rand(5,15));
					alaparser.parse(mobRef, "[kiAttkx] [mobRef.fCombat.lastTarget:name]", list());
					/* CHARGE OUR ATTACK? */

					LOCK_COMMANDS = FALSE;
				}else if(mobRef && mobRef.fCombat.lastTarget && length(mobRef.kiAttks) > 0 && mobRef.fCombat.lastTarget:stunned && mobRef.curreng > 40 && !cooldownLen(mobRef.name) && mobRef.difficultyLevel > EASY){
					while(mobRef.atkDat) { sleep(world.tick_lag); }

					LOCK_COMMANDS = TRUE;

					/* GOTO DIFF ROOM? */
					var/dir = pick("n","s","e","w");
					if(mobRef.density){ alaparser.parse(mobRef, "fly", list()); }
					alaparser.parse(mobRef, "fly 5 [dir]", list());
					/* GOTO DIFF ROOM? */

					/* CHARGE OUR ATTACK? */
					var/kiAttkx = pick(mobRef.kiAttks);
					alaparser.parse(mobRef, "[kiAttkx] [mobRef.fCombat.lastTarget:name]", list());
					while(mobRef.kiAttk && mobRef.kiAttk.chCount < mobRef.kiAttk.mnCh) { sleep(world.tick_lag); }
					alaparser.parse(mobRef, "yell ARE YOU READY FOR THIS!?", list())
					sleep(rand(5,15));
					alaparser.parse(mobRef, "[kiAttkx] [mobRef.fCombat.lastTarget:name]", list());
					/* CHARGE OUR ATTACK? */

					LOCK_COMMANDS = FALSE;
				}

				sleep(8); // Delay before starting a new attack loop;

				if(src && mobRef){

					if(mobRef && !mobRef.fCombat.lastTarget && length(mobRef.fCombat.hostileTargets) > 0){
						mobRef.fCombat.lastTarget = pick(mobRef.fCombat.hostileTargets)
					}

					if(mobRef && mobRef.fCombat.lastTarget){
						mobRef.simultaneous = mobRef.fCombat.lastTarget:simultaneous
					}

					while(mobRef && mobRef.checkTargeted(ENERGY) && mobRef.loc != mobRef.fCombat.lastTarget:loc){ sleep(world.tick_lag) }

					if(mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:unconscious && mobRef.difficultyLevel > EASY){
						alaparser.parse(mobRef, "yell [pick("YOU MADE THIS TOO EASY!","LATER KID!")]", list())
						alaparser.parse(mobRef, "snapneck [mobRef.fCombat.lastTarget:name]", list());
					}else if(mobRef && mobRef.fCombat.lastTarget && (/Command/Technique/timeskip in mobRef.techniques) && a_get_dist(mobRef,mobRef.fCombat.lastTarget) <= 14 && a_get_dist(mobRef,mobRef.fCombat.lastTarget) >= 1){
						alaparser.parse(mobRef, "timeskip [mobRef.fCombat.lastTarget:name]", list());
					}else if(mobRef && mobRef.fCombat.lastTarget && (/Command/Technique/elbow in mobRef.techniques) && a_get_dist(mobRef,mobRef.fCombat.lastTarget) <= 8 && a_get_dist(mobRef,mobRef.fCombat.lastTarget) >= 1){
						alaparser.parse(mobRef, "elbow [mobRef.fCombat.lastTarget:name]", list());
						alaparser.parse(mobRef, "yell HERE I COME!", list())
					}else if(mobRef && mobRef.fCombat.lastTarget && mobRef.loc == mobRef.fCombat.lastTarget:loc){
						if(mobRef.density && mobRef.fCombat.lastTarget:density || !mobRef.density && !mobRef.fCombat.lastTarget:density){

							if(mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:stunned){
								if((locate(/Command/Technique/blast) in mobRef.techniques) && prob(25)){
									alaparser.parse(mobRef, "blast [mobRef.fCombat.lastTarget:name]", list());
									while(mobRef.kiAttk){sleep(world.tick_lag)}
								}else if((locate(/Command/Technique/drain) in mobRef.techniques) && prob(60)){
									alaparser.parse(mobRef, "drain [mobRef.fCombat.lastTarget:name]", list());
									while(mobRef.atkDat){sleep(world.tick_lag)}
								}else if((locate(/Command/Technique/self_destruct) in mobRef.techniques) && prob(50) && percent(mobRef.currpl,mobRef.getMaxPL()) <= 30.00){
									alaparser.parse(mobRef, "selfdestruct [mobRef.fCombat.lastTarget:name]", list());
									while(mobRef.atkDat){sleep(world.tick_lag)}
								}else if((locate(/Command/Technique/fury) in mobRef.techniques) && prob(50)){
									alaparser.parse(mobRef, "fury [mobRef.fCombat.lastTarget:name]", list());
									while(mobRef.atkDat){sleep(world.tick_lag)}
								}else if(!mobRef.fCombat.lastTarget:density && (locate(/Command/Technique/hammer) in mobRef.techniques) && prob(75) && !mobRef.fCombat.comboList["[mobRef.fCombat.lastTarget:ID]"]){
									alaparser.parse(mobRef, "hammer [mobRef.fCombat.lastTarget:name]", list());
									while(mobRef.atkDat){sleep(world.tick_lag)}
								}else if((locate(/Command/Technique/siphon) in mobRef.techniques) && prob(60)){
									alaparser.parse(mobRef, "siphon [mobRef.fCombat.lastTarget:name]", list());
									while(mobRef.atkDat){sleep(world.tick_lag)}
								}
							}

							if(mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:atkDat && mobRef.fCombat.lastTarget:atkDat:type == /atkDatum/roundhouse){
								alaparser.parse(mobRef, "sweep [mobRef.fCombat.lastTarget:name]", list());
								while(mobRef.atkDat){sleep(world.tick_lag)}
							}

							if(mobRef && mobRef.fCombat.lastTarget && mobRef.techniques.Find(/Command/Technique/spin_kick) && mobRef.fCombat.lastTarget:atkDat && mobRef.fCombat.lastTarget:atkDat:type == /atkDatum/sweep){
								alaparser.parse(mobRef, "spinkick [mobRef.fCombat.lastTarget:name]", list());
								while(mobRef.atkDat){sleep(world.tick_lag)}
							}

							if(mobRef && mobRef.fCombat.lastTarget && mobRef.difficultyLevel > EASY){
								while(src && mobRef && mobRef.fCombat.lastTarget:stunned && mobRef.fCombat.comboList["[mobRef.fCombat.lastTarget:ID]"]){
									var/comboL[] = mobRef.fCombat.comboList["[mobRef.fCombat.lastTarget:ID]"]

									if(!mobRef.shyouken && mobRef.techniques.Find(/Command/Technique/shyouken)){
										alaparser.parse(mobRef, "shyouken", list());
									}

									if(mobRef.techniques.Find(/Command/Technique/Form/kaioken) && !(mobRef.form in list("Kaioken x2", "Kaioken x3", "Kaioken x4")) && mobRef.curreng > 60){
										alaparser.parse(mobRef, "kaioken 4", list());
									}

									if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "lp"){
										alaparser.parse(mobRef, "punch left [mobRef.fCombat.lastTarget:name]", list());
									}
									else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "rp"){
										alaparser.parse(mobRef, "punch right [mobRef.fCombat.lastTarget:name]", list());
									}
									else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "r"){
										alaparser.parse(mobRef, "roundhouse [mobRef.fCombat.lastTarget:name]", list());
									}
									else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "s"){
										alaparser.parse(mobRef, "sweep [mobRef.fCombat.lastTarget:name]", list());
									}
									else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "ham"){
										alaparser.parse(mobRef, "hammer [mobRef.fCombat.lastTarget:name]", list());
									}
									else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "up"){
										alaparser.parse(mobRef, "uppercut [mobRef.fCombat.lastTarget:name]", list());
									}
									else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "zw"){
										alaparser.parse(mobRef, "zanzoken [mobRef.fCombat.lastTarget:name]", list());
									}
									else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "ts"){
										alaparser.parse(mobRef, "tailstab [mobRef.fCombat.lastTarget:name]", list());
									}else if(comboL[mobRef.fCombat.comboCount["[mobRef.fCombat.lastTarget:ID]"]] == "el"){
										alaparser.parse(mobRef, "elbow [mobRef.fCombat.lastTarget:name]", list());
									}

									sleep(pick(0.3 SECONDS, 0.6 SECONDS))
								}
							}

							if(mobRef && mobRef.techniques.Find(/Command/Technique/Form/kaioken) && (mobRef.form in list("Kaioken x2", "Kaioken x3", "Kaioken x4", "Super Kaioken"))){
								alaparser.parse(mobRef, "revert", list());
							}

							if(!FAKING && prob(mobRef.fakeChance) && !mobRef.fCombat.lastTarget:stunned && !mobRef.fCombat.lastTarget:checkLocked(TRUE) && percent(mobRef.curreng,mobRef.getMaxEN()) > 30){
								FAKING = TRUE;
								fakeTime = world.time;
								cFake = rand(2,fakeCount);
								while(mobRef && mobRef.fCombat.lastTarget && FAKING){
									if(world.time >= fakeTime){
										alaparser.parse(mobRef, "[pick(mobRef.meleeAttks)] [mobRef.fCombat.lastTarget:name]", list());
										cFake--;
										fakeTime = (world.time + pick(1.5 SECONDS, 2.0 SECONDS, 2.8 SECONDS))
									}
									if(cFake < 1 || mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:checkLocked(TRUE) || mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:stunned){
										FAKING = FALSE;
									}
									sleep(world.tick_lag);
								}
							}else{
								alaparser.parse(mobRef, "[pick(mobRef.meleeAttks)] [mobRef.fCombat.lastTarget:name]", list());
							}
						}else{
							if(!mobRef.resting && !mobRef.powering && mobRef.curreng < 50){
								alaparser.parse(mobRef, "rest", list());
							}

							if(!mobRef.resting && mobRef.curreng >= 20 && percent(mobRef.currpl,mobRef.getMaxPL()) < 60){
								alaparser.parse(mobRef, "power up", list());
							}

							if(mobRef.powering && mobRef.curreng < 45){
								alaparser.parse(mobRef, "power stop", list());
							}
						}
					}

					while(mobRef && mobRef.atkDat || mobRef && mobRef.kiAttk || mobRef && mobRef.stunned || mobRef && mobRef.fCombat.lastTarget && mobRef.fCombat.lastTarget:checkTargeted()){ sleep(world.tick_lag) }
				}
				sleep(world.tick_lag)
			}

			del(src);
		}