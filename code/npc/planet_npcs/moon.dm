mob
	NPA
		moon

			Baby_Clone
				name = "Baby Clone"
				race = ANDROID
				form = "npc_replica";
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = GOD;
				currpl = 675.00e+012;
				maxpl = 675.00e+012;
				curreng = 500
				maxeng = 500
				bonus_str = 950;
				bonus_arm = 950;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken, /Command/Technique/pulse, /Command/Technique/eye_laser, /Command/Technique/gack)

				visuals = list("skin_color" = "{CPale Blue{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Short",
								"build" = "Toned")

				dropList = list(/obj/item/ANDROID_PART/ANDROID_ARM, /obj/item/ANDROID_PART/ANDROID_LEG, /obj/item/ANDROID_PART/ANDROID_EYE, /obj/item/ANDROID_PART/ANDROID_SERVO, /obj/item/ANDROID_PART/ANDROID_ACTUATOR)

			Baby_Imperfect
				name = "Infused Baby Clone"
				race = ANDROID
				form = "npc_replica";
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = GOD;
				currpl = 8225.00e+015;
				maxpl = 8225.00e+015;
				curreng = 500
				maxeng = 500
				bonus_str = 1750;
				bonus_arm = 1750;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken, /Command/Technique/pulse, /Command/Technique/eye_laser, /Command/Technique/gack)

				visuals = list("skin_color" = "{yLight Tan{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Muscular")
				dropList = list(/obj/item/ANDROID_PART/ANDROID_ARM, /obj/item/ANDROID_PART/ANDROID_LEG, /obj/item/ANDROID_PART/ANDROID_EYE, /obj/item/ANDROID_PART/ANDROID_SERVO, /obj/item/ANDROID_PART/ANDROID_ACTUATOR)

			Baby_Overclocked
				name = "Neo Machine Baby Clone"
				race = ANDROID
				form = "npc_replica2";
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = GOD;
				currpl = 1825.00e+017;
				maxpl = 1825.00e+017;
				curreng = 600
				maxeng = 600
				bonus_str = 2550;
				bonus_arm = 2550;
				randomRespawn = FALSE;
				dropList = list(/obj/item/DR_MYUU_INSIGNIA, /obj/item/ANDROID_PART/ANDROID_ARM, /obj/item/ANDROID_PART/ANDROID_LEG, /obj/item/ANDROID_PART/ANDROID_EYE, /obj/item/ANDROID_PART/ANDROID_SERVO, /obj/item/ANDROID_PART/ANDROID_ACTUATOR)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken, /Command/Technique/pulse, /Command/Technique/eye_laser, /Command/Technique/gack)

				visuals = list("skin_color" = "{yLight Tan{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Muscular")


			Hyper_Baby_Overclocked
				name = "Hyper Neo Machine Baby"
				race = ANDROID
				form = "npc_replica2";
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = GOD;
				currpl = 2825.00e+018;
				maxpl = 2825.00e+018;
				curreng = 700
				maxeng = 700
				bonus_str = 2750;
				bonus_arm = 2750;
				randomRespawn = FALSE;
				dropList = list(/obj/item/NEO_TECH_BLINDFOLD, /obj/item/ANDROID_PART/ANDROID_ARM, /obj/item/ANDROID_PART/ANDROID_LEG, /obj/item/ANDROID_PART/ANDROID_EYE, /obj/item/ANDROID_PART/ANDROID_SERVO, /obj/item/ANDROID_PART/ANDROID_ACTUATOR)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken, /Command/Technique/pulse, /Command/Technique/eye_laser, /Command/Technique/gack)

				visuals = list("skin_color" = "{yLight Tan{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Muscular")

			DrMyuu
				name = "Dr. Myuu";
				race = ANDROID;
				hostile = FALSE;
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = INSANE;
				currpl = 1500000;
				maxpl = 1500000;
				curreng = 1000;
				maxeng = 1000;
				randomRespawn = FALSE;

				visuals = list("skin_color" = "{DPale{x",
								"eye_color" = "{BBlue{x",
								"hair_length" = "BALD",
								"hair_style" = "Moustache",
								"hair_color" = "{yOrange{x",
								"height" = "Average",
								"build" = "Frail")
				event_entered(mob/M) {
					set waitfor = FALSE;
					set background = TRUE;
					sleep(5)
					if(M.loc == src.loc) {
						send("{cDr. Myuu looks at you.{x",M)
						send("{cDr. Myuu looks at [M].{x",_ohearers(0,M))

						if(M.race == 4) {
							alaparser.parse(src,"say Ahhh, [M]. Say 'Experiment on Me' and I will give you neverending power!",list());
						} else if(M.race == 22) {
							alaparser.parse(src,"say Ahhh, [M]. My wonderful creation. Say 'Experiment on me' if you want to hear your options.",list());
						} else {
							alaparser.parse(src,"say you do not interest me at all, [M].",list());
						}
					}
				}

				event_say(mob/M, var/text) {
					set waitfor = FALSE;
					set background = TRUE;

					if(lowertext(text) == "overclock me") {
						if(M.race == 22 && !M.hasSkill("overclock")) {
							if(M.labcredits >= 150) {
								alaparser.parse(src,"say Let me just flip this switch and install a new chip in you.",list());
								sleep(3);
								send("{D...",M);
								sleep(3);
								send("{D...",M);
								sleep(3);
								send("{R.....",M);
								sleep(3);
								send("{D...",M);
								sleep(3);
								send("{D...",M);
								sleep(3);
								send("{D...",M);
								sleep(3);
								send("{R.....",M);
								sleep(3);
								send("{D...",M);
								sleep(3);
								send("{D...",M);
								sleep(3);
								send("{G..........",M);
								sleep(30);
								if(M.loc == src.loc) {
									send("{D\[SYSTEM\] Your system is being reinitialated.",M);
									sleep(5);
									send("{D\[SYSTEM\] Running System diagnostics.",M);
									sleep(5);
									send("{D\[SYSTEM\] New CPU installed and running optimally.",M);
									M.labcredits -= 150;
									M.learnSkill("overclock",TRUE);
								}
							} else {
								alaparser.parse(src,"say You do not have enough lab credits, [M]. Come back when you have 150.",list());
							}
						} else {
							alaparser.parse(src,"say I have nothing for you, [M].",list());
						}
					}

					if(lowertext(text) == "experiment on me") {
						if(M.race != 4) {
							if(M.race == 22) {
								alaparser.parse(src,"say I think you might be ready, [M]. Would you like me to upgrade your form?",list());
								alaparser.parse(src,"say It will cost 150 Lab Credits. If yes, say overclock me",list());
							} else {
								alaparser.parse(src,"say you do not interest me at all, [M].",list());
							}
						} else {
							if(M.labcredits > 50) {
								if(M.currpl >= 50.00e+012) {
									alaparser.parse(src,"say Oh My, [M]. You look like you have potential.",list());
									alaparser.parse(src,"say It's dangerous, but I can give you tremendous power if I experiment on you.",list());
									alaparser.parse(src,"say It looks like with some tweaking, I can adapt my technology to you.",list());
									sleep(5);
									alaparser.parse(src,"say If you understand and would like for me to continue, say 'confirm experiment'.",list());
								} else {
									alaparser.parse(src,"say You do not have the powerlevel required to survive, [M]. Come back later?",list());
								}
							} else {
								alaparser.parse(src,"say You do not have enough lab credits, [M]. Come back later.",list());
							}
						}
					}

					if(lowertext(text) == "confirm experiment") {
						if(M.labcredits >= 50 && M.form == "Super Android" && M.race == 4 && M.currpl >= 50.00e+012 ) {
							alaparser.parse(src,"say Alright, [M]. I will experiment on you.",list());
							sleep(70);
							if(M.loc == src.loc) {
								alaparser.parse(src,"say It shouldn't take long. But you must remain in this room and not move.",list());
								sleep(100);
								if(M.loc == src.loc) {
									send("{YSparks start flying everywhere.",oview(0, src));
									alaparser.parse(src,"emo fires up his machines.",list());
									alaparser.parse(src,"say Your internal design is pretty inefficient. I can fix that.",list());
									sleep(100);
									if(M.loc == src.loc) {
										alaparser.parse(src,"emo looks concerned.",list());
										alaparser.parse(src,"say I think I can adapt your parts and improve them accordingly.",list());
										sleep(100);
										if(M.loc == src.loc) {
											send("{YSparks start flying everywhere.",oview(0, src));
											alaparser.parse(src,"emo wipes sweat from his brow.",list());
											alaparser.parse(src,"say Allllmost finished.",list());
											sleep(100);
											if(M.loc == src.loc) {
												alaparser.parse(src,"emo puts his tools down",list());
												alaparser.parse(src,"say All done. Now all that is left is to reboot you... fingers crossed?",list());
												sleep(50);
												send("{D... You feel your consciousness fade.",M);
												if(M.loc == src.loc) {
													sleep(3);
													send("{D...",M);
													sleep(3);
													send("{D...",M);
													sleep(3);
													send("{R.....",M);
													sleep(3);
													send("{D...",M);
													sleep(3);
													send("{D...",M);
													sleep(3);
													send("{D...",M);
													sleep(3);
													send("{R.....",M);
													sleep(3);
													send("{D...",M);
													sleep(3);
													send("{D...",M);
													sleep(3);
													send("{G..........",M);
													sleep(30);
													if(M.loc == src.loc) {
														send("{D\[SYSTEM\] Your system is being reinitialated.",M);
														sleep(5);
														send("{D\[SYSTEM\] Running System diagnostics.",M);
														sleep(5);
														send("{D\[SYSTEM\] Detected incompatible system. Attempting to compensate.",M);
														if(M.loc == src.loc) {
															M.labcredits -= 50;

															M.form = "NeoMachine";
															M.race = REMORT_ANDROID;
															M.maxpl = 150;
															M.currpl = M.getMaxPL();
															M.maxeng = 150;
															M.curreng = M.getMaxEN();

															M.techniques = list();
															var/list/startingSkills = list(/Command/Technique/fly,
																					/Command/Technique/punch,
																					/Command/Technique/kick,
																					/Command/Technique/roundhouse,
																					/Command/Technique/sweep,
																					/Command/Technique/parry,
																					/Command/Technique/jump,
																					/Command/Technique/duck,
																					/Command/Technique/dodge,
																					/Command/Technique/absorb,
																					/Command/Technique/barrier,
																					/Command/Technique/deflect,
																					/Command/Technique/upgrade,
																					/Command/Technique/sense,
																					/Command/Technique/scan,
																					/Command/Technique/power,
																					/Command/Technique/snapneck,
																					/Command/Technique/burst)

															fixSkills(M, startingSkills);

															M.loc=locate(25,222,1)

															send(buildMap(M,SMAP_LEFT,SMAP_RIGHT,SMAP_TOP,SMAP_BOT),M)

															send("{cYour system is initialized...{x", M);
															send("{CPlease {RRELOG{C to fix your skill tree...{x", M);
														}
													}
												}
											}
										}
									}
								}
							}
						} else {
							alaparser.parse(src,"say You need to be super android and/or do not have enough lab credits, [M]. Come back later.",list());
						}
					}
				}

			proc/fixSkills(mob/M, list/skills){
				for(var/i=1,i<skills.len + 1,i++){
					if(!(skills[i] in techniques)){
						M.techniques += skills[i]
					}
				}
			}

