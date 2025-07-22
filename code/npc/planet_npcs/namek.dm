mob
	NPA
		namek
			FriezaHenchman
				name = "Frieza's henchman"
				race = MUTANT
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = EASY;
				curreng = 100
				maxeng = 100

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(3000,6000)
					currpl = maxpl
					..()
				}

			NamekianExplorer
				name = "Namekian Explorer"
				race = NAMEK
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				curreng = 100
				maxeng = 100

				dropList = list(/obj/item/HEAVY_NAMEKIAN_SCARF,/obj/item/SOFT_NAMEKIAN_SHOES);

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Skinny")

				New(){
					maxpl = rand(10000,15000)
					currpl = maxpl
					..()
				}

			Namekian
				name = "Namekian"
				race = NAMEK
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				curreng = 100
				maxeng = 100

				teach = list("fury");

				dropList = list(/obj/item/HEAVY_NAMEKIAN_SCARF,/obj/item/SOFT_NAMEKIAN_SHOES,/obj/item/LIGHT_TURBAN);

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Skinny")

				New(){
					maxpl = rand(20000,40000)
					currpl = maxpl
					..()
				}

			NamekianElite
				name = "Namekian Elite"
				race = NAMEK
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				curreng = 100
				maxeng = 100

				dropList = list(/obj/item/HEAVY_NAMEKIAN_SCARF,/obj/item/SOFT_NAMEKIAN_SHOES,/obj/item/HEAVY_WRISTBAND,/obj/item/LIGHT_TURBAN, /obj/item/NAMEKIAN_ELDER_ROBES);

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Skinny")

				New(){
					maxpl = rand(70000,100000)
					currpl = maxpl
					..()
				}

			Krillin
				name = "Krillin"
				race = HUMAN
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				currpl = 16500
				maxpl = 16500
				curreng = 100
				maxeng = 100
				teach = list("destructo disc", "solar flare")
				techniques = list(/Command/Technique/elbow, /Command/Technique/shyouken, /Command/Technique/blast, /Command/Technique/solar_flare,
						/Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/destructodisc, /Command/Technique/zanzoken)

				dropList = list(/obj/item/HEAVY_RED_SASH, /obj/item/KRILLINS_DESTRUCTO_DISC_BRACERS);

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")

			Gohan
				name = "Gohan"
				race = HALFBREED
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				currpl = 22500
				maxpl = 22500
				curreng = 100
				maxeng = 100
				teach = list("barrage")
				techniques = list(/Command/Technique/elbow, /Command/Technique/shyouken, /Command/Technique/blast, /Command/Technique/solar_flare,
						/Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/masenko, /Command/Technique/zanzoken)

				dropList = list(/obj/item/HEAVY_WRISTBAND,/obj/item/HEAVY_RED_SASH);

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Bowl",
								"hair_color" = "Black",
								"height" = "Short",
								"build" = "Toned")

			Goku
				name = "Goku"
				race = SAIYAN
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = HARD;
				currpl = 350000
				maxpl = 350000
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/Form/kaioken, /Command/Technique/blast, /Command/Technique/solar_flare,
						/Command/Technique/zenkai, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/kamehameha, /Command/Technique/zanzoken)
				dropList = list(/obj/item/BLACK_SASH,/obj/item/GOKUS_WEIGHTED_BOOTS,/obj/item/GOKUS_WEIGHTED_WRISTBANDS);

//				teach = list("uppercut")

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Toned")

			Vegeta
				name = "Vegeta"
				race = SAIYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = HARD;
				currpl = 250000
				maxpl = 250000
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut, /Command/Technique/final_flash, /Command/Technique/zanzoken)
				dropList = list(/obj/item/WHITE_GLOVES,/obj/item/WHITE_BOOTS)
