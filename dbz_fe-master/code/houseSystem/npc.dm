mob
	NPA
		earth
			HouseDispenser
				name = "Dr. Briefs";
				race = HUMAN;
				hostile = FALSE;
				sex = MALE;
				alignment = GOOD;
				difficultyLevel = VERY_EASY;
				currpl = 30;
				maxpl = 30;
				curreng = 100;
				maxeng = 100;
				zenni = 2500000;
				isStore = TRUE

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{BBlue{x",
								"hair_length" = "Long",
								"hair_style" = "Straight",
								"hair_color" = "{BBlue{x",
								"height" = "Average",
								"build" = "Skinny")

				New() {
					..()
					var/list/capsulePaths = list()
					for(var/N in houseSystem.CAPSULES) {
						capsulePaths[houseSystem.CAPSULES[N]] = "#INF"
					}

					storeInventory += capsulePaths
				}

				listStore(mob/Player/user) {
					var/list/storeItems = buildShop_Items(storeInventory, FALSE)

					if (user) {
						var/storeMsg = "{yHouse's{x {GShop{x || {YShop{x: {G[commafy(src.zenni)]{x {YZenni{x || [user.raceColor(user.name)]{x: {G[commafy(user.zenni)]{x {YZenni{x"
						displayStore(user, storeMsg, storeItems, "fancy", 75)
					}
				}

		HOUSESYSTEM
			TrainingBot
				name = "TrainingBot";
				race = ANDROID;
				hostile = TRUE;
				sex = UNKNOWN;
				alignment = GOOD;
				difficultyLevel = VERY_EASY;
				currpl = 1000;
				maxpl = 1000;
				curreng = 100;
				maxeng = 100;

				var
					armorOverride = NULL
					strOverride = NULL
					kiOverride = NULL
					staOverride = NULL

					obj/item/trainingConsole = NULL

				visuals = list("skin_color" = "{wGray{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Toned")

				New() {
					..()
					alignment = pick(GOOD, EVIL)
					race = pick(ANDROID, SAIYAN, HUMAN, NAMEK, MUTANT, ICER, BIO_ANDROID, ALIEN, SPIRIT)
					dropList = list()
				}

				death(var/mob/killer as mob, var/Command/tech) {
					if(tech && tech.canFinish && src.currpl <= MIN_PL) {
						if (trainingConsole) {
							loseConsciousness(MSG_BOT_BEATEN)
						}
					}

					return FALSE
				}

				totalArmor() {
					if (armorOverride) {
						return armorOverride
					}
					return ..()
				}

				totalStr() {
					if (strOverride) {
						return strOverride
					}
					return ..()
				}

				totalKi() {
					if (kiOverride) {
						return kiOverride
					}
					return ..()
				}

				totalSta() {
					if (staOverride) {
						return staOverride
					}
					return ..()
				}
