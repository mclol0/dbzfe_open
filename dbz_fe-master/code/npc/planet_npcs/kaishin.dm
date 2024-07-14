mob
	NPA
		kaishin
			KaiProspect
				name = "Kai Prospect"
				race = SHINJIN
				sex = UNKNOWN
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/kizan)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "{mPurple{x",
								"height" = "Average",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(10000,15000)
					currpl = maxpl
					..()
				}

			GoldenChild
				name = "Golden Child"
				race = SHINJIN
				sex = UNKNOWN
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/kizan, /Command/Technique/gekiretsu)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{CBlue{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(40000,55000)
					currpl = maxpl
					..()
				}

			KaioshinProspect
				name = "Kaioshin Prospect"
				race = SHINJIN
				sex = UNKNOWN
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = VERY_HARD
				curreng = 100
				maxeng = 100
				teach = list("timeskip");
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/kizan, /Command/Technique/gekiretsu)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{YYellow{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "{CBlue{x",
								"height" = "Average",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(100000,150000)
					currpl = maxpl
					..()
				}

			ShinJinInitiate
				name = "Shin-Jin Initiate"
				race = SHINJIN
				sex = UNKNOWN
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = EASY;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/kizan, /Command/Technique/gekiretsu)

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

			SuperMira
				name = "Super Mira"
				form = "Aristocrat"
				race = DEMON
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = FUSION;
				currpl = 1.25e+011;
				maxpl = 1.25e+011;
				curreng = 270;
				maxeng = 270;
				bonus_str = 333;
				bonus_arm = 333;
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/hellfirelance,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/soulspear,/Command/Technique/siphon)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{WR{x{Re{x{Wd{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{WWhite{x",
								"height" = "Tall",
								"build" = "Muscular")

			Mira
				name = "Mira"
				form = "Aristocrat"
				race = DEMON
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HEROIC;
				currpl = 6.25e+009;
				maxpl = 6.25e+009;
				curreng = 270
				maxeng = 270
				bonus_arm = 333;
				teach = list("aristocrat")
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/hellfirelance,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/soulspear,/Command/Technique/siphon)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{WR{x{Re{x{Wd{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{WWhite{x",
								"height" = "Tall",
								"build" = "Muscular")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Noble" && istype(killer,/mob/Player/Demon)){
						send("{GYou've stolen Mira's Demonic energies, welcome to the Demonic Aristocracy!{x",killer)
						killer.form = "Aristocrat";
					}
				}

			Towa
				name = "Towa"
				form = "Aristocrat"
				race = DEMON
				sex = FEMALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = FUSION;
				currpl = 2.50e+011;
				maxpl = 2.50e+011;
				curreng = 370
				maxeng = 370
				bonus_str = 333;
				bonus_arm = 333;
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/hellfirelance,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/soulspear,/Command/Technique/siphon)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{mPurplex",
								"hair_length" = "Long",
								"hair_style" = "Styled",
								"hair_color" = "{WWhite{x",
								"height" = "Tall",
								"build" = "Skinny")

			Demigra
				name = "Demigra"
				form = "Ascended"
				race = DEMON
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				currpl = 5.75e+011;
				maxpl = 5.75e+011;
				curreng = 666
				maxeng = 666
				bonus_str = 666;
				bonus_arm = 666;
				dropList = list(/obj/item/GODLY_FLAME_VEST,/obj/item/GODLY_FLAME_BRACERS,/obj/item/GODLY_FLAME_HELMET, /obj/item/GODLY_FLAME_SCOUTER);
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/hellfirelance,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/soulspear,/Command/Technique/siphon)

				teach = list("deity")
				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{WR{x{Re{x{Wd{x",
								"hair_length" = "Long",
								"hair_style" = "Spiked",
								"hair_color" = "{RRed{x",
								"height" = "Tall",
								"build" = "Toned")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Aristocrat" && istype(killer,/mob/Player/Demon)){
						send("{GYou've stolen Demigra's Demonic energies, welcome to the Demonic Pantheon!{x",killer)
						killer.form = "Deity";
					}
				}

			CorruptedKaio
				name = "Corrupted Kaio"
				form = "npc_mystic"
				race = KAIO
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				curreng = 555
				maxeng = 555
				bonus_arm = 700;
				bonus_str = 500;
				randomRespawn = FALSE;
				teachDelayed = list("npc_mystic" = list("spectre"));
				teachShow = list("pulse");
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/haunt)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{mPurplex",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Toned")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Shadow" && istype(killer,/mob/Player/Spirit) && tech.internal_name == "purify") {
						if (teachDelayed[form]) {
							teach = teachDelayed[form]
						}
						send("{YYou've {WTranscended{Y into a new spiritual form, '{wSpectre{Y'",killer)
						killer.form = "Spectre";

					}

					if(istype(killer, /mob/Player/Spirit) && tech.internal_name == "purify") {
						killer.learnSkill("pulse",TRUE)
					}
				}




				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(1.00e+011,1.20e+011)
					currpl = maxpl
					..()
				}


			DarkWisp
				name = "Night Wisp"
				form = "npc_withered"
				race = SPIRIT
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = INSANE;
				curreng = 230
				maxeng = 230
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/haunt)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{mPurplex",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(750000,1400000)
					currpl = maxpl
					..()
				}

			LightWisp
				name = "Light Wisp"
				form = "npc_blessed"
				race = SPIRIT
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = INSANE;
				curreng = 330
				maxeng = 330
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/haunt,/Command/Technique/spiritwave)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{mPurplex",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(2500000,3000000)
					currpl = maxpl
					..()
				}

			WispCommander
				name = "Wisp Commander"
				form = "npc_blessed"
				race = SPIRIT
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = INSANE;
				curreng = 430
				maxeng = 430
				bonus_arm = 100;
				bonus_str = 100;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/haunt,/Command/Technique/spiritwave)
				teachShow = list("divinecannon");
				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{mPurplex",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Toned")


				event(mob/killer, Command/Technique/tech){
					if(istype(killer, /mob/Player/Spirit) && tech.internal_name == "purify") {
						killer.learnSkill("divinecannon",TRUE)
					}
				}


				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(7500000,12000000)
					currpl = maxpl
					..()
				}

			TaintedShadow
				name = "Tainted Shadow"
				form = "npc_withered"
				race = SPIRIT
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				curreng = 999
				maxeng = 999
				bonus_arm = 1800;
				bonus_str = 1800;
				randomRespawn = FALSE;
				dropList = list(/obj/item/SHROUD_OF_WITHERING);
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/timeskip,/Command/Technique/fury,/Command/Technique/siphon, /Command/Technique/haunt)

				visuals = list("skin_color" = "{DBlack{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{DBlack{x",
								"height" = "Short",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(350.00e+014,399.00e+014)
					currpl = maxpl
					..()
				}

			Grandkaio
				name = "Grandkaio"
				form = "npc_mystic"
				race = KAIO
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = HEROIC;
				curreng = 270
				maxeng = 270
				bonus_arm = 225;
				teach = list("spiritwave");
				dropList = list(/obj/item/CRIMSON_EARRINGS,/obj/item/GODLY_FLAME_GLOVES,/obj/item/GODLY_FLAME_BOOTS, /obj/item/GODLY_FLAME_SCOUTER);
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{mPurplex",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(800000000,1.25e+09)
					currpl = maxpl
					..()
				}


			Supremekaio
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=2.25e+09
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								if(currpl < 990000000){
									form = "npc_mystic"
									maxpl=8.00e+09
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say I hope you're ready for this.{x", list())
									send("[raceColor(name)] {Ytransforms in a flash of {x{Wlight.{x",_ohearers(0,src))
									if (teachDelayed[form]) {
										teach = teachDelayed[form]
									}
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Supreme Kaio"
				race = KAIO
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = GOD;
				curreng = 470
				maxeng = 470
				bonus_arm = 500;
				bonus_str = 1300;
				teachShow = list("mystic");
				teachDelayed = list("npc_mystic" = list("mystic"));
				dropList = list(/obj/item/CRIMSON_EARRINGS,/obj/item/GODLY_FLAME_GLOVES,/obj/item/GODLY_FLAME_BOOTS);
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/pulse)

				visuals = list("skin_color" = "{CBlue{x",
								"eye_color" = "{mPurplex",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(2.25e+09)
					currpl = maxpl
					..()
				}



			EvilDemon
				name = "Dark Shadow"
				form = "Enhanced"
				race = SPIRIT
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				curreng = 550
				maxeng = 550
				bonus_arm = 1300;
				bonus_str = 1300;
				dropList = list(/obj/item/SHADOW_BARRIER,/obj/item/SHADOW_EARRINGS,/obj/item/SHADOW_GLOVES,/obj/item/SHADOW_PAULDRONS);
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/timeskip,/Command/Technique/fury,/Command/Technique/siphon)

				visuals = list("skin_color" = "{DBlack{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{DBlack{x",
								"height" = "Short",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(955.00e+012,1355.00e+012,1955.00e+012)
					currpl = maxpl
					..()
				}

			EvilShadow
				name = "Shadow"
				form = "Enhanced"
				race = SPIRIT
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				curreng = 300
				maxeng = 300
				bonus_arm = 1000;
				bonus_str = 1000;
				dropList = list(/obj/item/SHADOW_BARRIER,/obj/item/SHADOW_EARRINGS,/obj/item/SHADOW_GLOVES,/obj/item/SHADOW_PAULDRONS);
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/shyouken,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/gekiretsu,/Command/Technique/kizan,/Command/Technique/timeskip,/Command/Technique/fury,/Command/Technique/siphon)

				visuals = list("skin_color" = "{DBlack{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Mowhawk",
								"hair_color" = "{DBlack{x",
								"height" = "Short",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(355.00e+012,755.00e+012,855.00e+012)
					currpl = maxpl
					..()
				}


			SSGGoku
				name = "Goku"
				form = "Super Saiyan God"
				race = SAIYAN
				AGGRO = TRUE;
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = GOD;
				currpl = 51.75e+015;
				maxpl = 51.75e+015;
				curreng = 570
				maxeng = 570
				bonus_str = 1233;
				bonus_arm = 1233;
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/kaishin/SSGVegeta)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kamehameha, /Command/Technique/super_kamehameha, /Command/Technique/zanzoken)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "{RRed{x",
								"height" = "Tall",
								"build" = "Toned")

			SSGVegeta
				name = "Vegeta"
				form = "Super Saiyan God"
				race = SAIYAN
				AGGRO = TRUE;
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				currpl = 51.50e+015;
				maxpl = 51.50e+015;
				curreng = 570
				maxeng = 570
				bonus_str = 1233;
				bonus_arm = 1233;
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/kaishin/SSGGoku)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/final_flash,
						/Command/Technique/galick_gun,/Command/Technique/zanzoken)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "{RRed{x",
								"height" = "Average",
								"build" = "Toned")
