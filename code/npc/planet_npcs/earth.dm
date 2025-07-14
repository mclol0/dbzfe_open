mob
	NPA
		earth
			DrGero
				name = "Dr. Gero";
				race = ANDROID;
				hostile = FALSE;
				sex = MALE;
				alignment = EVIL;
				difficultyLevel = VERY_EASY;
				currpl = 30;
				maxpl = 30;
				curreng = 100;
				maxeng = 100;
				zenni = 0;
				randomRespawn = FALSE

				var
					list
						knownPlayers = list()

						unknownDialog = list(
							"say What are YOU doing? This place is not for you!",
							"say You are not an android, so you can't use this place!",
							"say I don't know what you are doing here, but you can't use this place!",
							"say Stop wasting my time. Go away!",
							"say I don't have time for you. If you are not an android, get out of here!"
						)
						
						idleActions = list(
							"say Where did I leave that extra arm...",
							"say I need to find more android parts to upgrade my creations.",
							"emote laughs evily as he works on his androids.",
							"say I will create the perfect android one day!",
							"emote looks at you with a suspicious eye.",
							"emote ducks behind a makeshift wall as something {Yexplodes{c in his workbench.",
							"say They will be all grounded to a pulp this time!",
							"say I'll make sure to destroy half the planet next time instead...",
							"emote whispers something to himself as he works on a complicated piece of machinery.",
						)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{BBlue{x",
								"hair_length" = "Long",
								"hair_style" = "Parted",
								"hair_color" = "{WWhite{x",
								"height" = "Average",
								"build" = "Skinny")

				New(){
					canReceiveItems = TRUE
					..()
				}

				receive_item(obj/item/I, mob/giver) {

				}

				event_entered(mob/M) {
					set waitfor = FALSE;
					set background = TRUE;
					sleep(4)
					var/list/possibleActions = list()
					possibleActions += idleActions

					if(M.loc == src.loc) {
						if (isAndroid(M)) {
							var/known = (M in knownPlayers)
							if (known) {
								possibleActions += list(
									"say How are you doing, [M]? I can upgrade your android parts for credits",
									"say [M]! Did you manage to kill Goku yet?",
									"say Remember [M]! Any kind of android part can be useful... Arms, legs and even internal components!",
									"say Remember [M]!. Give me android scraps and I'll give you some credits in exchange!"
								)
							} else if (!known) {
								alaparser.parse(src,"say Hello, [M]. Here you will be able to upgrade to unlock new skills and get stronger. And if you happen to come by any android pieces, give them to me and i'll reward you.",list())
								knownPlayers += M
								return
							}
						} else {
							possibleActions += unknownDialog
						}

						if (prob(game.settings.npcIdleActionProbability)) {
							var/action = pick(possibleActions)
							alaparser.parse(src, action, list())
						}
					}
				}

			Bulma
				name = "Bulma";
				race = HUMAN;
				hostile = FALSE;
				sex = FEMALE;
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

				New(){
					..()

					spawn() storeInventory = shop.getShopItems(src.type);
				}

				listStore(mob/Player/user) {
					//storeInventory = shop.getShopItems(src.type)
					var/list/storeItems = buildShop_Items(storeInventory, FALSE)
					if (user) {
						var/storeMsg = "{yBulma's{x {GShop{x || {YShop{x: {G[commafy(src.zenni)]{x {YZenni{x || [user.raceColor(user.name)]{x: {G[commafy(user.zenni)]{x {YZenni{x"
						displayStore(user, storeMsg, storeItems, "fancy", 75)
					}
				}

				sellStore(mob/Player/user, obj/item/sellItem) {
					var/itemType = sellItem.type
					var/itemStockShop = sellItem.STOCK_SHOP
					..()

					shop.updateItem(src.type,itemType,1,FALSE,itemStockShop);
					storeInventory = shop.getShopItems(src.type)
				}

				buyStore(mob/Player/user, itemIndex, quantity) {
					var/obj/item/I = _createItemFromStoreInventory(itemIndex)
					if (..()) {
						shop.updateItem(src.type,I.type,-quantity,FALSE,I.STOCK_SHOP);
						storeInventory = shop.getShopItems(src.type)
						del I
						return TRUE;
					}
					return FALSE;
				}

			MasterRoshi
				name = "Master Roshi"
				race = HUMAN
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = MEDIUM;
				currpl = 700
				maxpl = 700
				curreng = 100
				maxeng = 100
				teach = list("kamehameha")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/kamehameha)
				dropList = list(/obj/item/MASTER_ROSHI_INSIGNIA,/obj/item/ROSHIS_TURTLESHELL,/obj/item/MASTER_ROSHIS_SUNGLASSES)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")

			KingPiccolo
				name = "King Piccolo"
				race = NAMEK
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 900
				maxpl = 900
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/masenko)
				teach = list("makosen","retsuzan")
				dropList = list(/obj/item/SOFT_NAMEKIAN_SHOES,/obj/item/LIGHT_TURBAN)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

			General_Tao
				name = "General Tao"
				race = HUMAN
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = MEDIUM
				currpl = 700
				maxpl = 700
				curreng = 100
				maxeng = 100
				teach = list("kizan")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast)
				dropList = list(/obj/item/GENERAL_TAO_PINK_KIMONO,/obj/item/KILL_YOU_INSIGNIA,/obj/item/GENERAL_TAO_POWER_GOGGLES)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Long",
								"hair_style" = "Pony Tail",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Toned")


			Saibaman
				name = "Saibaman"
				single_name = "saibaman"
				multi_name = "saibamen"
				MULTI = TRUE;
				race = SAIBAMAN
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 1500
				maxpl = 1500
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/Saibaman)
				techniques = list(/Command/Technique/self_destruct)
				randomRespawn = FALSE;

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")

			RedRibbonSoldier
				name = "Red Ribbon Soldier"
				race = HUMAN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_EASY;
				curreng = 100
				maxeng = 100
				teach = list("blast")

				visuals = list("skin_color" = "{YTan{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Tall",
								"build" = "Toned")

				New(){
					sex = pick(MALE,FEMALE)
					maxpl = rand(200,400)
					currpl = maxpl
					..()
				}

			OrinMonk
				name = "Orin Monk"
				race = HUMAN
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = VERY_EASY;
				curreng = 150
				maxeng = 150

				visuals = list("skin_color" = "{YTan{x",
								"eye_color" = "{RBrown{x",
								"hair_length" = "Medium",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")

				New(){
					sex = pick(MALE, FEMALE)
					maxpl = rand(50,75)
					currpl = maxpl
					..()
				}

			ColonelSilver
				name = "Colonel Silver"
				race = HUMAN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_EASY;
				curreng = 110
				maxeng = 110

				visuals = list("skin_color" = "{YTan{x",
								"eye_color" = "{RBrown{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{RRed{x",
								"height" = "Tall",
								"build" = "Muscular")

				New(){
					sex = pick(MALE)
					maxpl = rand(120,150)
					currpl = maxpl
					..()
				}

			ColonelViolet
				name = "Colonel Violet"
				race = HUMAN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_EASY;
				curreng = 110
				maxeng = 110

				visuals = list("skin_color" = "{W{x",
								"eye_color" = "{BBlue{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "{mViolet{x",
								"height" = "Tall",
								"build" = "Toned")

				New(){
					sex = pick(FEMALE)
					maxpl = rand(120,150)
					currpl = maxpl
					..()
				}

			FriezaHenchman
				name = "Frieza's henchman"
				race = MUTANT
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
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

			Nappa
				name = "Nappa"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 13000;
				maxpl = 13000;
				curreng = 100
				maxeng = 100
				teach = list("masenko")
				alliedType = list(/mob/NPA/earth/Vegeta)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut, /Command/Technique/masenko)
				dropList = list(/obj/item/SAIYAN_BATTLE_ARMOR)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")

			Vegeta
				name = "Vegeta"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HARD;
				currpl = 18000;
				maxpl = 18000;
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/Nappa)
				randomRespawn = FALSE;
				teachShow = list("summon");
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut, /Command/Technique/galick_gun)
				teach = list("galick gun", "powerball","vanishing beam")
				dropList = list(/obj/item/RED_SCOUTER,/obj/item/SAIYAN_BATTLE_ARMOR,/obj/item/WHITE_BOOTS,/obj/item/WHITE_GLOVES)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Average",
								"build" = "Toned")

			Raditz
				name = "Raditz"
				race = SAIYAN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 1200;
				maxpl = 1200;
				curreng = 100
				maxeng = 100
				//alliedType = list(/mob/NPA/earth/Saibaman)
				//teach = list("summon")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				dropList = list(/obj/item/SCOUTER,/obj/item/SAIYAN_BATTLE_ARMOR,/obj/item/SAIYAN_BRACERS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Long",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Average",
								"build" = "Toned")

			Tien
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=1000000
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								if(currpl < 500000){
									powering=FALSE
									form="Spirit Burst"
									maxpl=1000000
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] begins to glow with a white energy!",_ohearers(0,src))
									if (teachDelayed[form]) {
										teach = teachDelayed[form]
									}
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Tien"
				race = HUMAN
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = VERY_HARD;
				currpl = 1000000;
				maxpl = 1000000;
				curreng = 100
				maxeng = 100
				teachDelayed = list("Spirit Burst" = list("spirit_burst" ,"kiaihou","tri-beam","shyouken"));
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/shyouken,
						/Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/tri_beam)
				dropList = list(/obj/item/THE_THIRD_EYE);

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")

			FriezaBot
				name = "Frieza Bot"
				race = ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = INSANE;
				currpl = 22500000;
				maxpl = 22500000;
				curreng = 100
				maxeng = 100
				teach = list("instantaneousmovement", "burning attack", "kienzan")
				alliedType = list(/mob/NPA/earth/KingCold)
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/eye_laser, /Command/Technique/hammer,
						/Command/Technique/uppercut)
				dropList = list(/obj/item/COMPRESSED_METAL)

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")

			KingCold
				name = "King Cold"
				race = ICER
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 25000000;
				maxpl = 25000000;
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/FriezaBot)
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast, /Command/Technique/eye_laser, /Command/Technique/hammer,
						/Command/Technique/uppercut, /Command/Technique/tail_whip, /Command/Technique/death_beam)

				dropList = list(/obj/item/KING_COLD_CAPE)

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")

			Yamcha
				name = "Yamcha"
				race = HUMAN
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = VERY_HARD;
				currpl = 3000000
				maxpl = 3000000
				curreng = 100
				maxeng = 100
				teach = list("wolf fang fist")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/shyouken, /Command/Technique/hammer,
						/Command/Technique/uppercut, /Command/Technique/kamehameha, /Command/Technique/wolf_fang_fist)
				dropList = list(/obj/item/BLACK_SASH,/obj/item/YAMCHAS_DESERT_MASK)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "{DBlack{x",
								"height" = "Average",
								"build" = "Toned")


			Android16
				name = "Android 16"
				race = ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 97000000;
				maxpl = 97000000;
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/Android18)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/eye_laser,/Command/Technique/hikou,
						/Command/Technique/hammer, /Command/Technique/uppercut)

				dropList = list(/obj/item/HEAVY_METAL_CHESTPLATE)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{CBlue{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "{RRed{x",
								"height" = "Tall",
								"build" = "Muscular")


			Android17
				name = "Android 17"
				race = ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 55000000;
				maxpl = 55000000;
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/Android18)
				randomRespawn = FALSE;
				teach = list("finish buster", "perfect")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/eye_laser, /Command/Technique/hikou,
						/Command/Technique/hammer, /Command/Technique/uppercut)

				dropList = list(/obj/item/ANDROID_17_SCARF)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Straight",
								"hair_color" = "{DBlack{x",
								"height" = "Average",
								"build" = "Average")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Semi-Perfect" && istype(killer,/mob/Player/Bio_Android) && tech.internal_name == "bio assimilate"){
						send("{GYour union with Android 17 was sucessful you feel more powerful together than you could ever have been alone!{x",killer)
						killer.form = "Perfect";
						killer.visuals["build"] = "Toned"
					}
				}

			Android18
				name = "Android 18"
				race = ANDROID
				sex = FEMALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 55000000;
				maxpl = 55000000;
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/Android17)
				randomRespawn = FALSE;
				teach = list("semi-perfect")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/eye_laser, /Command/Technique/hikou,
						/Command/Technique/hammer, /Command/Technique/uppercut)

				dropList = list(/obj/item/ANDROID_18_PEARL_NECKLACE,/obj/item/GOLD_EARRING)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Straight",
								"hair_color" = "{YBlonde{x",
								"height" = "Average",
								"build" = "Average")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Imperfect" && istype(killer,/mob/Player/Bio_Android) && tech.internal_name == "bio assimilate"){
						send("{GYour union with Android 18 was sucessful you feel more powerful together than you could ever have been alone!{x",killer)
						killer.form = "Semi-Perfect";
						killer.visuals["build"] = "Muscular"
					}
				}

			Android19
				name = "Android 19"
				race = ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 20000000;
				maxpl = 20000000;
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/Android20)
				randomRespawn = FALSE;
				teach = list("big bang")
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/eye_laser, /Command/Technique/hikou,
									/Command/Technique/absorb,/Command/Technique/drain, /Command/Technique/hammer, /Command/Technique/uppercut)

				dropList = list(/obj/item/ANDROID_19_HAT,/obj/item/ANDROID_ENERGY_CRYSTALS)

				visuals = list("skin_color" = "{WPale{x",
								"eye_color" = "{CBlue{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Average",
								"build" = "Fat")

			LonelyWisp
				name = "Lonely Wisp"
				race = SPIRIT
				form = "npc_withered"
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				currpl = 1500;
				maxpl = 1500;
				curreng = 120
				maxeng = 120
				randomRespawn = FALSE;
				//alliedType = list(/mob/NPA/earth/Saibaman)
				//teach = list("summon")
				teachShow = list("perception");

				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/zenkai, /Command/Technique/hammer,
						/Command/Technique/uppercut)

				visuals = list("skin_color" = "{WPale{x",
								"eye_color" = "{WWhite{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tiny",
								"build" = "Monstrous")
				
				event(mob/killer, Command/Technique/tech){
					if(istype(killer,/mob/Player/Spirit) && tech.internal_name == "purify") {
						killer.learnSkill("perception",TRUE)
					}

				}					


			Misokatsun
				name = "Misokatsun"
				race = ALIEN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = MEDIUM;
				curreng = 120
				maxeng = 120
				bonus_arm = 50;
				randomRespawn = FALSE;
				
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer,/Command/Technique/hammer, /Command/Technique/barrage, /Command/Technique/uppercut)
				visuals = list("skin_color" = "{YOrange{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Obese")

				New(){
					maxpl = rand(5000,6000)
					currpl = maxpl
					..()
				}

			Kishime
				name = "Kishime"
				race = ALIEN
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HARD;
				curreng = 180
				maxeng = 180
				bonus_arm = 75;
				bonus_sta = 75;
				randomRespawn = FALSE;
				
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer,/Command/Technique/hammer, /Command/Technique/barrage, /Command/Technique/uppercut)
				visuals = list("skin_color" = "{gDark Green{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Antennae",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Skinny")

				New(){
					maxpl = rand(9000,10000)
					currpl = maxpl
					..()
				}


			Android20
				name = "Android 20"
				race = ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 15000000;
				maxpl = 15000000;
				curreng = 100
				maxeng = 100
				alliedType = list(/mob/NPA/earth/Android19)
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,
									/Command/Technique/blast,
									/Command/Technique/eye_laser,
									/Command/Technique/hikou,
									/Command/Technique/absorb,
									/Command/Technique/drain, /Command/Technique/hammer, /Command/Technique/uppercut)

				dropList = list(/obj/item/DR_GERO_VEST,/obj/item/RED_RIBBON_INSIGNIA)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{CBlue{x",
								"hair_length" = "Long",
								"hair_style" = "Straight",
								"hair_color" = "{WWhite{x",
								"height" = "Average",
								"build" = "Skinny")

			CellJr
				name = "Cell Jr."
				single_name = "Cell Jr."
				multi_name = "Cell Jr's"
				MULTI = TRUE;
				race = BIO_ANDROID
				sex = UNKNOWN
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 100000000
				maxpl = 100000000
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/earth/CellJr)
				techniques = list(/Command/Technique/tail_stab,/Command/Technique/self_destruct,/Command/Technique/elbow, /Command/Technique/blast,
									/Command/Technique/eye_laser, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/kamehameha,
									/Command/Technique/final_flash)

				visuals = list("skin_color" = "{BBlue{x",
								"eye_color" = "{mPurple{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")

			Imperfect_Cell
				name = "Imperfect Cell"
				race = BIO_ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 45000000;
				maxpl = 45000000;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/tail_stab,/Command/Technique/elbow,
									/Command/Technique/blast,
									/Command/Technique/eye_laser, /Command/Technique/hammer, /Command/Technique/uppercut)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Skinny")
			Semi_Perfect_Cell
				name = "Semi-Perfect Cell"
				race = BIO_ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 190000000;
				maxpl = 190000000;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/tail_stab,/Command/Technique/elbow,
									/Command/Technique/blast,
									/Command/Technique/eye_laser, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/kamehameha)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Muscular")
			Perfect_Cell
				name = "Perfect Cell"
				race = BIO_ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = VERY_HARD;
				currpl = 300000000;
				maxpl = 300000000;
				curreng = 100
				maxeng = 100
				teach = list("final flash");
				dropList = list(/obj/item/CELLS_CHITINOUS_WING_PLATES,/obj/item/CELLS_CHITINOUS_FOOT_PLATES);
				techniques = list(/Command/Technique/tail_stab,/Command/Technique/elbow,
									/Command/Technique/blast,
									/Command/Technique/eye_laser, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/kamehameha)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

			Super_Perfect_Cell
				name = "Super Perfect Cell"
				race = BIO_ANDROID
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = INSANE;
				randomRespawn = FALSE;
				currpl = 550000000;
				maxpl = 550000000;
				curreng = 100
				maxeng = 100
				teach = list("ssj2", "super kamehameha", "superperfect");
				dropList = list(/obj/item/CELLS_CARAPACE_KNEE_CAPS,/obj/item/CELLS_CARAPACE_CHEST_PLATE,/obj/item/CELLS_CHITINOUS_SLEEVES);
				techniques = list(/Command/Technique/tail_stab,/Command/Technique/elbow,
									/Command/Technique/blast,
									/Command/Technique/eye_laser, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/kamehameha, /Command/Technique/final_flash)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Perfect" && istype(killer,/mob/Player/Bio_Android) && tech.internal_name == "bio assimilate"){
						send("{GYour union with Super Perfect Cell was sucessful you feel more powerful together than you could ever have been alone!{x",killer)
						killer.form = "Super Perfect";
						killer.visuals["build"] = "Toned"
					}
				}

			TeenGohan
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=600000000
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								if(currpl < 250000000){
									form="Super Saiyan"
									maxpl=600000000
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say I hope you're ready for this.{x", list())
									send("[raceColor(name)] {Ytransforms in a flash of {x{Wlight.{x",_ohearers(0,src))
									send("[raceColor(name)] {cgives you a grim smile.{x",_ohearers(0,src))
								}
							}else if(form=="Super Saiyan"){
								if(currpl < 500000000){
									form="Super Saiyan 2"
									maxpl=600000000
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)] {Yscreams as his aura takes on an all new edge and {Celectricity{x{Y sparks from him!",_ohearers(0,src))
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Teen Gohan"
				form = "Normal"
				race = HALFBREED
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = HEROIC;
				currpl = 600000000;
				maxpl = 600000000;
				curreng = 150
				maxeng = 150
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer,
								/Command/Technique/uppercut, /Command/Technique/super_kamehameha)



				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Short",
								"build" = "Toned")

			FatBuu
				name = "Fat Buu"
				race = GENIE
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = FUSION;
				currpl = 1.60e+009;
				maxpl = 1.60e+009;
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow,
									/Command/Technique/blast,
									/Command/Technique/eye_laser, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/kamehameha)

				dropList = list(/obj/item/BLACK_AND_GOLD_MAJIN_VEST,/obj/item/PURPLE_MAJIN_CAPE,/obj/item/GOLD_SHOES,/obj/item/GOLD_MITTENS);

				visuals = list("skin_color" = "{MPink{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Fat")



			Goku
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=2.00e+009
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] breathes deeply as his hair and eyes return to normal!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								var/mob/lastTarget = fCombat._getLastTarget(checkDensity=FALSE);

								if(lastTarget && lastTarget.race == LEGENDARY_SAIYAN){
									if(currpl < 1.20e+009){
										form="Super Saiyan 4"
										maxpl=15.25e+009
										currpl=getMaxPL()
										curreng=getMaxEN()
										send("[raceColor(name)] screams as his black hair grows down to his shoulders becoming a Super Saiyan 4!",_ohearers(0,src))
										if (teachDelayed[form]) {
											teach = teachDelayed[form]
										}
									}
								}else{
									if(currpl < 1.20e+009){
										form="Super Saiyan 3"
										maxpl=2.25e+009
										currpl=getMaxPL()
										curreng=getMaxEN()
										send("[raceColor(name)] screams as his golden hair grows down to his waist becoming a Super Saiyan 3!",_ohearers(0,src))
										if (teachDelayed[form]) {
											teach = teachDelayed[form]
										}
									}
								}
							}
						}
						sleep(world.tick_lag)
					}
				}

				name = "Goku"
				form = "Normal"
				race = SAIYAN
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = HEROIC;
				currpl = 2.00e+009
				maxpl = 2.00e+009
				curreng = 150
				maxeng = 150
				teachDelayed = list("Super Saiyan 4" = list("ssj3","omegacannon"), "Super Saiyan 3" = list("ssj3","omegacannon"));
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/zanzoken,
						/Command/Technique/super_kamehameha)
				dropList = list(/obj/item/SUPER_DRAGON_GI,/obj/item/ORANGE_FUSION_PANTS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Tall",
								"build" = "Toned")

			MajinVegeta
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=2.20e+009
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] breathes deeply as his hair and eyes return to normal!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								if(currpl < 500000000){
									form="Super Saiyan 2"
									maxpl=2.20e+009
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say Get out of my way worm!.{x", list())
									send("[raceColor(name)] {Yscreams as his aura takes on an all new edge and {Celectricity{x{Y sparks from him!",_ohearers(0,src))
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Majin Vegeta"
				form = "Normal"
				race = SAIYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = HEROIC
				currpl = 2.20e+009
				maxpl = 2.20e+009
				curreng = 100
				maxeng = 100
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut,/Command/Technique/final_flash,
						/Command/Technique/galick_gun,/Command/Technique/self_destruct)
				dropList = list(/obj/item/MAJIN_TATTOO,/obj/item/DEMON_PRINCE_GLOVES,/obj/item/WHITE_FUSION_BOOTS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{CCyan{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "{YGolden{x",
								"height" = "Average",
								"build" = "Toned")

			Gotenks
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=7.35e+009
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] breathes deeply as his hair and eyes return to normal!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								if(currpl < 1000000000){
									form="Super Saiyan 3"
									maxpl=7.55e+009
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say HAHA, I hope you don't die!", list())
									send("[raceColor(name)] {Ygrins and gives you the peace sign as he transforms into a Super Saiyan 3!",_ohearers(0,src))
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Gotenks"
				form = "Normal"
				race = HALFBREED
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = FUSION
				currpl = 7.25e+009
				maxpl = 7.25e+009
				curreng = 170
				maxeng = 170
				teachDelayed = list("Super Saiyan 3" = list("shadow"));
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut,/Command/Technique/final_flash,
						/Command/Technique/kamehameha,/Command/Technique/masenko,/Command/Technique/renzoku)
				dropList = list(/obj/item/BLACK_FUSION_BOOTS,/obj/item/LONG_FUSION_SASH,/obj/item/GOLD_FUSION_VEST,/obj/item/FUSION_BAGGY_WHITE_PANTS,
							/obj/item/BLACK_FUSION_BRACERS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{CCyan{x",
								"hair_length" = "Long",
								"hair_style" = "Spiked",
								"hair_color" = "{YGolden{x",
								"height" = "Short",
								"build" = "Toned")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Shade" && istype(killer,/mob/Player/Spirit) && tech.internal_name == "purify") {
						if(form == "Super Saiyan 3") {
							if (teachDelayed[form]) {
								teach = teachDelayed[form]
							}
							killer.form = "Shadow";
							send("{YYou've {WTranscended{Y into a new spiritual form, '{wShadow{Y'",killer)
						}
					}	
				}							

			Kid_Trunks
				name = "Kid Trunks"
				race = HALFBREED
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = VERY_HARD;
				currpl = 5050000;
				maxpl = 5050000;
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/earth/Goten)
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut,
						/Command/Technique/final_flash)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{CBlue{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Parted",
								"hair_color" = "{wSilver{x",
								"height" = "Short",
								"build" = "Toned")

			Goten
				name = "Goten"
				race = HALFBREED
				sex = MALE
				hostile = TRUE
				alignment = GOOD
				difficultyLevel = VERY_HARD;
				currpl = 2250000;
				maxpl = 2250000;
				curreng = 100
				maxeng = 100
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/earth/Kid_Trunks)
				techniques = list(/Command/Technique/elbow, /Command/Technique/blast, /Command/Technique/hammer, /Command/Technique/uppercut,
						/Command/Technique/kamehameha)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Short",
								"build" = "Toned")

			SuperBuu
				name = "Super Buu"
				form = "Super"
				race = GENIE
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HEROIC;
				currpl = 4.50e+009;
				maxpl = 4.50e+009;
				curreng = 120
				maxeng = 120
				teach = list("super")
				techniques = list(/Command/Technique/elbow,
									/Command/Technique/blast,/Command/Technique/specialbeamcannon,
									/Command/Technique/eye_laser,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kamehameha)
				dropList = list(/obj/item/SUPER_WHITE_CAPE,/obj/item/SUPER_FUSION_VEST,/obj/item/SUPER_DRAGON_GI,/obj/item/SUPER_MYSTIC_GI,
									/obj/item/BLACK_AND_GOLD_MAJIN_BELT,/obj/item/MAJIN_WRISTBANDS,/obj/item/FUSION_BAGGY_WHITE_PANTS)

				visuals = list("skin_color" = "{MPink{x",
								"eye_color" = "{DR{x{Re{x{Dd{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Tall",
								"build" = "Toned")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Normal" && istype(killer,/mob/Player/Genie) && tech.internal_name == "genie assimilate"){
						send("{GYour union with Super Buu was sucessful you feel more powerful together than you could ever have been alone!{x",killer)
						killer.form = "Super";
						killer.visuals["build"] = "Muscular"
					}
				}

			Vegito
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=2.22e+010
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] breathes deeply as his hair and eyes return to normal!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								if(currpl < 1.47e+010){
									form="Super Saiyan"
									maxpl=2.47e+010
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say Guess I'll have to transform!!", list())
									send("[raceColor(name)] screams as he transforms into a Super Saiyan!",_ohearers(0,src))
								}
							} else if(form=="Super Saiyan"){
								if(currpl < 1.75e+010){
									form="Super Saiyan 2"
									maxpl=2.75e+010
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say Let's take it to the next level!", list())
									send("[raceColor(name)] is surrounded by electricity as he transforms into a Super Saiyan 2!",_ohearers(0,src))
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Vegito"
				form = "Normal"
				race = SAIYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = FUSION
				currpl = 2.22e+010
				maxpl = 2.22e+010
				curreng = 200
				maxeng = 200
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/final_flash,
						/Command/Technique/galick_gun,/Command/Technique/kamehameha, /Command/Technique/super_kamehameha, /Command/Technique/zanzoken)
				dropList = list(/obj/item/WHITE_FUSION_BOOTS,/obj/item/DEMON_PRINCE_GLOVES,/obj/item/POTARA_FUSION_EARRINGS,/obj/item/SUPER_DRAGON_GI,
							/obj/item/ORANGE_FUSION_PANTS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Tall",
								"build" = "Toned")

			KidBuu
				name = "Kid Buu"
				form = "Kid"
				race = GENIE
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HEROIC;
				currpl = 4.50e+010;
				maxpl = 4.50e+010;
				curreng = 170
				maxeng = 170
				teach = list("kid")
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/eye_laser,/Command/Technique/hammer,
						/Command/Technique/uppercut,/Command/Technique/final_flash,/Command/Technique/death_beam)
				dropList = list(/obj/item/KID_BAGGY_WHITE_PANTS,/obj/item/KID_MAJIN_WRISTBANDS,/obj/item/BLACK_AND_GOLD_MAJIN_BELT,/obj/item/KID_BLACK_BOOTS)

				visuals = list("skin_color" = "{MPink{x",
								"eye_color" = "{DR{x{Re{x{Dd{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Skinny")

				event(mob/killer, Command/Technique/tech){
					if(killer.form == "Super" && istype(killer,/mob/Player/Genie) && tech.internal_name == "genie assimilate"){
						killer.form = "Kid";
						send("{GYour union with Kid Buu was sucessful you feel more powerful together than you could ever have been alone!{x",killer)
						killer.visuals["height"] = "Short"
						killer.visuals["build"] = "Skinny"
						killer.visuals["eye_color"] = "{RRed{x"
					}
				}

			Uub
				name = "Uub"
				form = "Normal"
				race = HUMAN
				hostile = TRUE
				sex = MALE
				alignment = GOOD
				difficultyLevel = FUSION
				currpl = 9.50e+010
				maxpl = 9.50e+010
				curreng = 270
				maxeng = 270
				bonus_str = 600;
				bonus_arm = 600;
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/final_flash,
						/Command/Technique/galick_gun,/Command/Technique/kamehameha,/Command/Technique/zanzoken, /Command/Technique/wolf_fang_fist, /Command/Technique/shyouken)
				dropList = list(/obj/item/BLACK_FUSION_BOOTS,/obj/item/BLACK_FUSION_BRACERS,/obj/item/ORANGE_FUSION_VEST,/obj/item/LONG_FUSION_SASH,
						/obj/item/FUSION_BAGGY_WHITE_PANTS)

				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{CCyan{x",
								"hair_length" = "Short",
								"hair_style" = "Spiked",
								"hair_color" = "{DBlack{x",
								"height" = "Short",
								"build" = "Toned")

			Beerus
				form = "npc_supressed"
				name = "Beerus"
				race = GOD_RACE
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 12.50e+012
				maxpl = 12.50e+012
				curreng = 700
				maxeng = 700
				bonus_str = 1200;
				bonus_arm = 1200;
				teach = list("ssjg")
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/final_flash,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/eye_laser)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{DBl{x{Ya{x{Dck{x",
								"hair_length" = "Long",
								"hair_style" = "Bunny Ears",
								"hair_color" = "{mPurple{x",
								"height" = "Tall",
								"build" = "Skinny")

			Whis
				form = "npc_supressed"
				name = "Whis"
				race = GOD_RACE
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 25.00e+012
				maxpl = 25.00e+012
				curreng = 1000
				maxeng = 1000
				bonus_str = 1200;
				bonus_arm = 1200;
				teach = list("ultrainstinctomen")
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken)

				visuals = list("skin_color" = "{CPale Blue{x",
								"eye_color" = "{mPurple{x",
								"hair_length" = "Long",
								"hair_style" = "FoHawk",
								"hair_color" = "{WWhite{x",
								"height" = "Tall",
								"build" = "Skinny")

			EvilSpirit
				form = "npc_withered"
				name = "Evil Spirit"
				race = SPIRIT
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 285.00e+012;
				maxpl = 285.00e+012;
				curreng = 1000
				maxeng = 1000
				bonus_str = 1450;
				bonus_arm = 850;
				randomRespawn = FALSE;
				teachDelayed = list("npc_withered" = list("revenant"));
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken)

				visuals = list("skin_color" = "{mPale Purple{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Average",
								"build" = "Muscular")


				event(mob/killer, Command/Technique/tech){

					if(killer.form == "Spectre" && istype(killer,/mob/Player/Spirit) && tech.internal_name == "purify") {
						if(!killer.hasSkill("revenant")) {
							if (teachDelayed[form]) {
								teach = teachDelayed[form]
								killer.learnSkill("revenant",TRUE)
							}
						}
						send("{YYou've {WTranscended{Y into a monstrously powerful form, '{RRevenant{Y'",killer)
						killer.form = "Revenant";
					}

				}

			WildPikachu
				form = "Super Saiyan"
				name = "Wild Pikachu"
				race = ALIEN
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 3955.00e+016;
				maxpl = 3955.00e+016;
				curreng = 1000
				maxeng = 1000
				bonus_str = 1250;
				bonus_arm = 1250;
				randomRespawn = FALSE;
				alliedType = list(/mob/NPA/earth/WildPikachu)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken)

				visuals = list("skin_color" = "{YYellow{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Short",
								"build" = "Fat")

			Hit
				form = "Ascended"
				name = "Hit"
				race = ALIEN
				hostile = TRUE
				sex = MALE
				alignment = NEUTRAL
				difficultyLevel = GOD
				currpl = 105.00e+012;
				maxpl = 105.00e+012;
				curreng = 1000
				maxeng = 1000
				bonus_str = 1000;
				bonus_arm = 1000;
				techniques = list(/Command/Technique/timeskip, /Command/Technique/fury, /Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,/Command/Technique/kizan,
								/Command/Technique/zanzoken,/Command/Technique/drain,/Command/Technique/shyouken)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Bald",
								"hair_style" = "Bald",
								"hair_color" = "Bald",
								"height" = "Tall",
								"build" = "Skinny")

			GokuBlack
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form=="Normal"){
								form="Super Saiyan Rose"
								currpl=getMaxPL()
								curreng=getMaxEN()
								teach = list("aura slide")
								break;
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Goku Black"
				form = "Super Saiyan Rose"
				race = LEGENDARY_SAIYAN
				AGGRO = FALSE;
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HEROIC;
				currpl = 25.00e+012;
				maxpl = 25.00e+012;
				curreng = 550
				maxeng = 550
				teach = list("aura slide")
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/final_flash,/Command/Technique/hammer,
								/Command/Technique/uppercut,/Command/Technique/super_kamehameha)



				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Average",
								"build" = "Toned")

			Broly
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="Normal"){
								form="Normal"
								maxpl=18.00e+012
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="Normal"){
								if(currpl < 16.00e+012){
									form="Legendary SSJ"
									maxpl=18.00e+012
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "say Where is Kakarot?!{x", list())
									send("[raceColor(name)] {Gtransforms and the wave of force takes your breath away!.{x",_ohearers(0,src))
								}
							}else if(form=="Legendary SSJ"){
								if(currpl < 16.00e+012){
									form="Legendary SSJ2"
									maxpl=18.00e+012
									currpl=getMaxPL()
									curreng=getMaxEN()
									alaparser.parse(src, "yell KAKAROT?!?!?!{x", list())
									send("[raceColor(name)] {Gscreams and goes BERSERK as {Yelectricity{x{G sparks from him!",_ohearers(0,src))
								}
							}
						}
						sleep(world.tick_lag)
					}
				}
				name = "Broly"
				form = "Normal"
				race = LEGENDARY_SAIYAN
				AGGRO = TRUE;
				sex = MALE
				hostile = TRUE
				alignment = EVIL
				difficultyLevel = HEROIC;
				currpl = 18.00e+012;
				maxpl = 18.00e+012;
				curreng = 650
				maxeng = 650
				bonus_arm = 200;
				bonus_str = 200;
				randomRespawn = FALSE;
				techniques = list(/Command/Technique/elbow,/Command/Technique/blast,/Command/Technique/final_flash,/Command/Technique/hammer,
								/Command/Technique/uppercut,/Command/Technique/super_kamehameha)



				visuals = list("skin_color" = "{yTan{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Messy",
								"hair_color" = "Black",
								"height" = "Short",
								"build" = "Toned")

			GoldenFrieza
				checkForm(){
					set waitfor=FALSE;
					while(src){
						if(!AI){
							if(form!="FORM 4"){
								form="FORM 4"
								maxpl=1.50e+012
								currpl=getMaxPL()
								curreng=getMaxEN()
								send("[raceColor(name)] reverts!",_ohearers(0,src))
								teach = list()
								break;
							}
						}
						if(!unconscious && !stunned){
							if(form=="FORM 4"){
								if(currpl < 0.75e+012){
									form="GOLDEN FORM 4"
									maxpl=1.75e+012
									currpl=getMaxPL()
									curreng=getMaxEN()
									send("[raceColor(name)]{Y transforms into his Golden Form!{x",_ohearers(0,src))
									teach = list("ssjb", "ssjr")
								}
							}
						}
						sleep(world.tick_lag)
					}
				}

				name = "Golden Frieza"
				form = "FORM 4"
				race = ICER
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = HEROIC;
				currpl = 1.50e+012
				maxpl = 1.50e+012
				curreng = 300
				maxeng = 300
				teach = list("ssjb", "ssjr")
				techniques = list(/Command/Technique/elbow, /Command/Technique/hammer, /Command/Technique/uppercut, /Command/Technique/tail_whip, /Command/Technique/zanzoken)

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "None",
								"hair_style" = "Bald",
								"hair_color" = "None",
								"height" = "Short",
								"build" = "Toned")
