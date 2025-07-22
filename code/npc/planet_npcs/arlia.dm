mob
	NPA
		arlia
			Bergamo
				form = "Enhanced"
				name = "Bergamo"
				race = ALIEN
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 20.00e+012
				maxpl = 20.00e+012
				curreng = 1000
				maxeng = 1000
				bonus_str = 380;
				bonus_arm = 320;
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/arlia/Lavender,/mob/NPA/arlia/Basil)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken)

				visuals = list("skin_color" = "{BBlue{x",
								"eye_color" = "{YYellow{x",
								"hair_length" = "Short",
								"hair_style" = "Scuffed",
								"hair_color" = "{BBlue{x",
								"height" = "Tall",
								"build" = "Skinny")

			Lavender
				form = "Enhanced"
				name = "Lavender"
				race = ALIEN
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 15.00e+012
				maxpl = 15.00e+012
				curreng = 1000
				maxeng = 1000
				bonus_str = 350;
				bonus_arm = 300;
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/arlia/Basil,/mob/NPA/arlia/Bergamo)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{YYellow{x",
								"hair_length" = "Short",
								"hair_style" = "Scuffed",
								"hair_color" = "{yBrown{x",
								"height" = "Short",
								"build" = "Skinny")

			Basil
				form = "Enhanced"
				name = "Basil"
				race = ALIEN
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 15.00e+012
				maxpl = 15.00e+012
				curreng = 1000
				maxeng = 1000
				bonus_str = 350;
				bonus_arm = 300;
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/arlia/Lavender,/mob/NPA/arlia/Bergamo)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken)

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{YYellow{x",
								"hair_length" = "Average",
								"hair_style" = "Scuffed",
								"hair_color" = "{RRed{x",
								"height" = "Short",
								"build" = "Skinny")

			KingMoai
				name = "King Moai"
				race = ARLIAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HARD
				curreng = 100
				maxeng = 100
				currpl = 55000
				maxpl = 55000
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)
				alliedType = list(/mob/NPA/arlia/Yetti,/mob/NPA/arlia/Greger,/mob/NPA/arlia/Lesoy)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{gGreen{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

			Greger
				name = "Greger"
				race = ARLIAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				currpl = 36000
				maxpl = 36000
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)
				alliedType = list(/mob/NPA/arlia/Lesoy)
				dropList = list(/obj/item/METAL_CHESTPLATE)

				visuals = list("skin_color" = "{wGrey{x",
								"eye_color" = "{rRed{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Toned")

			Lesoy
				name = "Lesoy"
				race = ARLIAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM
				curreng = 100
				maxeng = 100
				currpl = 54000
				maxpl = 54000
				dropList = list(/obj/item/METAL_CHESTPLATE)
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)
				alliedType = list(/mob/NPA/arlia/Greger)

				visuals = list("skin_color" = "{wGrey{x",
								"eye_color" = "{rRed{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Toned")

			Yetti
				name = "Yetti"
				race = ARLIAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HARD
				curreng = 100
				maxeng = 100
				currpl = 90000
				maxpl = 90000

				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)
				visuals = list("skin_color" = "{yBrown{x",
								"eye_color" = "{mPurple{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Giant",
								"build" = "Toned")


			LostSoul
				name = "Hardened Soul"
				form = "npc_withered"
				race = SPIRIT
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = INSANE
				curreng = 140
				maxeng = 140
				currpl = 1500
				maxpl = 1500
				randomRespawn = FALSE;
				teach = list("phaserun")

				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut,/Command/Technique/soulspear,/Command/Technique/siphon)
				visuals = list("skin_color" = "{wPale{x",
								"eye_color" = "{WWhite{x",
								"hair_length" = "None",
								"hair_style" = "Spiked",
								"hair_color" = "{dBlack{x",
								"height" = "Short",
								"build" = "Toned")
				New(){
					..()
					sex = pick(MALE,FEMALE);
					maxpl = rand(50000,100000);
					currpl = getMaxPL();

					spawn(){
						var/goTime = (world.time + 20 SECONDS);

						while(src){
							if(world.time >= goTime){
								alaparser.parse(src,"say [pick("I've been trapped here so long.....","Hello stranger...","This planet is unforgiving...  just like me","I've been trying to keep myself busy lately.","My soul aches. I want to leave.","I am not sure how I got trapped in this infernal planet")]",list());
								goTime = (world.time + 300 SECONDS);
							}

							sleep(world.tick_lag);
						}
					}

				}

			MajinDabura
				name = "Majin Dabura"
				form = "Noble"
				race = DEMON
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = INSANE
				curreng = 120
				maxeng = 120
				currpl = 2500000
				maxpl = 2500000
				teach = list("soulspear", "noble")
				teachDelayed = list("Noble" = list("shade"));
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/hellfirelance,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/soulspear,/Command/Technique/siphon)

				visuals = list("skin_color" = "{rRed{x",
								"eye_color" = "{mPurple{x",
								"hair_length" = "Short",
								"hair_style" = "Horns",
								"hair_color" = "Black",
								"height" = "Tall",
								"build" = "Muscular")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Normal" && istype(killer,/mob/Player/Demon)){
						send("{GYou've stolen Dabura's Demonic energies, welcome to the Demonic Nobility!{x",killer)
						killer.form = "Noble";
					}

					if(killer.form == "Phantasm" && istype(killer,/mob/Player/Spirit) && tech.internal_name == "purify") {
						if (teachDelayed[form]) {
							teach = teachDelayed[form]
						}
						send("{YYou've {WTranscended{Y into a new spiritual form, '{wShade{Y'",killer)
						killer.form = "Shade";
					}

				}

			Arlian_Scout
				name = "Arlian Scout"
				race = ARLIAN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HARD
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut)
				dropList = list(/obj/item/HEAVY_SPIKED_POLEYONS,/obj/item/BLOODIED_VAMBRACES);


				visuals = list("skin_color" = "{yGrey{x",
								"eye_color" = "{rRed{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Toned")

				New(){
					..()
					sex = pick(MALE,FEMALE);
					maxpl = rand(10000,12000);
					currpl = getMaxPL();
				}

			Arlian_Beast
				name = "Gigantic Arlian Beast"
				race = ARLIAN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = FUSION
				curreng = 300
				maxeng = 300
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/arlia/Arlian_Beast)
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/gack, /Command/Technique/eye_laser, /Command/Technique/absorb)


				visuals = list("skin_color" = "{yGrey{x",
								"eye_color" = "{rRed{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Huge",
								"build" = "Monstrous")

				New(){
					..()
					sex = pick(MALE,FEMALE);
					maxpl = pick(2.10e+009,2.30e+009,2.60e+009,2.80e+009);
					currpl = getMaxPL();


					spawn(){
						var/goTime = (world.time + 35 SECONDS);

						while(src){
							if(world.time >= goTime){
								alaparser.parse(src,"emo [pick("snarls at you.","growls.","lets off a large roar.","stomps around.")]",list());
								goTime = (world.time + 35 SECONDS);
							}

							sleep(world.tick_lag);
						}
					}
				}
