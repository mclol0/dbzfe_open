mob
	proc/learnSkill(skName){
		techniques.Add(game.skillList[skName]);

		updateCommands = TRUE;
	}

	NPA
		proc
			random_roam(){
				set waitfor=FALSE;
				var/direction = NULL;

				while(src){
					if(!AI){
						direction = pick("north","south","east","west");
						curreng = getMaxEN();

						switch(direction){
							if("north"){
								alaparser.parse(src,"fly north",list());
							}

							if("south"){
								alaparser.parse(src,"fly south",list());
							}

							if("east"){
								alaparser.parse(src,"fly east",list());
							}

							if("west"){
								alaparser.parse(src,"fly west",list());
							}
						}
					}

					sleep(8 SECONDS);
				}
			}

			start_event(){
				switch(race){
					if(NAMEK){
						var/planet/area = get_area("namek")

						if(area){
							warpArea(rand(1,area.dx),rand(1,area.dy),area)
							send("{Y\[{x{GEVENT{x{Y\]{x [raceColor(name)] is now roaming planet {gNamek{x!",game.players,TRUE);
							startx=src.x
							starty=src.y
							startz=src.z
							random_roam();
						}
					}

					if(KAIO){
						var/planet/area = get_area("kaishin")

						if(area){
							warpArea(rand(1,area.dx),rand(1,area.dy),area)
							send("{Y\[{x{GEVENT{x{Y\]{x [raceColor(name)] is now roaming planet {DKaishin{x!",game.players,TRUE);
							startx=src.x
							starty=src.y
							startz=src.z
							random_roam();
						}
					}

					if(ICER){
						var/planet/area = get_area("frieza")

						if(area){
							warpArea(rand(1,area.dx),rand(1,area.dy),area)
							send("{Y\[{x{GEVENT{x{Y\]{x [raceColor(name)] is now roaming planet {MFrieza{x!",game.players,TRUE);
							startx=src.x
							starty=src.y
							startz=src.z
							random_roam();
						}
					}

					if(SAIYAN){
						var/planet/area = get_area("vegeta")

						if(area){
							warpArea(rand(1,area.dx),rand(1,area.dy),area)
							send("{Y\[{x{GEVENT{x{Y\]{x [raceColor(name)] is now roaming planet {cVegeta{x!",game.players,TRUE);
							startx=src.x
							starty=src.y
							startz=src.z
							random_roam();
						}
					}

					if(DIETY){
						var/planet/area = get_area("earth")

						if(area){
							warpArea(rand(1,area.dx),rand(1,area.dy),area)
							send("{Y\[{x{GEVENT{x{Y\]{x [raceColor(name)] is now roaming planet {YEarth{x!",game.players,TRUE);
							startx=src.x
							starty=src.y
							startz=src.z
							random_roam();
						}
					}

					if(ALIEN){
						var/planet/area = get_area("arlia")

						if(area){
							warpArea(rand(1,area.dx),rand(1,area.dy),area)
							send("{Y\[{x{GEVENT{x{Y\]{x [raceColor(name)] is now roaming planet {rArlia{x!",game.players,TRUE);
							startx=src.x
							starty=src.y
							startz=src.z
							random_roam();
						}
					}
				}
			}

			aggroPlayer(mob/M){
				if(src == M){ return FALSE; } // temp fix for code changes last night 9/20 2:00 AM?

				if(src && M && !src.isSafe() && !M.isSafe() && !src.fCombat.hostileTargets.len && !M.fCombat.hostileTargets.len){
					M:fCombat.lastTarget = src
					src.fCombat.lastTarget = M
					if(!(M in src.fCombat.hostileTargets)){src.fCombat.addHostile(M)}
					return TRUE;
				}

				return FALSE;
			}

			growSenzu(){
				set waitfor = FALSE;

				var
					harvestTime = 30 MINUTES;

				while(src){
					sleep(harvestTime);
					var/korinsStock = shop.itemQuantity("/mob/NPA/korins/Korin","/obj/item/SENZU_BEAN");
					if(korinsStock < 10){
						shop.updateItem("/mob/NPA/korins/Korin","/obj/item/SENZU_BEAN",1,FALSE);
					}
				}

			}

			checkSale(){
				set waitfor = FALSE;

				var
					checkTime = (world.time + 4 HOURS);

				while(src){
					sleep(checkTime)

					if(!src.shopSale){
						src.shopSale = TRUE;
						checkTime = (world.time + 30 MINUTES);
					} else {
						src.shopSale = FALSE;
						checkTime = (world.time + 4 HOURS);
					}
				}

			}

			checkForPlayers(){
				if(AGGRO){
					for(var/mob/Player/M in radius_out(0,6,src)){
						if(aggroPlayer(M)){
							break;
						}
					}
				}
			}

			regenStam(){
				set waitfor = FALSE;

				var
					goTime=(world.time + 65);

				regenStam = TRUE;

				while(src && AI && curreng < getMaxEN()){
					if(world.time>=goTime){
						if(!unconscious){
							energyMessage()
							_doEnergy(2)
						}else{
							_doEnergy(1)
						}
						goTime=(world.time+65);
					}
					sleep(world.tick_lag)
				}

				regenStam = FALSE;
			}

			regenPL(){
				set waitfor = FALSE;

				return FALSE; // Temp until we have regen for mobs i guess?

				var
					refreshTime=(world.time + 65);

				regenPL = TRUE;

				while(src && currpl < getMaxPL()){
					if(world.time >= refreshTime){
						_doDamage(ret_percent(1.00,getMaxPL()))
						refreshTime=(world.time + 65);
					}
					sleep(world.tick_lag)
				}

				regenPL = FALSE;
			}

			gainDivision(){
				switch(difficultyLevel){
					if(VERY_EASY) return 1.25;
					if(EASY) return 2.00;
					if(MEDIUM) return 3.00;
					if(HARD) return 4.00;
					if(VERY_HARD) return 5.00;
					if(INSANE) return 6.00;
					if(FUSION) return 7.00;
					if(HEROIC) return 8.00;
					if(GOD) return 9.00;
					if(EVENT_MOB) return 25.00;
				}
				return 1.25;
			}

			gainZenni(){
				var/zenniValue = 0;

				switch(difficultyLevel){
					if(VERY_EASY) zenniValue = rand(50,80);
					if(EASY) zenniValue = rand(100,150);
					if(MEDIUM) zenniValue = rand(160,250);
					if(HARD) zenniValue = rand(260,350);
					if(VERY_HARD) zenniValue = rand(500,800);
					if(INSANE) zenniValue = rand(900,1000);
					if(FUSION) zenniValue = rand(1100,1300);
					if(HEROIC) zenniValue = rand(1400,1800);
					if(GOD) zenniValue = rand(1900,2250);
					if(EVENT_MOB) zenniValue = rand(5500,7500);
				}

				return zenniValue;
			}

			checkForm()

		respawn(){
			del(src);
		}

		death(var/mob/killer as mob, var/Command/tech){
			if(tech && tech.canFinish && src.currpl <= MIN_PL) {
				if(DEAD) return

				new /obj/item/corpse(src, killer, floor((gainZenni() + ret_percent_notrunx(killer.calcBonusMF(),gainZenni()) * 1.5)))

				if(difficultyLevel == EVENT_MOB){
					send("{Y\[{x{GEVENT{x{Y\]{x [raceColor(name)] has been slain by [killer.raceColor(killer.name)]!",game.players,TRUE);
					game.addCooldown(killer.name,"teleport",15 SECONDS);
					game.addCooldown(killer.name,"instantaneousmovement", 15 SECONDS);

				}

				var/calc = ret_percent(killNPCPercent / gainDivision(),src.getMaxPL())

				send("{R*{x [src.raceColor(src.name)]{c is {x{CDEAD{x{c!{x",a_oview_extra(0,src,killer))
				send("{R*{x [src.raceColor(src.name)]{c is {x{CDEAD{x{c!{x",killer)

				if(src:teach.len > 0){
					for(var/c in src:teach){ if(isplayer(killer)){ killer:learnSkill(c) } }
				}

				event(killer, tech);

				if(isplayer(killer) && isAndroid(killer)){
					var/gainMod = 0;
					if(killer.maxpl >= (maxpl * 1.60)) {
						gainMod = game.settings.veryWeakRandGain()
					}
					else if(killer.maxpl >= (maxpl * 1.30)) {
						gainMod = game.settings.weakRandGain()
					}
					else if(killer.maxpl >= (maxpl * 0.75)) {
						gainMod = game.settings.equalRandGain()
					}
					else if(killer.maxpl >= (maxpl * 0.45)) {
						gainMod = game.settings.strongRandGain()
					} else {
						gainMod = game.settings.godlikeRandGain()
					}

					killer:gainlc(game.settings.get("lcBaseValue") * gainMod, src)
				}

				killer:gainPL(calc,src)

				if(killer && src && src.fCombat.lastTarget && killer != src.fCombat.lastTarget){ src.fCombat.lastTarget:fCombat.removeHostile(src)}
				src.fCombat.removeHostile(killer)
				killer.fCombat.removeHostile(src)
				src:fCombat.removeAlly(src)

				if(src:alliedType.len > 0){
					for(var/mob/NPA/m in src.getArea()){
						if(alliedType.Find(m.type)){
							if(m.ID != src.ID && !m.fCombat.hostileTargets.len){
								src.fCombat.addAlly(m);
							}
						}
					}
				}

				if(src.fCombat.alliedTargets.len > 0){
					for(var/mob/NPA/m in distance_order(killer,src.fCombat.alliedTargets)){
						if(!m.fCombat._hostiles()){
							m.aggroPlayer(killer);
							break;
						}
					}
				}

				emitDeath(src,ov_out(1,12,src));

				killer:pvek++

				DEAD = TRUE;

				qFac.checkKill(src,killer,killer)

				spawn() respawn()

				return TRUE;
			}

			return FALSE;
		}
