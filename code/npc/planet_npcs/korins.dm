mob
	NPA
		korins
			Korin
				name = "Korin";
				race = MUTANT;
				hostile = FALSE;
				sex = MALE;
				alignment = GOOD;
				difficultyLevel = VERY_EASY;
				currpl = 30;
				maxpl = 30;
				curreng = 100;
				maxeng = 100;
				zenni = 2500000;
				shopSale = FALSE;
				isStore = TRUE

				visuals = list("skin_color" = "{WWhite{x",
								"eye_color" = "{wBlack{x",
								"hair_length" = "Short",
								"hair_style" = "Straight",
								"hair_color" = "{WWhite{x",
								"height" = "Short",
								"build" = "Fat")

				New(){
					..()
					growSenzu();
					checkSale();

					spawn() storeInventory = shop.getShopItems(src.type)
				}

				listStore(mob/Player/user) {
					storeInventory = shop.getShopItems(src.type);
					var/list/storeItems = buildShop_Items(storeInventory, FALSE)
					if (user) {
						var/storeMsg = "{yKorin's{x {GShop{x || {YShop{x: {G[commafy(src.zenni)]{x {YZenni{x || [user.raceColor(user.name)]{x: {G[commafy(user.zenni)]{x {YZenni{x"
						displayStore(user, storeMsg, storeItems, "fancy", 75)
					}
				}

				sellStore(mob/Player/user, obj/item/sellItem) {
					send("I don't purchase item's here!",user,TRUE);
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

			GarlicJr
				form = "Normal"
				name = "Garlic Jr."
				randomRespawn = FALSE;
				race = MAKYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = VERY_HARD
				currpl = 250000
				maxpl = 250000
				curreng = 120
				maxeng = 120
				AGGRO = TRUE;
				dropList = list(/obj/item/SENZU_BEAN,/obj/item/GARLIC_JR_CAPE)
				alliedType = list(/mob/NPA/korins/Spice,/mob/NPA/korins/Vinegar,/mob/NPA/korins/Mustard,/mob/NPA/korins/Salt)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,
								/Command/Technique/zanzoken)
				teach = list("kizan");

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{DBlack{x",
								"hair_length" = "Bald",
								"hair_style" = "None",
								"hair_color" = "None",
								"height" = "Giant",
								"build" = "Toned")


			Spice
				form = "Normal"
				name = "Spice"
				randomRespawn = FALSE;
				race = MAKYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = VERY_HARD
				currpl = 150000
				maxpl = 150000
				curreng = 120
				maxeng = 120
				AGGRO = TRUE;
				dropList = list(/obj/item/SENZU_BEAN,/obj/item/PINK_BRACERS,/obj/item/PINK_BOOTS,/obj/item/PURPLE_COLLAR)
				alliedType = list(/mob/NPA/korins/GarlicJr,/mob/NPA/korins/Vinegar,/mob/NPA/korins/Mustard,/mob/NPA/korins/Salt)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,
								/Command/Technique/zanzoken)

				visuals = list("skin_color" = "{gGreen{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Shoulder Length",
								"hair_style" = "Spiked",
								"hair_color" = "{WWhite{x",
								"height" = "Tall",
								"build" = "Toned")

			Vinegar
				form = "Normal"
				name = "Vinegar"
				randomRespawn = FALSE;
				race = MAKYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = VERY_HARD
				currpl = 100000
				maxpl = 100000
				curreng = 120
				maxeng = 120
				AGGRO = TRUE;
				dropList = list(/obj/item/SENZU_BEAN,/obj/item/HORNED_HELMET)
				alliedType = list(/mob/NPA/korins/GarlicJr,/mob/NPA/korins/Spice,/mob/NPA/korins/Mustard,/mob/NPA/korins/Salt)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,
								/Command/Technique/zanzoken)

				visuals = list("skin_color" = "{mPurple{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "{yBrown{x",
								"height" = "Tall",
								"build" = "Muscular")

			Mustard
				form = "Normal"
				name = "Mustard"
				randomRespawn = FALSE;
				race = MAKYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = VERY_HARD
				currpl = 75000
				maxpl = 75000
				curreng = 120
				maxeng = 120
				AGGRO = TRUE;
				dropList = list(/obj/item/SENZU_BEAN)
				alliedType = list(/mob/NPA/korins/GarlicJr,/mob/NPA/korins/Spice,/mob/NPA/korins/Vinegar,/mob/NPA/korins/Salt)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,
								/Command/Technique/zanzoken)

				visuals = list("skin_color" = "{yBrown{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "{RRed{x",
								"height" = "Tall",
								"build" = "Toned")

			Salt
				form = "Normal"
				name = "Salt"
				randomRespawn = FALSE;
				race = MAKYAN
				hostile = TRUE
				sex = MALE
				alignment = EVIL
				difficultyLevel = VERY_HARD
				currpl = 50000
				maxpl = 50000
				curreng = 120
				maxeng = 120
				AGGRO = TRUE;
				dropList = list(/obj/item/SENZU_BEAN)
				alliedType = list(/mob/NPA/korins/GarlicJr,/mob/NPA/korins/Spice,/mob/NPA/korins/Vinegar,/mob/NPA/korins/Mustard)
				techniques = list(/Command/Technique/elbow,/Command/Technique/hammer,/Command/Technique/uppercut,
								/Command/Technique/zanzoken)

				visuals = list("skin_color" = "{RRed{x",
								"eye_color" = "{RRed{x",
								"hair_length" = "Long",
								"hair_style" = "Messy",
								"hair_color" = "{yBrown{x",
								"height" = "Short",
								"build" = "Toned")