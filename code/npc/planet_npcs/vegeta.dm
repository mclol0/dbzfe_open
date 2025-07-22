mob
	NPA
		vegeta
			Treacherous_Saiyan
				name = "Treacherous Saiyan"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				dropList = list(/obj/item/SAIYAN_BATTLE_ARMOR, /obj/item/SAIYAN_BRACERS, /obj/item/VEGETAS_SAIYAN_PRIDE_ARMOR, /obj/item/SAIYAN_TAIL_BELT)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")

				New(){
					..()
					sex = pick(MALE,FEMALE)
					maxpl = rand(5000,9000);
					currpl = maxpl;
				}

			Ancient_Saiyan
				name = "Ancient Saiyan"
				race = SAIYAN
				form = "Legendary SSJ"
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				curreng = 499
				maxeng = 499
				bonus_arm = 1500;
				bonus_str = 2500;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/final_flash)
				dropList = list(/obj/item/SAIYAN_POWER_KNEE_PADS, /obj/item/SAIYAN_POWER_CAPE, /obj/item/SUPER_SAIYAN_4_WRISTBANDS, /obj/item/BARDOCKS_BATTLE_WORN_HEADBAND)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")

				New(){
					..()
					sex = pick(MALE,FEMALE)
					maxpl = pick(755.00e+013,1255.00e+013,1555.00e+013,1955.00e+013,2255.00e+013)
					currpl = maxpl;
					..()

					spawn(){
						var/goTime = (world.time + 60 SECONDS);

						while(src){
							if(world.time >= goTime){
								alaparser.parse(src,"say [pick("We've walked this planet for as long as we can remember.","We hold secrets that you can't even imagine.")]",list());
								goTime = (world.time + 60 SECONDS);
							}

							sleep(world.tick_lag);
						}
					}
				}

			World_Eater
				name = "World Eater"
				race = SPIRIT
				form = "Revenant"
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				curreng = 399
				maxeng = 399
				bonus_arm = 1900;
				bonus_str = 2200;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/spiritwave, /Command/Technique/soulspear)
				dropList = list(/obj/item/CORRUPTED_SIGIL)

				visuals = list("skin_color" = "{DBlack{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Horns",
								"hair_color" = "None",
								"height" = "Monstrous",
								"build" = "Monstrous")

				New(){
					..()
					sex = pick(MALE,FEMALE)
					maxpl = pick(1575.00e+014,1665.00e+014)
					currpl = maxpl;
					..()
				}

			Royal_Guard
				name = "Royal Saiyan Guard"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 17000;
				maxpl = 17000;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai,
						/Command/Technique/hammer, /Command/Technique/uppercut)
				alliedType = list(/mob/NPA/vegeta/Royal_Guard, /mob/NPA/vegeta/King_Vegeta)
				randomRespawn = FALSE;
				dropList = list(/obj/item/SAIYAN_BATTLE_ARMOR,/obj/item/SAIYAN_BRACERS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")


			King_Vegeta
				name = "King Vegeta"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 27000;
				maxpl = 27000;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut, /Command/Technique/galick_gun)
				alliedType = list(/mob/NPA/vegeta/Royal_Guard)
				randomRespawn = FALSE;
				dropList = list(/obj/item/KING_VEGETA_MEDALLION,/obj/item/SAIYAN_BATTLE_ARMOR,/obj/item/WHITE_BOOTS,/obj/item/WHITE_GLOVES, /obj/item/VEGETAS_SAIYAN_PRIDE_ARMOR)


				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Toned")

			/*
				Bardock and the Bardock elite group.
			*/
			Bardock
				name = "Bardock"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 21000;
				maxpl = 21000
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				alliedType = list(/mob/NPA/vegeta/Tora, /mob/NPA/vegeta/Fasha, /mob/NPA/vegeta/Borgos, /mob/NPA/vegeta/Shugesh)
				randomRespawn = FALSE;
				dropList = list(/obj/item/BARDOCKS_HEADBAND,/obj/item/BARDOCKS_BATTLE_ARMOR,/obj/item/FINGERLESS_LEAD_LINED_GLOVES)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Toned")

			Tora
				name = "Tora"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 18500;
				maxpl = 18500
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				alliedType = list(/mob/NPA/vegeta/Bardock, /mob/NPA/vegeta/Fasha, /mob/NPA/vegeta/Borgos, /mob/NPA/vegeta/Shugesh)
				randomRespawn = FALSE;

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Toned")

			Fasha
				name = "Fasha"
				race = SAIYAN
				sex = FEMALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 16250;
				maxpl = 16250
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				alliedType = list(/mob/NPA/vegeta/Tora, /mob/NPA/vegeta/Bardock, /mob/NPA/vegeta/Borgos, /mob/NPA/vegeta/Shugesh)
				randomRespawn = FALSE;
				dropList = list(/obj/item/HEAVY_KUSARI_LEGGINS);

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Skinny")

			Borgos
				name = "Borgos"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 20000;
				maxpl = 20000
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				alliedType = list(/mob/NPA/vegeta/Tora, /mob/NPA/vegeta/Fasha, /mob/NPA/vegeta/Bardock, /mob/NPA/vegeta/Shugesh)
				randomRespawn = FALSE;

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Balding",
								"hair_color" = "Black",
								"height" = "Tall",
								"build" = "Muscular")

			Shugesh
				name = "Shugesh"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 14500;
				maxpl = 14500
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				alliedType = list(/mob/NPA/vegeta/Tora, /mob/NPA/vegeta/Fasha, /mob/NPA/vegeta/Borgos, /mob/NPA/vegeta/Bardock)
				randomRespawn = FALSE;

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Bowl",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Fat")

			/*
				Bardock and the Bardock elite group.
			*/

			FriezaHenchman
				name = "Frieza's henchman"
				race = MUTANT
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = EASY;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zanzoken, /Command/Technique/hammer,
						/Command/Technique/uppercut, /Command/Technique/masenko)
				dropList = list(/obj/item/SCOUTER)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(3000,5000)
					currpl = maxpl
					..()
				}

			Elite_Henchman
				name = "Elite henchman"
				race = MUTANT
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				curreng = 100
				maxeng = 100
				teach = list("blast");

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(11000,12000)
					currpl = maxpl
					..()
				}
