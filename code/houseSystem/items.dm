obj
	item
		HOUSESYSTEM
			var
				owner = NULL

			CAPSULE
				STACKABLE = TRUE
				MISC = TRUE

				proc
					install(mob/user) {
						var/upgradeName = houseSystem._getNameFromPath(houseSystem.CAPSULES, type)
						var/upgradePath = houseSystem.UPGRADES[upgradeName]
						//Spawn a new object of the specific type
						var/obj/item/HOUSESYSTEM/UPGRADES/U = new upgradePath(user.loc)

						//Set the object attributes
						U.loc = user.loc
						U:owner = user.name

						U.insideBuilding = user.insideBuilding

						//Save to DB
						U.save()
						U.dBID = houseSystem.getLastID(houseSystem.DBUPGRADESTABLE)

						//Update and save the turf information

						user.loc:addUpgrade(upgradeName)
					}

				ENTRANCE
					DESC = "A capsule with a small door logo on it. This room will serve as the starter room of your house."
					PREFIX = "an "
					DISPLAY = "Entrance Capsule"
					PRICE = 100000
					SHOW_ITEMDB = FALSE;

				ROOM
					DESC = "A capsule with a small empty room logo on it. This generic room can be used for multiple purposes or for hallway connections."
					PREFIX = "a "
					DISPLAY = "Room Capsule"
					PRICE = 70000
					SHOW_ITEMDB = FALSE;

				STORAGE
					DESC = "A capsule that with a small chest logo on it. A storage room where to keep personal belongings."
					PREFIX = "a "
					DISPLAY = "Storage Room Capsule"
					PRICE = 200000
					SHOW_ITEMDB = FALSE;

				TRAINING
					DESC = "A capsule that with a fist logo on it. A dojo provides the necessary space for martial artists to practice their moves in a safe environment."
					PREFIX = "a "
					DISPLAY = "Dojo Capsule"
					PRICE = 300000
					SHOW_ITEMDB = FALSE;

				MEDBAY
					DESC = "A capsule that with a red cross logo on it. A resting room where the owner can relax and heal their wounds."
					PREFIX = "a "
					DISPLAY = "Rest Room Capsule"
					PRICE = 200000
					SHOW_ITEMDB = FALSE;

				DRESSER
					DESC = "A capsule that with a wardrobe logo on it. A dresser provides the neccessary space to stash clothes and change your physical appearance."
					PREFIX = "a "
					DISPLAY = "Dresser Capsule"
					PRICE = 200000
					SHOW_ITEMDB = FALSE;

				TROOM
					DESC = "A capsule that with a pad logo on it. A teleporter room provides a dedicated safe space for teleport-capable people to get into their home."
					PREFIX = "a "
					DISPLAY = "Teleport Room Capsule"
					PRICE = 200000
					SHOW_ITEMDB = FALSE;

				STASH
					DESC = "A home decoration that serves as a container to keep personal items."
					PREFIX = "a "
					DISPLAY = "Stash Module"
					PRICE = 60000
					SHOW_ITEMDB = FALSE;

				TCONSOLE
					DESC = "A dojo accessory granting its owner with a personal training bots to help practice on different difficulty levels."
					PREFIX = "a "
					DISPLAY = "Training Console"
					PRICE = 200000
					SHOW_ITEMDB = FALSE;

				TPAD
					DESC = "A home accessory that allows its owner to quickly teleport to the room containing this upgrade."
					PREFIX = "a "
					DISPLAY = "Teleporter Module"
					PRICE = 250000
					SHOW_ITEMDB = FALSE;

				GRAVITYGEN
					DESC = "A dojo accessory that allows to manipulate the gravity of the room where it is installed."
					PREFIX = "a "
					DISPLAY = "Gravity Generator Module"
					PRICE = 350000
					SHOW_ITEMDB = FALSE;

				TSHIELD
					DESC = "A home accessory that prevents unwelcome guests to teleport into a home room."
					PREFIX = "a "
					DISPLAY = "Teleport Shield Module"
					PRICE = 90000
					SHOW_ITEMDB = FALSE;

				MEDPOD
					DESC = "A regeneration module that decreases recovery time for wounds and bruises."
					PREFIX = "a "
					DISPLAY = "MedPod Module"
					PRICE = 150000
					SHOW_ITEMDB = FALSE;

				WARDROBE
					DESC = "A home decoration that allows the owner to modify some of his physical traits and complete sets of equipment."
					PREFIX = "a "
					DISPLAY = "Wardrobe Module"
					PRICE = 80000
					SHOW_ITEMDB = FALSE;

				OXYGENGENERATOR
					DESC = "A oxygen generator that allows you to survive on planets with no atmosphere."
					PREFIX = "a "
					DISPLAY = "Oxygen Generator Module"
					PRICE = 150000
					SHOW_ITEMDB = FALSE;

			UPGRADES
				STACKABLE = FALSE
				MISC = TRUE
				DESTRUCTABLE = FALSE
				DECAY = FALSE
				CAN_DROP = FALSE
				CAN_PICKUP = FALSE
				CONTAINER = FALSE
				CAN_STASH = FALSE
				SHOW_IN_MAP = FALSE
				insideBuilding = FALSE

				var
					list/allowedAccess = list()
					list/CONFIGURABLEVALUES = list()

				proc
					attributesForDB() {
						. = list("allowedaccess" = list2params(allowedAccess))
					}

					loadAttributes(list/attrList) {
						if (attrList["allowedaccess"]) {
							allowedAccess = params2list(attrList["allowedaccess"])
						} else {
							allowedAccess = list()
						}
					}

					isOwner(mob/user) {
						return user.name == owner
					}

					hasAccess(mob/user) {
						if (isOwner(user) || isAllowed(user.name) || !owner) {
							return TRUE
						}

						return FALSE
					}

					giveAccess(name) {
						if (!(name in allowedAccess)) {
							allowedAccess += name
						}

						save()
					}

					isAllowed(name) {
						return (name in allowedAccess)
					}

					removeAccess(name) {
						if ((name in allowedAccess)) {
							allowedAccess -= name
						}

						save()
					}

					preConfig(mob/m, setting, value) {
						alaparser.parse(m, "say Set [DISPLAY] {Y[setting]{x to {R[value]{x.")

						if (!value) {
							return "Please specify a value for {Y[setting]{x."
						}
						return config(m, setting, value)
					}

					config(mob/m, setting, value) {
						return "[DISPLAY] {Y[setting]{x set to {R[value]{x."
					}

					save() {
						var/list/locDB[0]
						locDB["x"] = loc.x
						locDB["y"] = loc.y
						locDB["z"] = loc.z

						houseSystem._saveUpgradeToDB(locDB, type, attributesForDB(), owner, dBID)
					}

					uninstall(mob/user, var/returnCapsule=TRUE) {
						var/upgradeName = houseSystem._getNameFromPath(houseSystem.UPGRADES, type)
						if (returnCapsule) {
							//Create a capsule to give back to the user
							var/capsulePath = houseSystem.CAPSULES[upgradeName]
							var/obj/item/HOUSESYSTEM/CAPSULE/C = new capsulePath
							user.addInv(C)
							send("You push a button and [PREFIX][DISPLAY] collapses into a capsule.", user)
							send("[user.raceColor(user.name)] pushes a button and [PREFIX][DISPLAY] collapses into a capsule.", _ohearers(user, 0))
						}

						//delete from DB
						houseSystem._deleteUpgradeFromDB(dBID)

						//Update and save the turf information
						user.loc:removeUpgrade(upgradeName)

						//delete the object
						del src
					}

				STASH
					DESC = "A container that allows to store personal items."
					PREFIX = "a "
					DISPLAY = "Stash"
					CONTAINER = TRUE
					MAX_ITEMS = 15
					CONFIGURABLEVALUES = list("display")
					SHOW_ITEMDB = FALSE;

					uninstall(mob/user) {
						if (contents.len > 0) {
							loot(user)
						}
						..()
					}

					stash(mob/m, obj/item/I) {
						if (contents.len < MAX_ITEMS) {
							if(!I.CAN_STASH){
								send("You can't stash this!", m);
								return FALSE;
							}

							send("You put [I:PREFIX][I:DISPLAY] inside [PREFIX][DISPLAY]",m)
							send("[m.raceColor(m.name)] places [I:PREFIX][I:DISPLAY] inside [PREFIX][DISPLAY].",_ohearers(0,m))

							var/tmpItem = new I.type
							src.addItem(tmpItem)
							m.destroyItem(I)

							//Save to DB
							save()
							return TRUE
						}

						send("You cannot put anymore items in [PREFIX][DISPLAY]", m)
						return FALSE
					}

					displayContents(mob/m) {
						if (hasAccess(m)) {
							..()
							return
						}

						send("You cannot open this.", m)
					}

					loot(mob/m, obj/item/I) {
						if (hasAccess(m)) {
							..()
							save()
							return
						}

						send("You cannot open this.", m)
					}

					config(mob/m, setting, value) {
						var/origDisplay = DISPLAY
						DISPLAY = value
						save()
						return "[origDisplay] [setting] set to [value]"
					}

					attributesForDB() {
						// Return a list with attributes that can be converted with list2params
						. = ..()
						var/list/contentPaths[0]
						for(var/obj/I in contents) {
							if (I.type in contentPaths) {
								contentPaths[I.type] += 1
								continue
							}

							contentPaths[I.type] = 1
						}

						var/list/finalContents = list()
						for(var/P in contentPaths) {
							finalContents += "[P]:[contentPaths[P]]"
						}

						if (finalContents.len > 0)
							.["contents"] = list2params(finalContents)

						.["display"] = src.DISPLAY
					}

					loadAttributes(list/attrList) {
						..()
						for(var/attr in attrList) {
							switch(attr) {
								if ("contents") {
									//Load the contents, create an object and add it to this objects contents
									var/list/dbContents = params2list(attrList[attr])

									for(var/C in dbContents) {
										//find the : to split the path and the number to create
										var/sep = findtext(C, ":")
										var/objPath = text2path(copytext(C, 1, sep))
										var/quantity = copytext(C, sep+1)

										for(var/n = 0; n < text2num(quantity); n++) {
											var/obj/item/I = new objPath
											if(I.CAN_STASH){
												src.contents += I
											}else{
												del(I);
											}
										}
									}
								}
								if ("display") {
									src.DISPLAY = attrList[attr]
								}
							}
						}
					}

				STASH
					WARDROBE
						DESC = "A closet that can contain a limited amount of items and allows to change your appearance."
						PREFIX = "a "
						DISPLAY = "Wardrobe"
						CONTAINER = TRUE
						MAX_ITEMS = EQUIPMENT_SLOTS
						SHOW_ITEMDB = FALSE;

						displayContents(mob/m) {
							if (hasAccess(m)) {
								var/list/tempContents = contents.Copy()
								var/list/buffer = list()
								buffer += "You open the wardrobe and see:\n\n"
								for(var/i=1,i<EQUIPMENT_SLOTS,i++){
									var/list/eqMatches = _searchListForItemWithSlot(i, tempContents)

									if (eqMatches.len > 0) {
										var/obj/item/eq = eqMatches[1]
										buffer += "<al26>{Y\[{x{R[uppertext(_getSlotName(i))]{x{Y\]{x</a> [eq.DISPLAY]\n"
										tempContents.Remove(eq)
									} else {
										buffer += "<al26>{Y\[{x{R[uppertext(_getSlotName(i))]{x{Y\]{x</a> {REmpty.{x\n"
									}
								}
								send(format_text(implodetext(buffer, "")), m)
								return
							}

							send("You cannot open this.", m)
						}

						stash(mob/m, obj/item/I) {
							if (!I.EQUIPABLE) {
								send("You can only place equipment in a wardrobe", m)
								return
							}

							// Look for an item with the target slot in the object
							var/list/eqMatches = _searchListForItemWithSlot(I.SLOT)
							if (eqMatches.len >= 1 && I.SLOT != FINGERS || eqMatches.len == 2 && I.SLOT == FINGERS) {
								send("An item already exists in that slot", m)
								return
							}

							return ..(m, I)
						}

						proc
							switchEq(mob/m) {
								var/list/tempContents = contents.Copy()
								for (var/i = 1; i < EQUIPMENT_SLOTS; i++) {
									var/list/eqMatches = _searchListForItemWithSlot(i, tempContents)

									var/obj/item/equippedItem = m.equipment[i]
									if (equippedItem) {
										m.removeItem(equippedItem, m)
									}

									if (eqMatches.len > 0) {
										var/obj/item/I = eqMatches[1]
										if (I) {
											contents -= I
											tempContents -= I
											m.equipItem(I,m)
										}
									}

									if (equippedItem) {
										stash(m, equippedItem)
									}
								}

								del tempContents
							}

							storeEq(mob/m) {
								for (var/i = 1; i < EQUIPMENT_SLOTS; i++) {
									var/list/eqMatches = _searchListForItemWithSlot(i)
									var/obj/item/equippedItem = m.equipment[i]
									if (equippedItem) {
										if (eqMatches.len > 0 && !(i in list(LEFT_FINGER, RIGHT_FINGER)) || eqMatches.len == 2 && (i in list(LEFT_FINGER, RIGHT_FINGER))) {
											send("There is already something in stored in the [_getSlotName(i)] slot", m)
											continue
										}

										//Remove the item while muting send calls
										m.removeItem(equippedItem, m, TRUE);
										stash(m, equippedItem)
									}
								}
							}

							_getSlotName(var/slot) {
								if ((slot in list(LEFT_FINGER, RIGHT_FINGER))) {
									return "fingers"
								}

								return _getName(slot)
							}

							_searchListForItemWithSlot(var/slot, var/list/C=contents) {
								var/list/matches = list()
								for(var/obj/item/I in C) {
									if (I.SLOT == slot) {
										matches += I
										return matches
									} else if (I.SLOT == FINGERS && (slot in list(LEFT_FINGER, RIGHT_FINGER))) {
										matches += I
										if (matches.len == 2) {
											return matches
										}
									}
								}

								return matches
							}

				TPAD
					DESC = "A pad equipped with a device that emits a very low energy signature only known to its owner."
					PREFIX = "a "
					DISPLAY = "Teleporter Pad"
					CONFIGURABLEVALUES = list("name")
					SHOW_ITEMDB = FALSE;

					var
						teleportName = NULL

					attributesForDB()
					{
						. = ..()
						.["name"] = teleportName
					}

					loadAttributes(list/attrList)
					{
						..()
						if (attrList["name"]) {
							teleportName = attrList["name"]
						}
					}

					config(mob/m, setting, value) {
						teleportName = value
						save()
						return ..()
					}

					New() {
						game.teleporters += src
					}

				TSHIELD
					DESC = "A set of special plates that allow to mask energy signatures inside the room."
					PREFIX = "a "
					DISPLAY = "Teleport Shield"
					SHOW_ITEMDB = FALSE;

				New(Loc) {
					..()
					if(Loc){ Loc:itLocked = TRUE }
				}

				MEDPOD
					DESC = "A big glass capsule that allows to increase the regeneration rate of the people in the room."
					PREFIX = "a "
					DISPLAY = "Medical Pod"
					CONTAINER = TRUE
					SHOW_ITEMDB = FALSE;

					var
						inUse = FALSE
						mob/currentUser = NULL
						monitorDelay = 15 SECONDS
						monitorMaxDistance = 1

					proc
						_monitorUse() {
							set waitfor = FALSE;
							set background = TRUE;

							//validate that the interactable item is still in use when currentUser is not NULL
							while(currentUser) {
								//Check if target is in the same area
								if (currentUser.loc.loc != loc.loc) {
									break
								}

								//Check the target's distance
								if(a_get_dist(src, currentUser) > monitorMaxDistance) {
									break
								}
								sleep(monitorDelay)
							}

							src._cleanup()
						}

						enter(mob/m) {
							if (!hasAccess(m) && !m.isImm) {
								send("You try to open [PREFIX][DISPLAY] but it won't open for you.", m)
								send("[m.raceColor(m.name)] tries to open [PREFIX][DISPLAY] but it won't open for [m.determineSex(1)].", _ohearers(0, m))
								return
							}

							if (m.insideMedPod) {
								send("You are already inside [DISPLAY]", m)
								return
							}

							if (inUse) {
								send("There is no room for you in [DISPLAY]", m)
								return
							}

							send("You climb into [DISPLAY] and relax as {ggreen{x liquid fills the container.", m)
							send("[m.raceColor(m.name)] climbs into [DISPLAY] and relaxes as {ggreen{x liquid fills the container.", _ohearers(0, m))
							m.insideMedPod = TRUE
							inUse = TRUE
							currentUser = m
							_monitorUse()
						}

						exit(mob/m) {
							if (!m.insideMedPod) {
								send("You are not inside [DISPLAY]", m)
								return
							}

							send("The liquid splashes out of the container as you emerge from it.", m)
							send("The liquid splashes out of the container as [m.raceColor(m.name)] emerges from it.", _ohearers(0, m))
							m.insideMedPod = FALSE
							_cleanup()
						}

						_cleanup() {
							inUse = FALSE
							currentUser = NULL
						}

				OXYGENGENERATOR
					DESC = "A oxygen generator that allows you to survive on planets with no atmosphere."
					PREFIX = "a "
					DISPLAY = "Oxygen Generator"
					SHOW_ITEMDB = FALSE;

				INTERACTABLE
					var
						mob/currentUser = NULL
						monitorDelay = 15 SECONDS
						monitorMaxDistance = 30

					proc
						_checkAccess(mob/m, list/receivers, var/mute = FALSE) {
							if (!hasAccess(m) && !m:isImm) {
								if (!mute) {
									send("[m.raceColor(m.name)] tries to interact with [PREFIX][DISPLAY]", receivers)
									send("{CThe screen displays, '{RUNAUTHORIZED ACCESS{x.'", receivers)
								}
								return FALSE
							}

							return TRUE
						}

						_monitorUse() {
							set waitfor = FALSE;
							set background = TRUE;

							//validate that the interactable item is still in use when currentUser is not NULL
							while(currentUser) {
								//Check if target is in the same area
								if (currentUser.loc.loc != loc.loc) {
									break
								}

								//Check the target's distance
								if(a_get_dist(src, currentUser) > monitorMaxDistance) {
									break
								}
								sleep(monitorDelay)
							}

							src._stop()
						}

						_start() {}

						_stop() {}

					TCONSOLE
						DESC = "A console to configure training bot parameters and quickly create new training bots."
						PREFIX = "a "
						DISPLAY = "Training Console"
						CONFIGURABLEVALUES = list("matchpl", "difficulty", "pl", "addtech", "removetech", "defaults", "cleartechs", "armor", "strength", "stamina", "ki")
						SHOW_ITEMDB = FALSE;

						var
							list/MATCHPL_TRUE = list("yes", "1", "true")
							list/MATCHPL_FALSE = list("no", "0", "false")
							list/VALID_TECHNIQUES = list()
							list/INVALID_TECHNIQUES = list()
							DIFFICULTIES[0]
							list/defaultTechniques = list()
							list/techniques = list()
							mob/NPA/currentBot = NULL
							list/mobAttr[0]

							matchPL = FALSE
							difficulty = VERY_EASY
							setPL = NULL

							armorOverride = NULL
							strOverride = NULL
							kiOverride = NULL
							staOverride = NULL

						New() {
							..()
							DIFFICULTIES["very easy"] = VERY_EASY
							DIFFICULTIES["easy"] = EASY
							DIFFICULTIES["medium"] = MEDIUM
							DIFFICULTIES["hard"] = HARD
							DIFFICULTIES["very hard"] = VERY_HARD
							DIFFICULTIES["fusion"] = FUSION
							DIFFICULTIES["heroic"] = HEROIC
							DIFFICULTIES["god"] = GOD

							//default techniques
							defaultTechniques = list("fly",
											"punch",
											"parry",
											"kick",
											"sweep",
											"roundhouse",
											"power",
											"deflect",
											"dodge",
											"jump",
											"duck")

							techniques = defaultTechniques

							//Setup techniques
							INVALID_TECHNIQUES = list("enhance",
													"mask",
													"upgrade",
													"assimilate",
													"kaioken",
													"revert",
													"scan",
													"sense",
													"snapneck",
													"summon",
													"teleport",
													"ultrainstinctomen",
													"genie assimilate",
													"candybeam",
													"genie regeneration",
													"mystic",
													"spirit_burst",
													"form 2",
													"form 3",
													"form 4",
													"form 5",
													"instantaneousmovement",
													"fullkaioken",
													"namek fuse",
													"namek regeneration",
													"ssj",
													"ssj2",
													"ssj3",
													"ssj4",
													"ssjb",
													"ssjr",
													"ssjg"
													)
							VALID_TECHNIQUES = game.skillList - INVALID_TECHNIQUES

						}

						attributesForDB() {
							. = ..()
							.["matchpl"] = matchPL
							.["difficulty"] = difficulty
							if(setPL) {
								.["setpl"] = num2text(setPL)
							}
							.["techniques"] = list2params(techniques)

							if (armorOverride)
								.["armor"] = armorOverride

							if (strOverride)
								.["str"] = strOverride

							if (kiOverride)
								.["ki"] = kiOverride

							if (staOverride)
								.["sta"] = staOverride
						}

						loadAttributes(list/attrList) {
							..()
							if (attrList["matchpl"]) {
								var/val = text2num(attrList["matchpl"])
								matchPL = val && val == 1 ? TRUE : FALSE
							}
							if (attrList["difficulty"]) {
								difficulty = attrList["difficulty"]
							}
							if(attrList["setpl"]) {
								setPL = text2num(attrList["setpl"])
							}
							if(attrList["techniques"]) {
								techniques = params2list(attrList["techniques"])
							}
							if(attrList["armor"]) {
								armorOverride = text2num(attrList["armor"])
							}
							if(attrList["str"]) {
								armorOverride = text2num(attrList["str"])
							}
							if(attrList["ki"]) {
								armorOverride = text2num(attrList["ki"])
							}
							if(attrList["sta"]) {
								armorOverride = text2num(attrList["sta"])
							}
						}

						preConfig(mob/m, setting, value) {
							var/settingMsg = "{Y[setting]{x"
							var/list/changeMsg = list("pl", "matchpl", "difficulty")
							if (setting in changeMsg) {
								settingMsg = "set {Y[setting]{x"
							}
							var/list/allowWithoutValue = list("defaults", "cleartechs")
							var/valMsg = value && !(setting in allowWithoutValue) ? " {R[value]{x" : ""
							alaparser.parse(m, "say [DISPLAY], [settingMsg][valMsg].")

							var/check = (setting in allowWithoutValue)
							if (check || value) {
								return config(m, setting, value)
							}

							return "Please specify a value for {Y[setting]{x"
						}

						config(mob/m, setting, value) {
							if (!_checkAccess(m, m.getAllRoom(), TRUE)) {
								return "You are not authorized to change settings on [PREFIX][DISPLAY]"
							}

							if (currentBot) {
								return "You cannot change [PREFIX][DISPLAY] settings while [currentBot.raceColor(currentBot.name)] is {GACTIVE{x."
							}

							switch(setting) {
								if("stamina") {
									staOverride = text2num(value)
									save()
									return "Training bot {Y[setting]{x set to {R[value]{x."
								}
								if("ki") {
									kiOverride= text2num(value)
									save()
									return "Training bot {Y[setting]{x set to {R[value]{x."
								}
								if("strength") {
									strOverride= text2num(value)
									save()
									return "Training bot {Y[setting]{x set to {R[value]{x."
								}
								if("armor") {
									armorOverride= text2num(value)
									save()
									return "Training bot {Y[setting]{x set to {R[value]{x."
								}
								if("cleartechs") {
									techniques = list()
									save()
									return "Training bot skills have been cleared."
								}
								if("defaults") {
									techniques = defaultTechniques
									matchPL = FALSE
									setPL = NULL
									difficulty = VERY_EASY
									armorOverride = NULL
									strOverride = NULL
									kiOverride = NULL
									staOverride = NULL
									save()
									return "Training settings reset to defaults."
								}
								if("removetech") {
									if (_checkValue(VALID_TECHNIQUES, value)) {
										if (value in techniques) {
											techniques -= value
											save()
											return "Skill {Y[value]{x removed from training bot skill list."
										}

										return "Skill {Y[value]{x is not on the skill list."
									}

									return "Invalid skill name."
								}
								if("addtech") {
									if (_checkValue(VALID_TECHNIQUES, value)) {
										techniques += value
										save()
										return "Skill {Y[value]{x added to training bot skill list."
									}

									if (_checkValue(INVALID_TECHNIQUES, value)) {
										return "That skill is not available for this training setting. Valid techniques are: [__listToText(VALID_TECHNIQUES, ", ")]."
									}

									return "Invalid value. Valid techniques are: [__listToText(VALID_TECHNIQUES, ", ")]."
								}
								if("pl") {
									var/numValue = text2num(value)

									if (numValue) {
										if (numValue > MIN_PL + 5) {
											var/msg = matchPL ? "[DISPLAY] [setting] set to [value]. matchpl has been disabled." : ..()
											matchPL = FALSE
											setPL = numValue
											save()

											return msg
										}

										return "[setting] cannot be lower than [MIN_PL + 5]"
									}

									return "Invalid value."
								}
								if("matchpl") {
									var/list/VALIDV = MATCHPL_TRUE + MATCHPL_FALSE
									if (_checkValue(VALIDV, value)) {
										var/result = FALSE
										if (value in MATCHPL_TRUE)
											result = TRUE

										matchPL = result
										setPL = NULL
										save()
										return ..()
									}

									return "Invalid value."
								}
								if("difficulty") {
									if (_checkValue(DIFFICULTIES, value))
									{
										difficulty = DIFFICULTIES[value]

										save()
										return ..()
									}

									return "Invalid difficulty. Valid choices are: [__listToText(DIFFICULTIES, ", ")]"
								}
							}
						}

						_start(mob/m) {
							_createTrainingBot(m)
							currentUser = m
							_monitorUse()
						}

						_stop() {
							if (currentBot) {
								del currentBot
							}

							currentBot = NULL
							currentUser = NULL
						}

						proc
							_checkValue(list/values, value) {
								for(var/V in values) {
									if (TextMatch(lowertext(value), lowertext(V), 1, 1))
										return TRUE
								}

								return FALSE
							}

							preStart(mob/m) {
								if (!_checkAccess(m, m.getAllRoom())) {
									return
								}

								if (currentUser && currentUser != m) {
									send("You cannot use this right now. The screen displays: {YIN USE BY{x [currentUser.raceColor(currentUser.name)]", m)
									return
								}

								if (!currentBot) {
									_start(m)
									send("You press the {GACTIVATE{x button and [currentBot.raceColor(currentBot.name)] moves out of its charging station.", m)
									send("[m.raceColor(m.name)] presses the {GACTIVATE{x button and [currentBot.raceColor(currentBot.name)] moves out of its charging station.", _ohearers(0, m))
									return
								}

								send("You see {WTraining Bot:{x [currentBot.raceColor(currentBot.name)] is {GACTIVE{x.", m)
							}

							_createTrainingBot(mob/m) {
								var/mob/T = new /mob/NPA/HOUSESYSTEM/TrainingBot
								T.loc = m.loc
								T:insideBuilding = m.insideBuilding
								if (matchPL) {
									T.maxpl = m.getMaxPL()
									T.currpl = T.maxpl
								} else if (setPL) {
									T.maxpl = setPL
									T.currpl = T.maxpl
								}
								T:difficultyLevel = text2num(difficulty)
								var/list/techs = list()
								for(var/techName in techniques) {
									techs += game.skillList[techName]
								}
								T.techniques = techs

								if (armorOverride)
									T:armorOverride = armorOverride

								if (strOverride)
									T:strOverride = strOverride

								if (kiOverride)
									T:kiOverride = kiOverride

								if (staOverride)
									T:staOverride = staOverride

								T:curreng = T:getMaxEN()
								T:trainingConsole = src

								currentBot = T
							}

							preStop(mob/m) {
								if (!_checkAccess(m, m.getAllRoom())) {
									return
								}

								if (currentUser && currentUser != m && m.name != owner) {
									send("You cannot stop this right now. The screen displays: {YIN USE BY{x [currentUser.raceColor(currentUser.name)]", m)
									return
								}

								if (currentBot) {
									send("You press the {RDEACTIVATE{x button and [currentBot.raceColor(currentBot.name)] moves back to its charging station.", m)
									send("[m.raceColor(m.name)] presses the {RDEACTIVATE{x button and [currentBot.raceColor(currentBot.name)] moves back to its charging station.", _ohearers(0, m))
									_stop()
									return
								}

								send("You reach to press the stop button and see {CStatus:{x {RINACTIVE{x on the screen.", m)
								return
							}

					GRAVITYGEN
						DESC = "A big machine that allows to manipulate the gravity of the room."
						PREFIX = "a "
						DISPLAY = "Gravity Generator"
						CONFIGURABLEVALUES = list("gravity")
						monitorMaxDistance = 10
						SHOW_ITEMDB = FALSE;

						var
							gravity = NULL
							started = FALSE

						attributesForDB() {
							. = ..()
							.["gravity"] = gravity
						}

						loadAttributes(list/attrList) {
							..()
							if (attrList["gravity"]) {
								gravity = text2num(attrList["gravity"])
							}
						}

						config(mob/m, setting, value) {
							if (!_checkAccess(m, m.getAllRoom(), TRUE)) {
								return "You are not authorized to change settings on [PREFIX][DISPLAY]"
							}

							if (started) {
								return "You cannot change [PREFIX][DISPLAY] settings while it is running."
							}

							var/targetG = text2num(value)
							if (targetG) {
								if (targetG > 100) {
									return "The maximum allowed value is 100."
								}

								gravity = targetG
								save()
								return ..()
							}

							return "Invalid value."
						}

						_start(mob/m) {
							loc:gravity = gravity
							started = TRUE
							currentUser = m
							if (m:getGravity() > 15) {
								m:_underGravity()
							}

							_monitorUse()
						}

						_stop() {
							loc:gravity = loc.loc:gravity
							started = FALSE
							currentUser = NULL
						}

						proc
							_defineGravityChangeMsg(mob/m, targetGravity) {
								var/currentGravity = text2num(m.getGravity())
								var/changeMsg = "feel no change on your weight."
								if (targetGravity > currentGravity) {
									changeMsg = "feel your body become heavier."
								} else if (targetGravity < currentGravity) {
									changeMsg = "feel your body become lighter."
								}

								return changeMsg
							}

							preStart(mob/m, confirm) {
								var/list/receivers = m.getAllRoom()
								// send("{CThe screen displays, '{RERROR:{x This device is currently under maintenance.'", receivers)
								// return
								if (!_checkAccess(m, receivers)) {
									return
								}

								if (currentUser && currentUser != m) {
									send("You cannot use this right now. The screen displays: {YIN USE BY{x [currentUser.raceColor(currentUser.name)]", m)
									return
								}

								if (!started)
								{
									if (gravity > 15 && !confirm || confirm && !TextMatch("confirm", confirm, 1, 1)) {
										send("{CThe screen displays, '{YWARNING:{x Strong gravity can cause serious injuries and even death. Please repeat your last command with {Cconfirm{x to start the generator.", m.getAllRoom())
										send("Syntax: {cstart{x <{cupgrade{x> confirm", m)
										return
									}

									var/changeMsg = _defineGravityChangeMsg(m, gravity)
									send("You hear a slight hum coming from the generator as it starts to change the gravity around it.", receivers)
									send("You [changeMsg]", receivers)
									_start(m)
									return
								}

								send("You reach to press the {Gstart{x button and see {CStatus:{x {GRUNNING{x on the screen.", m)
								return
							}

							preStop(mob/m, confirm) {
								var/list/receivers = m.getAllRoom()
								if (!_checkAccess(m, receivers)) {
									return
								}

								if (currentUser && currentUser != m && owner != m.name) {
									send("You cannot use this right now. The screen displays: {YIN USE BY{x [currentUser.raceColor(currentUser.name)]", m)
									return
								}

								if (started) {
									var/changeMsg = _defineGravityChangeMsg(m, loc.loc:gravity)
									send("You hear the generator's hum fade as it stops modifying the gravity around it.", receivers)
									send("You [changeMsg]", receivers)
									_stop()
									return
								}

								send("You reach to press the stop button and see {CStatus:{x {ROFF{x on the screen.", m)
								return
							}

			KEY
				DESC = "Object that allows entrance to someone's home."
				PREFIX = "a "
				DISPLAY = "House Key"
				STACKABLE = FALSE;
				MULTI = FALSE;
				SLOT = NULL;
				EDIBLE = FALSE;
				DESTRUCTABLE = TRUE;
				DECAY = TRUE;
				MISC = TRUE;
				SHOW_ITEMDB = FALSE;

				var
					doorLocation = NULL

				New(x, y, z) {
					doorLocation = locate(x, y, z)
				}
