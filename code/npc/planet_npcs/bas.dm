mob
	NPA
		bas
			blue_star_brute
				name = "Blue Star Brute"
				race = ALIEN
				form = "npc_alien2";
				hostile = TRUE
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = GOD;
				currpl = 675.00e+06;
				maxpl = 675.00e+06;
				curreng = 350
				maxeng = 350
				bonus_str = 350;
				bonus_arm = 300;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken,/Command/Technique/drain,/Command/Technique/gack, /Command/Technique/timeskip)
				dropList = list(/obj/item/CAULIFLA_SPIKY_HAIR_CLIP,/obj/item/FROST_POISON_NEEDLE_BRACER)

				visuals = list("skin_color" = "{mPale Purple{x",
								"eye_color" = "{GGreen{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Medium",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(45.00e+06,75.00e+06, 95.00e+06, 125.00e+06, 135.00e+06, 140.00e+06);
					currpl = maxpl
					..()
				}
			purple_claw_grunt
				name = "Purple Claw Grunt"
				race = ALIEN
				form = "npc_alien";
				hostile = TRUE
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = GOD;
				currpl = 675.00e+09;
				maxpl = 675.00e+09;
				curreng = 350
				maxeng = 350
				bonus_str = 400;
				bonus_arm = 350;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken,/Command/Technique/drain, /Command/Technique/gack, /Command/Technique/timeskip)
				dropList = list(/obj/item/KALE_BERSERKER_BANDS,/obj/item/RIBRIANNE_LOVE_HEART_NECKLACE)

				visuals = list("skin_color" = "{mPale Purple{x",
								"eye_color" = "{GGreen{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Medium",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(45.00e+07,75.00e+07, 125.00e+07, 235.00e+07, 375.00e+07, 400.00e+07);
					currpl = maxpl
					..()
				}

			purple_claw_soldier
				name = "Purple Claw Soldier"
				race = ALIEN
				form = "npc_alien";
				hostile = TRUE
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = GOD;
				currpl = 675.00e+011;
				maxpl = 675.00e+011;
				curreng = 400
				maxeng = 400
				bonus_str = 420;
				bonus_arm = 360;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken, /Command/Technique/gack, /Command/Technique/timeskip)

				visuals = list("skin_color" = "{mPale Purple{x",
								"eye_color" = "{GGreen{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Medium",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(175.00e+010, 225.00e+010, 335.00e+010, 475.00e+010, 600.00e+010);
					currpl = maxpl
					..()
				}

			blue_star_warrior
				name = "Blue Star Warrior"
				race = ALIEN
				form = "npc_alien2";
				hostile = TRUE
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = GOD;
				currpl = 675.00e+012;
				maxpl = 675.00e+012;
				curreng = 600
				maxeng = 600
				bonus_str = 450;
				bonus_arm = 400;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken,/Command/Technique/drain,/Command/Technique/gack, /Command/Technique/timeskip)

				visuals = list("skin_color" = "{mPale Purple{x",
								"eye_color" = "{GGreen{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Medium",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(175.00e+011, 190.00e+011, 225.00e+011, 335.00e+011, 420.00e+011, 475.00e+011, 520.00e+011, 600.00e+011);
					currpl = maxpl
					..()
				}

			blue_star_hero
				name = "Blue Star hero"
				race = ALIEN
				form = "npc_alien2";
				hostile = TRUE
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = HEROIC;
				currpl = 675.00e+012;
				maxpl = 675.00e+012;
				curreng = 600
				maxeng = 600
				bonus_str = 480;
				bonus_arm = 420;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken,/Command/Technique/drain, /Command/Technique/pulse, /Command/Technique/gack, /Command/Technique/timeskip)

				visuals = list("skin_color" = "{mPale Purple{x",
								"eye_color" = "{GGreen{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Medium",
								"build" = "Skinny")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(920.00e+011, 1000.00e+011, 1275.00e+011, 1490.00e+011, 1625.00e+011, 1735.00e+011, 1820.00e+011, 1875.00e+011);
					currpl = maxpl
					..()
				}

			World_Eater
				name = "World Eater"
				race = SPIRIT
				form = "Revenant"
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = GOD;
				curreng = 599
				maxeng = 599
				bonus_str = 450;
				bonus_arm = 380;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/spiritwave, /Command/Technique/soulspear)
				dropList = list(/obj/item/CORRUPTED_SIGIL,/obj/item/JIREN_PRIDE_TROOPER_UNIFORM,/obj/item/GOKU_BLACK_ROSE_SCYTHE)

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
					maxpl = pick(13275.00e+014,14865.00e+014)
					currpl = maxpl;
					..()
				}
			water_leviathan
				name = "Water Leviathan"
				race = ALIEN
				form = "npc_alien3";
				hostile = TRUE
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = GOD;
				currpl = 4675.00e+015;
				maxpl = 4675.00e+015;
				curreng = 900
				maxeng = 900
				bonus_str = 500;
				bonus_arm = 400;
				randomRespawn = FALSE;
				dropList = list(/obj/item/LEVIATHAN_LEGGINGS,/obj/item/ZAMASU_IMMORTAL_HALO,/obj/item/ZENO_OMNIPOTENT_BUTTON)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/shyouken,/Command/Technique/drain, /Command/Technique/pulse, /Command/Technique/eye_laser, /Command/Technique/gack, /Command/Technique/timeskip)

				visuals = list("skin_color" = "{cPale Blue{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Monstrous",
								"build" = "Monstrous")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = pick(4420.00e+015, 4500.00e+015, 4675.00e+015, 4790.00e+015, 4825.00e+015, 5205.00e+015);
					currpl = maxpl
					..()
				}