//				teach = list("hammer","throw")

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Toned")

			Cui
				name = "Cui"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 19000
				maxpl = 19000
				curreng = 100
				maxeng = 100
				teach = list("renzoku")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/blast, /Command/Technique/zanzoken)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Toned")

			Guldo
				name = "Guldo"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 12000
				maxpl = 12000
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				teach = list("zanzoken")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Fat")

			Dodoria
				name = "Dodoria"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 21000
				maxpl = 21000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/namek/Zarbon)
				randomRespawn = FALSE;
				teach = list("elbow")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)

				visuals = list("skin_color" = "{MPink{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Fat")

			Zarbon
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="FORM 1"){
								form="FORM 1"
								maxpl=23000
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="FORM 1"){
								if(currpl < 10000){
									powering=FALSE
									form="FORM 2"
									maxpl=33000
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] transforms!",_ohearers(0,src))
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Zarbon"
				form = "FORM 1"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 23000
				maxpl = 23000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/namek/Dodoria)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)
				dropList = list(/obj/item/ZARBON_CIRCLET,/obj/item/ZARBON_EARRING)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{YGold{x",
								"hair_length" = "Long",
								"hair_style" = "Straight",
								"hair_color" = "{GGreen{x",
								"height" = "Average",
								"build" = "Toned")

			Recoome
				name = "Recoome"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 40000
				maxpl = 40000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/namek/Guldo)
				randomRespawn = FALSE;
				teach = list("throw","gack","erasercannon")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)
				dropList = list(/obj/item/KNEE_PADS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "{ROrange{x",
								"height" = "Tall",
								"build" = "Toned")


			Dende
				name = "Dende"
				race = NAMEK
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				currpl = 1000
				maxpl = 1000
				curreng = 250
				maxeng = 250
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken, /Command/Technique/telekinesis)
				teachShow = list("telekinesis");
				dropList = list(/obj/item/DENDE_HEALING_STAFF)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Average")
				New(){
					..()
					maxpl = rand(2200,2500)
					currpl = maxpl

					spawn(){
						var/goTime = (world.time + 360 SECONDS);
						while(src){
							if(world.time >= goTime){
								alaparser.parse(src,"say Would you like me to share my wisdom? Say {CTeach Me{W to see if you're worthy.");
								goTime = (world.time + 1500 SECONDS);
							}
							sleep(world.tick_lag);
						}
					}
				}

				event_say(mob/M, var/text) {
					if(lowertext(text) == "teach me") {
						if(M.race != SPIRIT) {
							sleep(1);
							send("Dende looks at you and takes a moment to ponder.",M)
							send("Dende looks at [M.name] and takes a moment to ponder.", _ohearers(0,M))
							sleep(5)
							alaparser.parse(src,"say I have nothing to teach you, [M].");
						} else {
							if(!M.hasSkill("telekinesis")) {
								sleep(1);
								send("Dende looks at you with a smile on his face.",M)
								send("Dende looks at [M.name] with a smile on his face.", _ohearers(0,M))
								sleep(5)
								alaparser.parse(src,"say Very well. You seem deserving of my knowledge, [M].");
								M.learnSkill("telekinesis",TRUE)

							} else {
								sleep(1);
								alaparser.parse(src,"say I have nothing more to teach you, [M].");
							}
						}
					}
				}



			Nail
				name = "Nail"
				race = NAMEK
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				currpl = 42500
				maxpl = 42500
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)
				teach = list("namek heal","death beam","enhancednamek")

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Toned")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Normal" && istype(killer,/mob/Player/Namekian) && tech.internal_name == "namek fuse"){
						send("{GYour union with Nail was sucessful you feel more powerful together than you could ever have been alone!{x",killer)
						killer.form = "Enhanced Namek";
					}
				}


			Burter
				name = "Burter"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = HARD;
				currpl = 45000
				maxpl = 45000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/namek/Jeice)
				randomRespawn = FALSE;
				teach = list("uppercut")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)

				visuals = list("skin_color" = "{BBlue{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

			Jeice
				name = "Jeice"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = HARD;
				currpl = 50000
				maxpl = 50000
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/namek/Burter)
				randomRespawn = FALSE;
				teach = list("hammer")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)

				visuals = list("skin_color" = "{RRed{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "{WWhite{x",
								"height" = "Average",
								"build" = "Toned")

			CaptainGinyu
				name = "Captain Ginyu"
				race = MUTANT
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = HARD;
				currpl = 120000
				maxpl = 120000
				curreng = 100
				maxeng = 100
				teach = list("spin kick","kaikosen")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken)
				dropList = list(/obj/item/GINYU_FORCE_BATTLE_ARMOR)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")


			Piccolo
				name = "Piccolo"
				race = NAMEK
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = HARD;
				currpl = 800000
				maxpl = 800000
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/specialbeamcannon, /Command/Technique/zanzoken)
				teach = list("special beam cannon","genie heal","energy mine","bio absorb", "supernamek")
				dropList = list(/obj/item/HEAVY_TURBAN,/obj/item/PICCOLOS_WEIGHTED_CAPE, /obj/item/PICCOLOS_WEIGHTED_TRAINING_GI)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

				event(mob/killer, Command/Technique/tech){
					if((killer.form in list("Normal","Enhanced Namek")) && istype(killer,/mob/Player/Namekian) && tech.internal_name == "namek fuse"){
						send("{GYour union with Piccolo was sucessful you feel more powerful together than you could ever have been alone!{x",killer)
						killer.form = "Super Namek";
					}
				}

			Namek_Shaman
				name = "Namekian Shaman"
				race = NAMEK
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = FUSION;
				currpl = 4000000
				maxpl = 4000000
				curreng = 300
				maxeng = 300
				bonus_str = 50;
				bonus_arm = 50;
				randomRespawn = FALSE;
				teach = list("focused")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/specialbeamcannon, /Command/Technique/zanzoken)
				teachShow = list("consecrate")

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")
				event(mob/killer, Command/Technique/tech){
					if(istype(killer,/mob/Player/Spirit) && tech.internal_name == "purify") {
						teach = teachShow
						killer.learnSkill("consecrate",TRUE)
					}

				}
			Frieza
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="FORM 1"){
								form="FORM 1"
								maxpl=530000
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="FORM 1"){
								if(currpl < 250000){
									form="FORM 2"
									maxpl=1000000
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] {Mgrows in height and muscle mass as he transforms!",_ohearers(0,src))
								}
							}else if(form=="FORM 2"){
								if(currpl < 500000){
									form="FORM 3"
									maxpl=2500000
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] hunches over as his head elongates and spikes erupt from his body!",_ohearers(0,src))
								}
							}else if(form=="FORM 3"){
								if(currpl < 1000000){
									form="FORM 4"
									maxpl=7000000
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] curls up into a ball and explodes from the shell of his former self!",_ohearers(0,src))
									if (teachDelayed[form]) {
										teach = teachDelayed[form]
									}
								}
							}
						}
						sleep(world.tick_lag)
					}
				}

				name = "Frieza"
				form = "FORM 1"
				race = ICER
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = INSANE;
				currpl = 530000
				maxpl = 530000
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/tail_whip, /Command/Technique/zanzoken)
				teachDelayed= list("FORM 4" = list("teleport","ssj","form 4","fullkaioken"))

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")
